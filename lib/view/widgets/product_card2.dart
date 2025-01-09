import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:skincare_app/controller/homescreen_controller.dart';
import 'package:skincare_app/model/productResModel.dart';
import 'package:skincare_app/utilities/color_constants.dart';

class ProductCard2 extends StatelessWidget {
  final double screenWidth;
  final double screenHeight;
  final ProductREsModel product;

  ProductCard2({
    required this.screenWidth,
    required this.screenHeight,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    final homescreenController = Provider.of<Homescreencontroller>(context);

    return InkWell(
      onTap: () {
        //Navigator.pushNamed(
        //  context,
        //  '/productdetails',
        //  arguments: product,
        //);
        context.pushNamed('/productdetails', extra: product);
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(screenWidth * 0.03),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  width: screenWidth * 1.21,
                  height: screenHeight * 0.17,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(screenWidth * 0.03),
                      topRight: Radius.circular(screenWidth * 0.03),
                    ),
                    image: DecorationImage(
                      image: NetworkImage(
                          product.image ?? "https://via.placeholder.com/150"),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                Positioned(
                  top: screenWidth * 0.02,
                  left: screenWidth * 0.02,
                  child: Observer(
                    builder: (context) {
                      bool isFavorite =
                          homescreenController.isProductFavourite(product);
                      return CircleAvatar(
                        radius: screenWidth * 0.042,
                        backgroundColor: Colors.white,
                        child: IconButton(
                          icon: Icon(
                            isFavorite ? Icons.favorite : Icons.favorite_border,
                            color: isFavorite ? Colors.red : Colors.grey,
                            size: screenWidth * 0.05,
                          ),
                          onPressed: () {
                            if (isFavorite) {
                              homescreenController.toggleFavourite(product);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                      "${product.title} removed from favourites"),
                                  duration: Duration(seconds: 2),
                                ),
                              );
                            } else {
                              homescreenController.toggleFavourite(product);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                      "${product.title} added to favourites"),
                                  duration: Duration(seconds: 2),
                                ),
                              );
                            }
                          },
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.all(screenWidth * 0.02),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.title ?? "Product Title",
                    style: TextStyle(
                      fontSize: screenWidth * 0.04,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: screenHeight * 0.005),
                  Text(
                    product.description ?? "Product Description",
                    style: TextStyle(
                      fontSize: screenWidth * 0.031,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: screenHeight * 0.005),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "\$${product.price?.toString() ?? "0.0"}",
                        style: TextStyle(
                          fontSize: screenWidth * 0.048,
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      InkWell(
                        onTap: () {
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
                        child: CircleAvatar(
                          radius: screenWidth * 0.04,
                          backgroundColor: ColorConstants.buttonColor,
                          child: Icon(
                            homescreenController.cartProducts.contains(product)
                                ? Icons.shopping_cart
                                : Icons.shopping_cart_outlined,
                            color: Colors.white,
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
