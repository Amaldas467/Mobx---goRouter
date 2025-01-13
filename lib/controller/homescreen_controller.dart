import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mobx/mobx.dart';

import 'package:skincare_app/model/productResModel.dart';

part 'homescreen_controller.g.dart';

class Homescreencontroller = _Homescreencontroller with _$Homescreencontroller;

abstract class _Homescreencontroller with Store {
  // Initialize the Favorites and Cart Controllers

  @observable
  List<ProductREsModel> productlist = [];

  @observable
  bool isLoading = false;

  @observable
  var baseurl = 'https://fakestoreapi.com';

  // Fetching product data
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
}
