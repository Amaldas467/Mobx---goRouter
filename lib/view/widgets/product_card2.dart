import 'package:flutter/material.dart';

import 'package:skincare_app/model/productResModel.dart';
import 'package:skincare_app/utilities/color_constants.dart';

class ProductCard2 extends StatefulWidget {
  final double screenWidth;
  final double screenHeight;
  final ProductREsModel product;

  ProductCard2({
    required this.screenWidth,
    required this.screenHeight,
    required this.product,
  });

  @override
  _ProductCard2State createState() => _ProductCard2State();
}

class _ProductCard2State extends State<ProductCard2> {
  bool isLiked = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(widget.screenWidth * 0.03),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Image.network(
                widget.product.image ?? "https://via.placeholder.com/150",
                width: widget.screenWidth * 1.21,
                height: widget.screenHeight * 0.17,
                fit: BoxFit.cover,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: EdgeInsets.all(widget.screenWidth * 0.02),
                  child: CircleAvatar(
                    radius: widget.screenWidth * 0.042,
                    backgroundColor: Colors.white,
                    child: IconButton(
                      icon: Icon(
                        isLiked ? Icons.favorite : Icons.favorite_border,
                        color: isLiked ? Colors.red : Colors.grey,
                        size: widget.screenWidth * 0.05,
                      ),
                      onPressed: () {
                        setState(() {
                          isLiked = !isLiked;
                        });
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),

          // Product details section
          Padding(
            padding: EdgeInsets.all(widget.screenWidth * 0.02),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.product.title ?? "Product Title",
                  style: TextStyle(
                    fontSize: widget.screenWidth * 0.04,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: widget.screenHeight * 0.005),
                Text(
                  widget.product.description ?? "Descriptions",
                  style: TextStyle(
                    fontSize: widget.screenWidth * 0.031,
                    //fontWeight: FontWeight.bold,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: widget.screenHeight * 0.005),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "₹${widget.product.price?.toString() ?? "0.0"}",
                      style: TextStyle(
                        fontSize: widget.screenWidth * 0.048,
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    CircleAvatar(
                      radius: widget.screenWidth * 0.04,
                      backgroundColor: ColorConstants.buttonColor,
                      child: Image.asset(
                        "assets/icons/bag-2.png",
                        height: widget.screenWidth * 0.05,
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
