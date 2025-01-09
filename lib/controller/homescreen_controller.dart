import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mobx/mobx.dart';
import 'package:skincare_app/model/productResModel.dart';

part 'homescreen_controller.g.dart';

class Homescreencontroller = _Homescreencontroller with _$Homescreencontroller;

abstract class _Homescreencontroller with Store {
  @observable
  List<ProductREsModel> productlist = [];

  @observable
  List<ProductREsModel> favouriteProducts = ObservableList<ProductREsModel>();

  @observable
  bool isLoading = false;

  @observable
  var baseurl = 'https://fakestoreapi.com';

  // Cart related
  @observable
  List<CartItem> cartItems = ObservableList<CartItem>();

  @observable
  List<ProductREsModel> cartProducts = ObservableList<ProductREsModel>();

  @action
  Future getData() async {
    isLoading = true;
    final url = baseurl + '/products/';
    final uri = Uri.parse(url);
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final List<dynamic> decodedResponse = jsonDecode(response.body);

      productlist = decodedResponse
          .map((item) => ProductREsModel.fromJson(item))
          .toList();

      print("Fetched ${productlist.length} products.");
      isLoading = false;
    } else {
      isLoading = false;
      print("Failed to load data: ${response.statusCode}");
    }
  }

//favourites toggle
  @action
  void toggleFavourite(ProductREsModel product) {
    if (favouriteProducts.contains(product)) {
      favouriteProducts.remove(product);
    } else {
      favouriteProducts.add(product);
    }
  }

  bool isProductFavourite(ProductREsModel product) {
    return favouriteProducts.contains(product);
  }

//cart operations
  @action
  void addToCart(ProductREsModel product) {
    cartProducts.add(product);
  }

  @action
  void removeFromCart(ProductREsModel product) {
    cartProducts.remove(product);
  }

  //  total price
  @action
  double calculateTotalPrice() {
    return cartItems.fold(
      0.0,
      (total, item) => total + (item.product.price ?? 0.0) * item.quantity,
    );
  }
}

// Cartd product and  quantity
class CartItem {
  final ProductREsModel product;
  int quantity;

  CartItem({required this.product, this.quantity = 1});
}
