import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:skincare_app/controller/cart_controller.dart'; // Add import for CartController
// Add import for FavoritesController
import 'package:skincare_app/model/productResModel.dart';
import 'package:skincare_app/view/cartpage.dart';
import 'package:skincare_app/view/category.dart';
import 'package:skincare_app/view/homepage.dart';
import 'package:skincare_app/view/splash.dart';
import 'package:skincare_app/view/widgets/productdetail.dart';

final GoRouter router = GoRouter(
  initialLocation: "/splash",
  routes: [
    GoRoute(
      path: "/splash",
      name: "/splash",
      builder: (context, state) {
        return Splash();
      },
    ),
    GoRoute(
      path: "/category",
      name: "/category",
      builder: (context, state) {
        return CategoryPage();
      },
    ),
    GoRoute(
      path: Homepage.route,
      name: "/home",
      builder: (context, state) {
        return Homepage();
      },
    ),
    GoRoute(
      path: '/productdetails',
      name: '/productdetails',
      builder: (context, state) {
        final ProductREsModel product = state.extra as ProductREsModel;
        return ProductDetailsPage(product: product);
      },
    ),
    GoRoute(
      path: '/Cartpage',
      name: '/Cartpage',
      builder: (context, state) {
        final cartController = state.extra as CartController?;
        if (cartController == null) {
          return Scaffold(
            body: Center(child: Text('Error: Controller is missing.')),
          );
        }
        return CartPage(
            cartController: cartController); // Updated to use CartController
      },
    ),
  ],
);
