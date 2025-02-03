import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:assignment/core/model/product_model.dart';

class ApiService {
  final String baseUrl = "https://fakestoreapi.com/products";
  Future<List<ProductModel>> fetchProducts() async {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      List<dynamic> jsonList = jsonDecode(response.body);
      List<ProductModel> products =
          jsonList.map((json) => ProductModel.fromJson(json)).toList();
      return products;
    } else {
      throw Exception("Failed to load data");
    }
  }
}
