// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$CartController on _CartController, Store {
  late final _$cartProductsAtom =
      Atom(name: '_CartController.cartProducts', context: context);

  @override
  List<ProductREsModel> get cartProducts {
    _$cartProductsAtom.reportRead();
    return super.cartProducts;
  }

  @override
  set cartProducts(List<ProductREsModel> value) {
    _$cartProductsAtom.reportWrite(value, super.cartProducts, () {
      super.cartProducts = value;
    });
  }

  late final _$_CartControllerActionController =
      ActionController(name: '_CartController', context: context);

  @override
  void addToCart(ProductREsModel product) {
    final _$actionInfo = _$_CartControllerActionController.startAction(
        name: '_CartController.addToCart');
    try {
      return super.addToCart(product);
    } finally {
      _$_CartControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  void removeFromCart(ProductREsModel product) {
    final _$actionInfo = _$_CartControllerActionController.startAction(
        name: '_CartController.removeFromCart');
    try {
      return super.removeFromCart(product);
    } finally {
      _$_CartControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  double calculateTotalPrice() {
    final _$actionInfo = _$_CartControllerActionController.startAction(
        name: '_CartController.calculateTotalPrice');
    try {
      return super.calculateTotalPrice();
    } finally {
      _$_CartControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
cartProducts: ${cartProducts}
    ''';
  }
}
