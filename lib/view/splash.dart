import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:skincare_app/utilities/color_constants.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  late PageController _pageController;
  late Timer _timer;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _startAutoSlide();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _timer.cancel();
    super.dispose();
  }

  void _startAutoSlide() {
    _timer = Timer.periodic(Duration(seconds: 3), (timer) {
      if (_pageController.hasClients) {
        int nextPage = (_pageController.page!.toInt() + 1) % 3;
        _pageController.animateToPage(
          nextPage,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    });
  }

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

                    // Slider indicator
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(3, (index) {
                        return Container(
                          margin: EdgeInsets.symmetric(horizontal: 4),
                          width: 12,
                          height: 8,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: _currentPage == index
                                ? ColorConstants.buttonColor
                                : ColorConstants.buttonColor,
                          ),
                        );
                      }),
                    ),

                    SizedBox(height: 20),

                    // PageView for sliding text
                    Container(
                      height: screenHeight * 0.13,
                      child: PageView(
                        controller: _pageController,
                        onPageChanged: (index) {
                          setState(() {
                            _currentPage = index;
                          });
                        },
                        children: [
                          // Slide 1
                          Text(
                            "The Ordinary is born to disallow \n commodity to be disguised as ingenuity.",
                            style: TextStyle(
                              fontSize: screenWidth * 0.045,
                              color: Colors.black,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          // Slide 2
                          Text(
                            "The Ordinary is 'Clinical formulations \n with integrity.'",
                            style: TextStyle(
                              fontSize: screenWidth * 0.045,
                              color: Colors.black,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          // Slide 3
                          Text(
                            "Join us in exploring products that transform your skincare routine.",
                            style: TextStyle(
                              fontSize: screenWidth * 0.045,
                              color: Colors.black,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 4),

                    Align(
                      alignment: Alignment.center,
                      child: ElevatedButton(
                        onPressed: () {
                          context.goNamed("/category");
                        },
                        child: Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                        ),
                        style: ElevatedButton.styleFrom(
                          shape: CircleBorder(),
                          padding: EdgeInsets.all(16),
                          backgroundColor: ColorConstants.buttonColor,
                        ),
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
