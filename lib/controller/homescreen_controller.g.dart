// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'homescreen_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$Homescreencontroller on _Homescreencontroller, Store {
  late final _$productlistAtom =
      Atom(name: '_Homescreencontroller.productlist', context: context);

  @override
  List<ProductREsModel> get productlist {
    _$productlistAtom.reportRead();
    return super.productlist;
  }

  @override
  set productlist(List<ProductREsModel> value) {
    _$productlistAtom.reportWrite(value, super.productlist, () {
      super.productlist = value;
    });
  }

  late final _$favouriteProductsAtom =
      Atom(name: '_Homescreencontroller.favouriteProducts', context: context);

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

  late final _$isLoadingAtom =
      Atom(name: '_Homescreencontroller.isLoading', context: context);

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  late final _$baseurlAtom =
      Atom(name: '_Homescreencontroller.baseurl', context: context);

  @override
  String get baseurl {
    _$baseurlAtom.reportRead();
    return super.baseurl;
  }

  @override
  set baseurl(String value) {
    _$baseurlAtom.reportWrite(value, super.baseurl, () {
      super.baseurl = value;
    });
  }

  late final _$cartItemsAtom =
      Atom(name: '_Homescreencontroller.cartItems', context: context);

  @override
  List<CartItem> get cartItems {
    _$cartItemsAtom.reportRead();
    return super.cartItems;
  }

  @override
  set cartItems(List<CartItem> value) {
    _$cartItemsAtom.reportWrite(value, super.cartItems, () {
      super.cartItems = value;
    });
  }

  late final _$cartProductsAtom =
      Atom(name: '_Homescreencontroller.cartProducts', context: context);

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

  late final _$getDataAsyncAction =
      AsyncAction('_Homescreencontroller.getData', context: context);

  @override
  Future<dynamic> getData() {
    return _$getDataAsyncAction.run(() => super.getData());
  }

  late final _$_HomescreencontrollerActionController =
      ActionController(name: '_Homescreencontroller', context: context);

  @override
  void toggleFavourite(ProductREsModel product) {
    final _$actionInfo = _$_HomescreencontrollerActionController.startAction(
        name: '_Homescreencontroller.toggleFavourite');
    try {
      return super.toggleFavourite(product);
    } finally {
      _$_HomescreencontrollerActionController.endAction(_$actionInfo);
    }
  }

  @override
  void addToCart(ProductREsModel product) {
    final _$actionInfo = _$_HomescreencontrollerActionController.startAction(
        name: '_Homescreencontroller.addToCart');
    try {
      return super.addToCart(product);
    } finally {
      _$_HomescreencontrollerActionController.endAction(_$actionInfo);
    }
  }

  @override
  void removeFromCart(ProductREsModel product) {
    final _$actionInfo = _$_HomescreencontrollerActionController.startAction(
        name: '_Homescreencontroller.removeFromCart');
    try {
      return super.removeFromCart(product);
    } finally {
      _$_HomescreencontrollerActionController.endAction(_$actionInfo);
    }
  }

  @override
  double calculateTotalPrice() {
    final _$actionInfo = _$_HomescreencontrollerActionController.startAction(
        name: '_Homescreencontroller.calculateTotalPrice');
    try {
      return super.calculateTotalPrice();
    } finally {
      _$_HomescreencontrollerActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
productlist: ${productlist},
favouriteProducts: ${favouriteProducts},
isLoading: ${isLoading},
baseurl: ${baseurl},
cartItems: ${cartItems},
cartProducts: ${cartProducts}
    ''';
  }
}
