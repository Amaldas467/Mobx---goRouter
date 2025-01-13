import 'package:mobx/mobx.dart';
import 'package:skincare_app/local_db/favourite_helper.dart';
import 'package:skincare_app/model/productResModel.dart';

part 'favourite_controller.g.dart';

class FavouriteController = _FavouriteController with _$FavouriteController;

abstract class _FavouriteController with Store {
  final DBHelper _dbHelper = DBHelper();

  @observable
  List<ProductREsModel> favouriteProducts = ObservableList<ProductREsModel>();

  _FavouriteController() {
    _loadFavouriteProducts();
  }

  // Load the favourite products from the database when the controller is created
  Future<void> _loadFavouriteProducts() async {
    favouriteProducts = ObservableList<ProductREsModel>.of(
        await _dbHelper.getFavouriteProducts());
  }

  @action
  void toggleFavourite(ProductREsModel product) async {
    if (favouriteProducts.contains(product)) {
      favouriteProducts.remove(product);
      await _dbHelper.removeFavourite(product); // Remove from the database
    } else {
      favouriteProducts.add(product);
      await _dbHelper.insertFavourite(product); // Add to the database
    }
  }

  bool isProductFavourite(ProductREsModel product) {
    return favouriteProducts.contains(product);
  }
}
