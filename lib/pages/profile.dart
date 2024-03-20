import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'dart:math';
import 'dart:async';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          Center(
            child: SOSButton(),
          ),
        ],
      ),
    );
  }
}

class ConcaveBezelClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    final curveHeight = 10.0; // Adjust the curve height based on your design
    final edgeLowerHeight =
        50.0; // Adjust the height of the edges lower than the middle portion

    path.moveTo(0, 0);
    path.lineTo(0, size.height - curveHeight);
    path.quadraticBezierTo(
      size.width / 2 + 70,
      size.height - edgeLowerHeight,
      size.width,
      size.height - curveHeight,
    );
    path.lineTo(size.width, 0);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}

class SOSButton extends StatefulWidget {
  SOSButton({Key? key}) : super(key: key);

  @override
  _SOSButtonState createState() => _SOSButtonState();
}

class _SOSButtonState extends State<SOSButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  double _angle = 0.0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _controller.addListener(() {
      setState(() {
        _angle = _controller.value * 2 * pi;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _cancelTimer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        _controller.repeat();
        _startTimer();
      },
      onTapUp: (_) {
        _controller.stop();
        _controller.reset();
        _cancelTimer();
        _callAmbulance(); // Call ambulance when the button is released
      },
      child: Container(
        width: 250,
        height: 250,
        child: CustomPaint(
          painter: InsetShadowPainter(),
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: SweepGradient(
                colors: [
                  Color.fromRGBO(245, 221, 219, 1),
                  Color.fromRGBO(223, 143, 146, 1)
                ],
                stops: [0.7, 1.0],
                transform: GradientRotation(_angle),
              ),
            ),
            child: Center(
              child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color.fromRGBO(241, 163, 166, 1),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'SOS',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'press for 3 seconds',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _startTimer() {
    _timer = Timer(Duration(seconds: 3), () {
      // Trigger the phone call after 3 seconds
      _callAmbulance();
      _cancelTimer(); // Cancel the timer after making the call
    });
  }

  void _cancelTimer() {
    _timer?.cancel(); // Cancel the timer if it exists
    _timer = null; // Set timer to null
  }

  void _callAmbulance() async {
    String ambulanceNumber = '102'; // Specify the ambulance number here
    bool? res = await FlutterPhoneDirectCaller.callNumber(ambulanceNumber);
    if (res == true) {
      // Call successful
      print('Called ambulance');
    } else {
      // Handle call failure or null result
      print('Failed to call ambulance');
    }
  }
}

class InsetShadowPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final shadowPaint = Paint()
      ..color = Colors.white.withOpacity(0.5)
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, 15.0);

    final path = Path()
      ..addOval(Rect.fromCircle(
          center: size.center(Offset.zero), radius: size.width / 2));

    canvas.drawPath(path, shadowPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
