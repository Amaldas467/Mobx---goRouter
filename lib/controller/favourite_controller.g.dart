// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favourite_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$FavouriteController on _FavouriteController, Store {
  late final _$favouriteProductsAtom =
      Atom(name: '_FavouriteController.favouriteProducts', context: context);

  @override
  List<ProductREsModel> get favouriteProducts {
    _$favouriteProductsAtom.reportRead();
    return super.favouriteProducts;
  }

  @override
  set favouriteProducts(List<ProductREsModel> value) {
    _$favouriteProductsAtom.reportWrite(value, super.favouriteProducts, () {
      super.favouriteProducts = value;
    });
  }

  late final _$_FavouriteControllerActionController =
      ActionController(name: '_FavouriteController', context: context);

  @override
  void toggleFavourite(ProductREsModel product) {
    final _$actionInfo = _$_FavouriteControllerActionController.startAction(
        name: '_FavouriteController.toggleFavourite');
    try {
      return super.toggleFavourite(product);
    } finally {
      _$_FavouriteControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
favouriteProducts: ${favouriteProducts}
    ''';
  }
}
