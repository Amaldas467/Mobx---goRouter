import 'package:mobx/mobx.dart';
import 'package:skincare_app/local_db/cart_helper.dart';
import 'package:skincare_app/model/productResModel.dart';

part 'cart_controller.g.dart';

class CartController = _CartController with _$CartController;

abstract class _CartController with Store {
  final DBHelper _dbHelper = DBHelper();

  @observable
  List<ProductREsModel> cartProducts = ObservableList<ProductREsModel>();

  _CartController() {
    _loadCartProducts();
  }

  // Load the cart products from the database when the controller is created
  Future<void> _loadCartProducts() async {
    cartProducts.clear();
    List<ProductREsModel> loadedProducts = await _dbHelper.getCartProducts();

    for (var product in loadedProducts) {
      if (!cartProducts.any((cartProduct) => cartProduct.id == product.id)) {
        cartProducts.add(product);
      }
    }
  }

  @action
  void addToCart(ProductREsModel product) async {
    // Check if the product is already in the cart
    if (!isProductInCart(product)) {
      cartProducts.add(product);
      await _dbHelper.insertCartProduct(product); // Insert into database
    }
  }

  @action
  void removeFromCart(ProductREsModel product) async {
    cartProducts.remove(product);
    await _dbHelper.removeCartProduct(product); // Remove from database
  }

  @action
  double calculateTotalPrice() {
    return cartProducts.fold(
        0.0, (total, product) => total + (product.price ?? 0.0));
  }

  bool isProductInCart(ProductREsModel product) {
    // Check if the product is in the cart list using a unique identifier (e.g., ID)
    return cartProducts.any((cartProduct) => cartProduct.id == product.id);
  }

  @action
  void clearCart() async {
    cartProducts.clear();
    await _dbHelper.clearCart(); // Clear all products in database
  }
}
