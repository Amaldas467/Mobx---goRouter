import 'package:mobx/mobx.dart';
import 'package:skincare_app/model/productResModel.dart';

part 'cart_controller.g.dart';

class CartController = _CartController with _$CartController;

abstract class _CartController with Store {
  @observable
  List<ProductREsModel> cartProducts = ObservableList<ProductREsModel>();

  @action
  void addToCart(ProductREsModel product) {
    cartProducts.add(product);
  }

  @action
  void removeFromCart(ProductREsModel product) {
    cartProducts.remove(product);
  }

  @action
  double calculateTotalPrice() {
    return cartProducts.fold(
        0.0, (total, product) => total + (product.price ?? 0.0));
  }
}
