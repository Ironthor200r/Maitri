import 'package:flutter/material.dart';

class ProfileDet extends StatefulWidget {
  const ProfileDet({Key? key}) : super(key: key);

  @override
  State<ProfileDet> createState() => _ProfileDetState();
}

class _ProfileDetState extends State<ProfileDet> {
  String? selectedOption;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DropdownButton<String>(
              hint: Text('Select option'),
              value: selectedOption,
              onChanged: (String? newValue) {
                setState(() {
                  selectedOption = newValue;
                  if (selectedOption == 'I am pregnant') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => WeekSelectionPage(),
                      ),
                    );
                  }
                });
              },
              items: <String>[
                'I am trying to be a mother',
                'I am a mother',
                'I am pregnant',
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}

class WeekSelectionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Week Selection'),
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 7,
        ),
        itemCount: 42,
        itemBuilder: (context, index) {
          // You can customize the cells according to your need
          return GestureDetector(
            onTap: () {
              DateTime currentDate = DateTime.now();
              DateTime dueDate =
                  currentDate.add(Duration(days: (42 - index) * 7));
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      DueDateCalculationPage(dueDate: dueDate),
                ),
              );
            },
            child: Container(
              alignment: Alignment.center,
              margin: EdgeInsets.all(4),
              decoration: BoxDecoration(
                border: Border.all(),
              ),
              child: Text('${index + 1}'),
            ),
          );
        },
      ),
    );
  }
}

class DueDateCalculationPage extends StatelessWidget {
  final DateTime dueDate;

  const DueDateCalculationPage({Key? key, required this.dueDate})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Due Date Calculation'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Due Date: ${dueDate.toString().substring(0, 10)}',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Redirect to the Profile page
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProfileDet(),
                  ),
                );
              },
              child: Text('Go to Profile'),
            ),
          ],
        ),
      ),
    );
  }
}
