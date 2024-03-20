import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:shield/page1.dart';
import 'package:shield/pages/page2.dart';

class Homelander extends StatefulWidget {
  const Homelander({Key? key}) : super(key: key);

  @override
  State<Homelander> createState() => _HomelanderState();
}

class _HomelanderState extends State<Homelander> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light.copyWith(
        statusBarColor: Colors.transparent,
      ),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Color.fromRGBO(245, 221, 219, 1),
          body: Stack(
            children: [
              Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color.fromRGBO(223, 143, 146, 1),
                      Color.fromRGBO(245, 221, 219, 1), // Start color
                      // End color
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),

              Positioned(
                top: 150,
                left: 0,
                right: 0,
                bottom: 0,
                child: CarouselSlider(
                  items: [
                    _buildCardContainer(
                      "assets/images/hilo.png",
                      () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => pageone()),
                        );
                      },
                    ),
                    _buildCardContainer(
                      "assets/images/hifo.png",
                      () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => pagetwo()),
                        );
                      },
                    ),
                  ],
                  options: CarouselOptions(
                    height: 200,
                    enlargeCenterPage: true,
                    autoPlay: true,
                    aspectRatio: 16 / 9,
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enableInfiniteScroll: true,
                    autoPlayAnimationDuration: Duration(milliseconds: 800),
                    viewportFraction: 0.8,
                  ),
                ),
              ),
              Positioned(
                top: 0,
                left: 16,
                right: 16,
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 70, bottom: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                          text: TextSpan(
                            style: DefaultTextStyle.of(context).style,
                            children: const [
                              TextSpan(
                                text: 'Level Up\n',
                                style: TextStyle(
                                  fontSize: 34,
                                  fontFamily: 'Koulen',
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              TextSpan(
                                text: 'your engagement',
                                style: TextStyle(
                                  fontSize: 40,
                                  fontFamily: 'Koulen',
                                  fontWeight: FontWeight.bold,
                                  color:
                                      const Color.fromARGB(255, 235, 120, 158),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 8),
                        const Text(
                          "Join the community today!",
                          style: TextStyle(
                            fontSize: 16,
                            fontStyle: FontStyle.italic,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(30),
                                child: Container(
                                  height: 50,
                                  decoration: BoxDecoration(
                                    color: Colors.black,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.3),
                                        spreadRadius: 2,
                                        blurRadius: 5,
                                        offset: const Offset(0, 3),
                                      ),
                                    ],
                                  ),
                                  child: ElevatedButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => CommunityPage(),
                                        ),
                                      );
                                    },
                                    style: ElevatedButton.styleFrom(
                                      side: BorderSide(
                                        color: Color.fromRGBO(235, 105, 144, 1),
                                        width: 2.0,
                                      ),
                                    ),
                                    child: const Text(
                                      "Get Started",
                                      style: TextStyle(
                                        fontStyle: FontStyle.italic,
                                        fontSize: 18,
                                        color: Color.fromRGBO(235, 105, 144, 1),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 25),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // Text below the card carousel
              Positioned(
                bottom: 20,
                left: 16,
                right: 16,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Sign up for our newsletter",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 1),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              hintText: "Enter your email",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        ElevatedButton(
                          onPressed: () {
                            // Handle subscription logic here
                          },
                          child: Text("Subscribe"),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCardContainer(String imageUrl, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.0),
            border: Border.all(
              color: Color.fromRGBO(235, 105, 144, 1),
              width: 2.0,
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16.0),
            child: Image.asset(
              imageUrl,
              height: 200,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}

class CommunityPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Community Page'),
      ),
      body: Center(
        child: Text('Welcome to the Community Page!'),
      ),
    );
  }
}
