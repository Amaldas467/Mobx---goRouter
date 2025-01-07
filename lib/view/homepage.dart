import 'package:flutter/material.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:provider/provider.dart';
import 'package:skincare_app/controller/homescreen_controller.dart';
import 'package:skincare_app/utilities/color_constants.dart';
import 'package:skincare_app/view/widgets/product_card2.dart';
import 'package:skincare_app/model/productResModel.dart';

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  void initState() {
    fetchData();
    super.initState();
  }

  fetchData() {
    Provider.of<Homescreencontroller>(context, listen: false).getData();
  }

  int selectedCategoryIndex = 0;
  int currentIndex = 0; //  bottom navigation index

  // dynamic categories from products
  List<String> categories = ['All'];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Image.asset(
          "assets/appbarimmg.png",
          height: screenHeight * 0.09,
        ),
        centerTitle: true,
        actions: [
          Image.asset(
            "assets/icons/notification.png",
            height: screenHeight * 0.09,
          ),
        ],
        leading: Image.asset(
          "assets/icons/menu.png",
          height: screenHeight * 0.09,
        ),
      ),
      body: Consumer<Homescreencontroller>(
        builder: (context, value, child) {
          if (value.isLoading) {
            return Center(child: CircularProgressIndicator());
          }

          if (categories.length == 1 && value.productlist.isNotEmpty) {
            Set<String> categorySet = Set();
            for (var product in value.productlist) {
              categorySet.add(product.category.toString().split('.').last);
            }
            categories = ['All', ...categorySet.toList()];
          }

          List<ProductREsModel> filteredProducts = value.productlist;
          if (selectedCategoryIndex != 0) {
            filteredProducts = value.productlist.where((product) {
              return product.category.toString().split('.').last ==
                  categories[selectedCategoryIndex];
            }).toList();
          }

          return currentIndex == 0
              ? SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(screenWidth * 0.04),
                    child: Column(
                      children: [
                        // Search bar
                        TextField(
                          decoration: InputDecoration(
                            hintText: 'Search products',
                            hintStyle:
                                TextStyle(color: ColorConstants.buttonColor),
                            prefixIcon:
                                Image.asset("assets/icons/search-line 1.png"),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: const Color.fromARGB(255, 173, 172, 172),
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: const Color.fromARGB(255, 213, 213, 213),
                                width: 2.0,
                              ),
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                          ),
                        ),

                        SizedBox(height: screenHeight * 0.02),

                        // Category buttons
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: List.generate(categories.length, (index) {
                              return Padding(
                                  padding: EdgeInsets.only(
                                      right: screenWidth * 0.04),
                                  child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        selectedCategoryIndex =
                                            selectedCategoryIndex == index
                                                ? 0
                                                : index;
                                      });
                                    },
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 8.0, horizontal: 16.0),
                                      decoration: BoxDecoration(
                                        color: selectedCategoryIndex == index
                                            ? ColorConstants.buttonColor
                                            : Colors.transparent,
                                        borderRadius:
                                            BorderRadius.circular(18.0),
                                        border: Border.all(
                                          color: selectedCategoryIndex == index
                                              ? ColorConstants.buttonColor
                                              : const Color.fromARGB(
                                                  255, 198, 198, 198),
                                        ),
                                      ),
                                      child: Text(
                                        categories[index],
                                        style: TextStyle(
                                          color: selectedCategoryIndex == index
                                              ? Colors.white
                                              : ColorConstants.buttonColor,
                                          //fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ));
                            }),
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.02),

                        // Displaying filtered products
                        GridView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: screenWidth > 600 ? 3 : 2,
                            crossAxisSpacing: screenWidth * 0.04,
                            mainAxisSpacing: screenHeight * 0.02,
                            childAspectRatio: 0.75,
                          ),
                          itemCount: filteredProducts.length,
                          itemBuilder: (context, index) {
                            final product = filteredProducts[index];
                            return ProductCard2(
                              screenWidth: screenWidth,
                              screenHeight: screenHeight,
                              product: product,
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                )
              : Center(child: Text('Other Views'));
        },
      ),

      // Bottom Navigation Bar
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(IconsaxPlusBold.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(IconsaxPlusBold.element_2),
            label: 'Explore',
          ),
          BottomNavigationBarItem(
            icon: Icon(IconsaxPlusBold.heart),
            label: 'favourites',
          ),
          BottomNavigationBarItem(
            icon: Icon(IconsaxPlusBold.profile),
            label: 'Profile',
          ),
        ],
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        unselectedItemColor: const Color.fromARGB(255, 178, 177, 177),
        selectedItemColor: ColorConstants.buttonColor,
      ),
    );
  }
}
