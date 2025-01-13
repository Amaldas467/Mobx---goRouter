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

  late final _$getDataAsyncAction =
      AsyncAction('_Homescreencontroller.getData', context: context);

  @override
  Future<dynamic> getData() {
    return _$getDataAsyncAction.run(() => super.getData());
  }

  @override
  String toString() {
    return '''
productlist: ${productlist},
isLoading: ${isLoading},
baseurl: ${baseurl}
    ''';
  }
}
