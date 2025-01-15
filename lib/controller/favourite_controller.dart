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
    favouriteProducts.clear();
    List<ProductREsModel> loadedProducts =
        await _dbHelper.getFavouriteProducts();

    for (var product in loadedProducts) {
      if (!favouriteProducts.any((favProduct) => favProduct.id == product.id)) {
        favouriteProducts.add(product);
      }
    }
  }

  @action
  Future<void> toggleFavourite(ProductREsModel product) async {
    // Check if the product is already in the favorites list
    if (isProductFavourite(product)) {
      favouriteProducts.remove(product); // Remove from the list
      await _dbHelper.removeFavourite(product); // Remove from the database

      // Reload the favourite products after removal
      await _loadFavouriteProducts();
    } else {
      // Add to the favorites list
      favouriteProducts.add(product);
      await _dbHelper.insertFavourite(product); // Add to the database
    }
  }

  bool isProductFavourite(ProductREsModel product) {
    return favouriteProducts.any((favProduct) => favProduct.id == product.id);
  }
}
