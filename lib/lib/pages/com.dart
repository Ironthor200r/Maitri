import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ProfileMax extends StatefulWidget {
  const ProfileMax({Key? key}) : super(key: key);

  @override
  State<ProfileMax> createState() => _ProfileMaxState();
}

class _ProfileMaxState extends State<ProfileMax> {
  @override
  Widget build(BuildContext context) {
    // Hide the status bar by default
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light.copyWith(
        statusBarColor: Colors.transparent, // Make the status bar transparent
      ),
      child: Scaffold(
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
          ],
        ),
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
