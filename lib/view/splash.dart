import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:skincare_app/utilities/color_constants.dart';

class Splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: ColorConstants.backgroundGradient,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: screenWidth,
                height: screenHeight * 0.552,
                child: Image.asset(
                  "assets/splash.png",
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Title Text
                    Text(
                      "An Evolving \n collection of treatments",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: screenWidth * 0.07,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 10),

                    Text(
                      "The Ordinary is born to disallow \n commodity to be disguised as ingenuity. \n The Ordinary is 'Clinical formulations \n with integrity.'",
                      style: TextStyle(
                        fontSize: screenWidth * 0.045,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 20),

                    Align(
                      alignment: Alignment.center,
                      child: ElevatedButton(
                        onPressed: () {
                          context.goNamed("/category");
                          //Navigator.push(
                          //    context,
                          //    MaterialPageRoute(
                          //      builder: (context) => CategoryPage(),
                          //    ));
                        },
                        child: Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                        ),
                        style: ElevatedButton.styleFrom(
                            shape: CircleBorder(),
                            padding: EdgeInsets.all(16),
                            backgroundColor: ColorConstants.buttonColor),
                      ),
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
}
