import 'package:mobx/mobx.dart';
import 'package:skincare_app/model/productResModel.dart';

part 'favourite_controller.g.dart';

class FavouriteController = _FavouriteController with _$FavouriteController;

abstract class _FavouriteController with Store {
  @observable
  List<ProductREsModel> favouriteProducts = ObservableList<ProductREsModel>();

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
}
