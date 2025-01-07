import 'package:go_router/go_router.dart';
import 'package:skincare_app/view/category.dart';
import 'package:skincare_app/view/homepage.dart';
import 'package:skincare_app/view/splash.dart';

final GoRouter router = GoRouter(initialLocation: "/splash", routes: [
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
    path: "/home",
    name: "/home",
    builder: (context, state) {
      return Homepage();
    },
  )
]);
