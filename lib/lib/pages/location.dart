import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:dio/dio.dart';
import 'package:url_launcher/url_launcher.dart';

class NearbyTemplesPage extends StatefulWidget {
  const NearbyTemplesPage({Key? key}) : super(key: key);

  @override
  _NearbyTemplesPageState createState() => _NearbyTemplesPageState();
}

class _NearbyTemplesPageState extends State<NearbyTemplesPage> {
  Position? _userLocation;
  List<Place>? _nearbyPlaces;
  List<Place>? _filteredPlaces;

  final TextEditingController _searchController = TextEditingController();

  final Dio _dio = Dio(); // Use a single Dio instance for efficiency

  @override
  void initState() {
    super.initState();
    _getUserLocation();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _dio.close(); // Close Dio instance when no longer needed
    super.dispose();
  }

  Future<void> _getUserLocation() async {
    try {
      LocationPermission permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        print("User denied location permission");
      } else if (permission == LocationPermission.deniedForever) {
        print("User permanently denied location permission");
      } else {
        Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best,
        );
        setState(() {
          _userLocation = position;
        });
        _getNearbyPlacesWithDelay();
      }
    } catch (e) {
      print("Error getting location: $e");
    }
  }

  Future<void> _getNearbyPlacesWithDelay() async {
    await Future.delayed(Duration(seconds: 10)); // Delay by 10 seconds

    if (_userLocation != null) {
      _getNearbyPlaces();
    }
  }

  Future<void> _getNearbyPlaces() async {
    try {
      if (_userLocation == null) {
        print("User location is null. Aborting nearby places fetch.");
        return;
      }

      const apiKey = 'AIzaSyC5VGRcbkpqGWJxjPiw6LYxoDxHhKK6_JE';
      const radius = 5000;

      _dio.interceptors.add(InterceptorsWrapper(
        onRequest: (options, handler) {
          print("Dio Request: ${options.uri}");
          return handler.next(options);
        },
      ));

      final response = await _dio.get(
        'https://maps.googleapis.com/maps/api/place/nearbysearch/json',
        queryParameters: {
          'location': '${_userLocation!.latitude},${_userLocation!.longitude}',
          'radius': radius,
          'key': 'AIzaSyC5VGRcbkpqGWJxjPiw6LYxoDxHhKK6_JE',
          'keyword': 'hospital',
        },
      );

      if (response.statusCode == 200) {
        final results = response.data['results'] as List<dynamic>;
        print("Results: $results");
        final nearbyPlaces = await _fetchETAs(results);

        setState(() {
          _nearbyPlaces = nearbyPlaces;
          _filteredPlaces = _nearbyPlaces;
        });
      } else {
        print(
            "Error getting nearby places. Status code: ${response.statusCode}");
        print("Response body: ${response.data}");
      }
    } catch (e) {
      print("Error getting nearby places: $e");
    }
  }

  Future<List<Place>> _fetchETAs(List<dynamic> places) async {
    final List<Place> nearbyPlaces = [];

    for (final placeData in places) {
      final Place place = Place.fromMap(placeData);

      try {
        final response = await _dio.get(
          'https://maps.googleapis.com/maps/api/distancematrix/json',
          queryParameters: {
            'origins': '${_userLocation!.latitude},${_userLocation!.longitude}',
            'destinations': '${place.latitude},${place.longitude}',
            'mode': 'driving',
            'key': 'AIzaSyC5VGRcbkpqGWJxjPiw6LYxoDxHhKK6_JE ',
          },
        );

        if (response.statusCode == 200) {
          final durationInSeconds =
              response.data['rows'][0]['elements'][0]['duration']['value'];
          final double distanceInKilometers = response.data['rows'][0]
                  ['elements'][0]['distance']['value'] /
              1000.0;

          place.distance = distanceInKilometers;
          place.etaInMinutes = (durationInSeconds / 60).ceil();

          nearbyPlaces.add(place);
        } else {
          print(
              "Error fetching ETA for ${place.name}. Status code: ${response.statusCode}");
          print("Response body: ${response.data}");
        }
      } catch (e) {
        print("Error fetching ETA for ${place.name}: $e");
      }
    }

    return nearbyPlaces;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(
          223, 143, 146, 1), // Set the background color to transparent
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text(
          "Hospitals Nearby(नजदीकी अस्पताल)",
          style: TextStyle(
              fontSize: 25,
              fontFamily: 'Koulen',
              fontWeight: FontWeight.bold,
              color: Color.fromRGBO(245, 221, 219, 1)),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromRGBO(223, 143, 146, 1),
              Color.fromRGBO(245, 221, 219, 1), // Start color and end color
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          children: [
            _buildSearchBar(),
            Expanded(
              child: _buildBody(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: TextField(
            controller: _searchController,
            onChanged: _filterPlaces,
            decoration: InputDecoration(
              hintText: 'Search...',
              border: InputBorder.none,
              prefixIcon: Icon(Icons.search),
            ),
          ),
        ),
      ),
    );
  }

  void _filterPlaces(String query) {
    if (_nearbyPlaces != null) {
      setState(() {
        _filteredPlaces = _nearbyPlaces!
            .where((place) =>
                place.name.toLowerCase().contains(query.toLowerCase()))
            .toList();
      });
    }
  }

  Widget _buildBody() {
    if (_userLocation == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else if (_filteredPlaces == null) {
      // Display loading indicator until the results are fetched
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else if (_filteredPlaces!.isEmpty) {
      // Delay showing the "No nearby temples found" message by 10 seconds
      Future.delayed(Duration(seconds: 10), () {
        setState(() {});
      });

      return Center(
        child: Text(
          "No nearby temples found.",
          style: TextStyle(
            color: Colors.red, // Change color if needed
          ),
        ),
      );
    } else {
      return ListView.builder(
        itemCount: _filteredPlaces!.length,
        itemBuilder: (context, index) {
          final place = _filteredPlaces![index];
          return InkWell(
            onTap: () {
              _openGoogleMaps(place.latitude, place.longitude);
            },
            child: Card(
              color: Color.fromRGBO(245, 221, 219, 1),
              child: ListTile(
                leading: Icon(Icons.temple_hindu_sharp), // Temple icon
                title: Row(
                  children: [
                    Icon(Icons.directions_car), // Car icon
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        place.name,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
                subtitle: Text(
                  'Distance: ${place.distance.toStringAsFixed(2)} km | ETA: ${place.etaInMinutes} minutes',
                ),
              ),
            ),
          );
        },
      );
    }
  }

  void _openGoogleMaps(
      double destinationLatitude, double destinationLongitude) async {
    final origin = "${_userLocation!.latitude},${_userLocation!.longitude}";
    final destination = "$destinationLatitude,$destinationLongitude";

    final url =
        "https://www.google.com/maps/dir/?api=1&origin=$origin&destination=$destination";

    try {
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        print("Could not launch Google Maps: URL launch not supported");
      }
    } catch (e) {
      print("Error launching Google Maps: $e");
    }
  }
}

class Place {
  final String name;
  final double latitude;
  final double longitude;
  double distance;
  int etaInMinutes;

  Place(
      {required this.name,
      required this.latitude,
      required this.longitude,
      this.distance = 0,
      this.etaInMinutes = 0});

  factory Place.fromMap(Map<String, dynamic> map) {
    return Place(
      name: map['name'],
      latitude: map['geometry']['location']['lat'],
      longitude: map['geometry']['location']['lng'],
    );
  }
}
