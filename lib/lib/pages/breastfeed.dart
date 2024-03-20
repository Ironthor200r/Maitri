import 'package:Maitri/pages/guides.dart';
import 'package:flutter/material.dart';

class BreastfeedingTechniquesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                'Breastfeeding Techniques and Positions',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16.0),
              Text(
                'Here are some common breastfeeding techniques and positions:',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 8.0),
              _buildTechnique('Cradle Hold', 'assets/images/cradle-hold.png',
                  "https://youtu.be/-w00GLCY59Q?si=Qo2N7HdV9QuOLRNH", context),
              SizedBox(height: 8.0),
              _buildTechnique(
                  'Cross-Cradle Hold',
                  'assets/images/cross-cradle-hold.png',
                  'https://youtu.be/MQffBLluJ4A?si=yPmoLfawIVPDAWoj',
                  context),
              SizedBox(height: 8.0),
              _buildTechnique('Football Hold', 'assets/images/rugby-hold.png',
                  'https://youtu.be/NGd1V3gjGyo?si=YJUKoOWywCbMKKJu', context),
              SizedBox(height: 8.0),
              _buildTechnique(
                  'Side-Lying Position',
                  'assets/images/side-lying-hold.png',
                  'https://youtu.be/dhjo8vCx3c0?si=vMaHnVp4x6xXK3lw',
                  context),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ElevatedButton(
                      onPressed: () => {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        BreastfeedingGuidanceContent())),
                          },
                      child: Icon(Icons.navigate_next)),
                ],
              )

              // Add more techniques as needed
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTechnique(
      String title, String imagePath, String videoPath, BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Color(0xFFFABDBB),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8.0),
          SizedBox(
            height: 100,
            width: double.infinity,
            child: Image.asset(
              imagePath,
              fit: BoxFit.contain,
            ),
          ),
        ],
      ),
    );
  }
}
