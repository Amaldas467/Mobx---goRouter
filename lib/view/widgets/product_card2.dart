import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:skincare_app/controller/cart_controller.dart';
import 'package:skincare_app/controller/favourite_controller.dart';

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

  void _showCustomSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(
      content: Text(
        message,
        style: TextStyle(color: Colors.white),
      ),
      backgroundColor: ColorConstants.buttonColor,
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.only(top: 80, left: 16, right: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      duration: Duration(seconds: 1),
    );

    // Show the snack bar
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    final favoritesController = Provider.of<FavouriteController>(context);
    final cartController = Provider.of<CartController>(context);

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
                          favoritesController.isProductFavourite(product);
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
                              favoritesController.toggleFavourite(product);
                              _showCustomSnackBar(
                                context,
                                "${product.title} Removed from favourites",
                              );
                            } else {
                              favoritesController.toggleFavourite(product);
                              _showCustomSnackBar(
                                context,
                                "${product.title} added to favourites",
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
                      Observer(
                        builder: (context) {
                          bool isInCart =
                              cartController.cartProducts.contains(product);
                          return InkWell(
                            onTap: () {
                              if (isInCart) {
                                //cartController.removeFromCart(product);
                                _showCustomSnackBar(
                                  context,
                                  "${product.title} already in cart",
                                );
                              } else {
                                // Add product to cart
                                cartController.addToCart(product);
                                _showCustomSnackBar(
                                  context,
                                  "${product.title} added to cart",
                                );
                              }
                            },
                            child: CircleAvatar(
                              radius: screenWidth * 0.04,
                              backgroundColor: ColorConstants.buttonColor,
                              child: Icon(
                                isInCart
                                    ? Icons.shopping_cart
                                    : Icons.shopping_cart_outlined,
                                color: Colors.white,
                              ),
                            ),
                          );
                        },
                      ),
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
