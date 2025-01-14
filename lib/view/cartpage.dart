import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:skincare_app/controller/cart_controller.dart';
import 'package:skincare_app/utilities/color_constants.dart';

class CartPage extends StatelessWidget {
  final CartController cartController;

  void _showCustomSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(
      content: Text(
        message,
        style: TextStyle(color: Colors.white),
      ),
      backgroundColor: ColorConstants.buttonColor,
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.only(
          top: 80, left: 16, right: 16), // Adjusted to move snack bar up
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      duration: Duration(seconds: 1),
    );

    // Show the snack bar
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  const CartPage({Key? key, required this.cartController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Cart"),
        centerTitle: true,
      ),
      body: Observer(
        builder: (_) {
          if (cartController.cartProducts.isEmpty) {
            return const Center(
              child: Text(
                'Your cart is empty',
                style: TextStyle(fontSize: 18),
              ),
            );
          }
          return ListView.builder(
            itemCount: cartController.cartProducts.length,
            itemBuilder: (context, index) {
              final product = cartController.cartProducts[index];
              return ListTile(
                leading: Image.network(
                  product.image ?? "https://via.placeholder.com/150",
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                ),
                title: Text(
                  product.title ?? "Product Name",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                subtitle: Text(
                  "\$${product.price?.toStringAsFixed(2) ?? "0.00"}",
                  style: TextStyle(color: Colors.green),
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.remove_circle, color: Colors.red),
                  onPressed: () {
                    cartController.removeFromCart(product);
                    _showCustomSnackBar(
                      context,
                      "${product.title} Removed from cart",
                    );
                  },
                ),
              );
            },
          );
        },
      ),
      bottomNavigationBar: _buildTotalPriceSection(context, cartController),
    );
  }

  Widget _buildTotalPriceSection(
      BuildContext context, CartController cartController) {
    return Observer(
      builder: (_) {
        final totalPrice = cartController.calculateTotalPrice();
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 10,
                offset: Offset(0, -2),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Total: \$${totalPrice.toStringAsFixed(2)}",
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              ElevatedButton(
                onPressed: () {
                  _showCheckoutDialog(context, cartController);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                ),
                child: const Text("Checkout", style: TextStyle(fontSize: 18)),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showCheckoutDialog(
      BuildContext context, CartController cartController) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Checkout"),
        content: const Text("Proceed to checkout?"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              cartController.clearCart();
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Checkout successful!"),
                ),
              );
            },
            child: const Text("Confirm"),
          ),
        ],
      ),
    );
  }
}
