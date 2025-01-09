import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:skincare_app/utilities/category_data.dart';
import 'package:skincare_app/utilities/color_constants.dart';

class CategoryPage extends StatefulWidget {
  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  List<int> selectedCategoryIndices = [];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    bool isAnyCategorySelected = selectedCategoryIndices.isNotEmpty;

    return Scaffold(
      appBar: AppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Choose your favorite \n category",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: screenWidth * 0.07,
            ),
            textAlign: TextAlign.center,
          ),
          Text(
            "You can choose more than one",
            style: TextStyle(
              fontSize: screenWidth * 0.045,
              color: ColorConstants.buttonColor,
            ),
          ),
          SizedBox(height: screenHeight * 0.02),
          Wrap(
            spacing: screenWidth * 0.03,
            runSpacing: screenHeight * 0.02,
            children: [
              for (var index = 0; index < categories.length; index++)
                GestureDetector(
                  onTap: () {
                    setState(() {
                      if (selectedCategoryIndices.contains(index)) {
                        selectedCategoryIndices.remove(index);
                      } else {
                        selectedCategoryIndices.add(index);
                      }
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      vertical: screenHeight * 0.015,
                      horizontal: screenWidth * 0.04,
                    ),
                    decoration: BoxDecoration(
                      color: selectedCategoryIndices.contains(index)
                          ? ColorConstants.buttonColor
                          : Colors.white,
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(color: ColorConstants.buttonborder),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(
                          categories[index]['icon'],
                          height: 20,
                        ),
                        SizedBox(width: 8),
                        Text(
                          categories[index]['name'],
                          style: TextStyle(
                            color: selectedCategoryIndices.contains(index)
                                ? Colors.white
                                : Colors.black,
                            fontSize: screenWidth * 0.045,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
          Spacer(),
          Center(
            child: InkWell(
              onTap: isAnyCategorySelected
                  ? () {
                      context.pushNamed("/home");
                    }
                  : null,
              child: Container(
                padding: EdgeInsets.symmetric(
                  vertical: screenHeight * 0.02,
                  horizontal: screenWidth * 0.32,
                ),
                decoration: BoxDecoration(
                  color: isAnyCategorySelected
                      ? ColorConstants.buttonColor
                      : Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(
                    color: isAnyCategorySelected
                        ? Colors.transparent
                        : ColorConstants.buttonColor,
                  ),
                ),
                child: Text(
                  "Continue",
                  style: TextStyle(
                    fontSize: screenWidth * 0.05,
                    color: isAnyCategorySelected
                        ? Colors.white
                        : ColorConstants.buttonColor,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: screenHeight * 0.0001),
          TextButton(
            onPressed: () {
              context.pushNamed("/home");
            },
            child: Center(
              child: Text(
                "Skip for now",
                style: TextStyle(
                  color: ColorConstants.buttonColor,
                  fontSize: screenWidth * 0.04,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
