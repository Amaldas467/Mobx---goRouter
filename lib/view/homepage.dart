import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:shimmer/shimmer.dart';
import 'package:skincare_app/controller/homescreen_controller.dart';
import 'package:skincare_app/utilities/color_constants.dart';
import 'package:skincare_app/view/widgets/drawer.dart';
import 'package:skincare_app/view/profile_screen.dart';
import 'package:skincare_app/view/widgets/product_card2.dart';
import 'package:skincare_app/model/productResModel.dart';
import 'package:skincare_app/view/widgets/favouritewidget.dart';

class Homepage extends StatefulWidget {
  static String route = '/home';

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  TextEditingController _searchController = TextEditingController();
  List<ProductREsModel> filteredProducts = [];
  int selectedCategoryIndex = 0;
  int currentIndex = 0;
  List<String> categories = ['All'];
  late Homescreencontroller homescreencontroller;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    fetchData();
    _searchController.addListener(_filterProducts);
    _pageController = PageController();
  }

  fetchData() {
    homescreencontroller =
        Provider.of<Homescreencontroller>(context, listen: false);
    homescreencontroller.getData();
  }

  _filterProducts() {
    final searchQuery = _searchController.text.toLowerCase();
    setState(() {
      filteredProducts = homescreencontroller.productlist
          .where((product) =>
              product.title!.toLowerCase().contains(searchQuery) ||
              product.description!.toLowerCase().contains(searchQuery))
          .toList();
    });
  }

  void onPageChanged(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    homescreencontroller = Provider.of<Homescreencontroller>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title:
            Image.asset("assets/appbarimmg.png", height: screenHeight * 0.09),
        centerTitle: true,
        actions: [
          InkWell(
            onTap: () {
              context.pushNamed(
                '/Cartpage',
                extra: homescreencontroller,
              );
            },
            child: Icon(IconsaxPlusBold.shopping_cart),
          ),
          SizedBox(width: 15),
        ],
        leading: Builder(
          builder: (context) {
            return InkWell(
              onTap: () {
                Scaffold.of(context).openDrawer();
              },
              child: Image.asset("assets/icons/menu.png",
                  height: screenHeight * 0.09),
            );
          },
        ),
      ),
      drawer: Homescreen_drawer(),
      body: PageView(
        controller: _pageController,
        onPageChanged: onPageChanged,
        children: [
          _homePage(screenWidth, screenHeight),
          _explorePage(),
          _favouritesPage(),
          _profilePage(),
        ],
      ),
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
            label: 'Favourites',
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
          _pageController.jumpToPage(index);
        },
        unselectedItemColor: const Color.fromARGB(255, 178, 177, 177),
        selectedItemColor: ColorConstants.buttonColor,
      ),
    );
  }

  Widget _homePage(double screenWidth, double screenHeight) {
    return Observer(
      builder: (context) {
        // Ensure products are loaded
        if (homescreencontroller.isLoading) {
          // Show shimmer effect while loading
          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(screenWidth * 0.04),
              child: Column(
                children: [
                  // Search bar, category buttons, and shimmer for grid
                  _buildSearchBar(screenWidth, screenHeight),
                  _buildShimmerCategory(screenWidth),
                  _buildShimmerGrid(screenWidth, screenHeight),
                ],
              ),
            ),
          );
        }

        // Filtered or unfiltered products list
        List<ProductREsModel> displayedProducts = filteredProducts.isEmpty
            ? homescreencontroller.productlist
            : filteredProducts;

        // Filter based on category selection
        if (selectedCategoryIndex != 0) {
          displayedProducts = displayedProducts.where((product) {
            return product.category.toString().split('.').last ==
                categories[selectedCategoryIndex];
          }).toList();
        }

        // If categories are not loaded, load them
        if (categories.length == 1 &&
            homescreencontroller.productlist.isNotEmpty) {
          Set<String> categorySet = Set();
          for (var product in homescreencontroller.productlist) {
            categorySet.add(product.category.toString().split('.').last);
          }
          categories = ['All', ...categorySet.toList()];
        }

        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(screenWidth * 0.04),
            child: Column(
              children: [
                // Search Bar
                _buildSearchBar(screenWidth, screenHeight),
                SizedBox(height: screenHeight * 0.02),

                // Category buttons
                _buildCategoryButtons(screenWidth),
                SizedBox(height: screenHeight * 0.02),

                // No results found message
                if (filteredProducts.isEmpty &&
                    _searchController.text.isNotEmpty)
                  Center(
                    child: Text(
                      "0 searches found",
                      style: TextStyle(fontSize: 18, color: Colors.grey),
                    ),
                  )
                else
                  // Grid of products
                  GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: screenWidth > 600 ? 3 : 2,
                      crossAxisSpacing: screenWidth * 0.04,
                      mainAxisSpacing: screenHeight * 0.02,
                      childAspectRatio: 0.75,
                    ),
                    itemCount: displayedProducts.length,
                    itemBuilder: (context, index) {
                      final product = displayedProducts[index];
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
        );
      },
    );
  }

  Widget _buildSearchBar(double screenWidth, double screenHeight) {
    return TextField(
      controller: _searchController,
      decoration: InputDecoration(
        hintText: 'Search products',
        hintStyle: TextStyle(color: ColorConstants.buttonColor),
        prefixIcon: Image.asset("assets/icons/search-line 1.png"),
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
    );
  }

  Widget _buildShimmerCategory(double screenWidth) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: List.generate(5, (index) {
            return Padding(
              padding: EdgeInsets.only(right: screenWidth * 0.04),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(18.0),
                ),
                width: screenWidth * 0.2,
              ),
            );
          }),
        ),
      ),
    );
  }

  Widget _buildShimmerGrid(double screenWidth, double screenHeight) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: GridView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: screenWidth > 600 ? 3 : 2,
          crossAxisSpacing: screenWidth * 0.04,
          mainAxisSpacing: screenHeight * 0.02,
          childAspectRatio: 0.75,
        ),
        itemCount: 6, // Display 6 placeholder items
        itemBuilder: (context, index) {
          return Container(
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(12),
            ),
            margin: EdgeInsets.symmetric(vertical: 8.0),
          );
        },
      ),
    );
  }

  Widget _buildCategoryButtons(double screenWidth) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(categories.length, (index) {
          return Padding(
            padding: EdgeInsets.only(right: screenWidth * 0.04),
            child: InkWell(
              onTap: () {
                setState(() {
                  selectedCategoryIndex = index;
                  _filterProducts();
                });
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                decoration: BoxDecoration(
                  color: selectedCategoryIndex == index
                      ? ColorConstants.buttonColor
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(18.0),
                  border: Border.all(
                    color: selectedCategoryIndex == index
                        ? ColorConstants.buttonColor
                        : const Color.fromARGB(255, 198, 198, 198),
                  ),
                ),
                child: Text(
                  categories[index],
                  style: TextStyle(
                    color: selectedCategoryIndex == index
                        ? Colors.white
                        : ColorConstants.buttonColor,
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _explorePage() {
    return Center(child: Text("Explore Page", style: TextStyle(fontSize: 24)));
  }

  Widget _favouritesPage() {
    return SingleChildScrollView(child: FavouritesScreen());
  }

  Widget _profilePage() {
    return Center(child: ProfileScreen());
  }
}
