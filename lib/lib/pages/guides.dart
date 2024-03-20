import 'package:flutter/material.dart';

class BreastfeedingGuidanceContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context);
        return false;
      },
      child: Scaffold(
        backgroundColor: Color(0xFFE19597),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text('Breastfeeding Guidance'),
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.fromLTRB(10, 60, 10, 20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFFE19597), // #e19597
                Color(0xFFF5DDDC), // #f5dddc
              ],
            ),
          ),
          child: SingleChildScrollView(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Breastfeeding Guidance',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 16.0),
                Text(
                  'Here are some tips for successful breastfeeding:',
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(height: 8.0),
                _buildTip('Ensure a proper latch for your baby.'),
                _buildTip(
                    'Breastfeed on demand, whenever your baby shows hunger cues.'),
                _buildTip(
                    'Stay hydrated and eat nutritious foods to support milk production.'),
                _buildTip(
                    'Find a comfortable breastfeeding position for you and your baby.'),
                _buildTip(
                    'Seek support from lactation consultants or breastfeeding support groups if needed.'),

                // Add more tips as needed
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTip(String tip) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.0),
      child: Container(
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Color(0xFFFABDBB),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Icon(Icons.check_circle, color: Colors.green),
            SizedBox(width: 8.0),
            Expanded(child: Text(tip)),
          ],
        ),
      ),
    );
  }
}
