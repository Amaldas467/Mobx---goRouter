import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:skincare_app/model/productResModel.dart';

class Homescreencontroller extends ChangeNotifier {
  List<ProductREsModel> productlist = [];
  bool isLoading = false;
  final baseurl = 'https://fakestoreapi.com';
  Future getData() async {
    isLoading = true;
    final url = baseurl + '/products/';
    print(url);
    final uri = Uri.parse(url);
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final List<dynamic> decodedResponse = jsonDecode(response.body);

      productlist = decodedResponse
          .map((item) => ProductREsModel.fromJson(item))
          .toList();

      isLoading = false;
    } else {
      isLoading = false;
      print("Failed to load data: ${response.statusCode}");
    }
    notifyListeners();
  }
}
