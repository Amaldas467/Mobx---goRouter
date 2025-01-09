import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:skincare_app/controller/homescreen_controller.dart';
import 'package:skincare_app/model/productResModel.dart';
import 'package:skincare_app/utilities/color_constants.dart';

class ProductDetailsPage extends StatelessWidget {
  final ProductREsModel product;
  static String route = '/productdetail';

  ProductDetailsPage({required this.product});

  @override
  Widget build(BuildContext context) {
    final homescreenController = Provider.of<Homescreencontroller>(context);
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    Widget buildStars(double? rating) {
      if (rating == null || rating < 0) {
        rating = 0.0;
      }

      int fullStars = rating.floor();
      int halfStars = (rating - fullStars >= 0.5) ? 1 : 0;
      int emptyStars = 5 - fullStars - halfStars;

      List<Widget> starIcons = [];

      for (int i = 0; i < fullStars; i++) {
        starIcons.add(
            Icon(Icons.star, color: Colors.amber, size: screenWidth * 0.05));
      }

      if (halfStars > 0) {
        starIcons.add(Icon(Icons.star_half,
            color: Colors.amber, size: screenWidth * 0.05));
      }

      for (int i = 0; i < emptyStars; i++) {
        starIcons.add(Icon(Icons.star_border,
            color: Colors.amber, size: screenWidth * 0.05));
      }

      return Row(children: starIcons);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(product.title ?? "Product Details"),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(screenWidth * 0.04),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: screenWidth,
                height: screenHeight * 0.4,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  image: DecorationImage(
                    image: NetworkImage(
                        product.image ?? "https://via.placeholder.com/150"),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.02),
              Text(
                product.title ?? "Product Title",
                style: TextStyle(
                  fontSize: screenWidth * 0.06,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: screenHeight * 0.01),
              Text(
                product.category?.toString().split('.').last ?? "Category",
                style: TextStyle(
                  fontSize: screenWidth * 0.04,
                  color: Colors.grey,
                ),
              ),
              SizedBox(height: screenHeight * 0.01),
              Row(
                children: [
                  buildStars(product.rating?.rate),
                  SizedBox(width: screenWidth * 0.02),
                  Text(
                    "${product.rating?.count ?? 0} Reviews",
                    style: TextStyle(
                      fontSize: screenWidth * 0.04,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
              SizedBox(height: screenHeight * 0.02),
              Text(
                product.description ?? "Product Description",
                style: TextStyle(fontSize: screenWidth * 0.04),
              ),
              SizedBox(height: screenHeight * 0.02),
              Text(
                "\$${product.price?.toString() ?? "0.0"}",
                style: TextStyle(
                  fontSize: screenWidth * 0.05,
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: screenHeight * 0.02),
              Center(
                child: Observer(
                  builder: (context) {
                    return ElevatedButton(
                      onPressed: () {
                        print("Product added to cart");
                        if (homescreenController.cartProducts
                            .contains(product)) {
                          homescreenController.removeFromCart(product);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content:
                                  Text("${product.title} removed from cart"),
                              duration: Duration(seconds: 2),
                            ),
                          );
                        } else {
                          homescreenController.addToCart(product);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("${product.title} added to cart"),
                              duration: Duration(seconds: 2),
                            ),
                          );
                        }
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/icons/bag-2.png",
                            height: screenWidth * 0.065,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Add to Cart",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: screenWidth * 0.045,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorConstants.buttonColor,
                        minimumSize: Size(screenWidth * 0.8, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
