import 'package:flutter/material.dart';

class pageone extends StatefulWidget {
  const pageone({super.key});

  @override
  State<pageone> createState() => _pageoneState();
}

class _pageoneState extends State<pageone> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('sup nigga')),
    );
  }
}
