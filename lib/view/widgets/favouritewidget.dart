import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:skincare_app/controller/favourite_controller.dart';

import 'package:skincare_app/view/widgets/product_card2.dart';

class FavouritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final favoritesController = Provider.of<FavouriteController>(context);

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 16),
          child: Text(
            'Your Favourite Items ',
            style: TextStyle(fontSize: 18),
          ),
        ),
        Observer(
          builder: (context) {
            final favouriteProducts = favoritesController.favouriteProducts;

            if (favouriteProducts.isEmpty) {
              return Center(
                child: Text("No favourite products yet.",
                    style: TextStyle(fontSize: 24)),
              );
            }

            return Padding(
              padding: const EdgeInsets.all(15.0),
              child: GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount:
                      MediaQuery.of(context).size.width > 600 ? 3 : 2,
                  crossAxisSpacing: 16.0,
                  mainAxisSpacing: 16.0,
                  childAspectRatio: 0.75,
                ),
                itemCount: favouriteProducts.length,
                itemBuilder: (context, index) {
                  final product = favouriteProducts[index];
                  return ProductCard2(
                    screenWidth: MediaQuery.of(context).size.width,
                    screenHeight: MediaQuery.of(context).size.height,
                    product: product,
                  );
                },
              ),
            );
          },
        ),
      ],
    );
  }
}
