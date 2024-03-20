import 'package:flutter/material.dart';

class pagetwo extends StatefulWidget {
  const pagetwo({super.key});

  @override
  State<pagetwo> createState() => _pagetwoState();
}

class _pagetwoState extends State<pagetwo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow,
        title: Text('yellow bitch'),
      ),
    );
  }
}
