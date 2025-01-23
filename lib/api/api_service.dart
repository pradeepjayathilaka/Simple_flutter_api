import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:simple_flutter_api/models/product_model.dart';

class ApiService {
  //Fetch all products from the Api
  Future<List<Product>> fetchAllProducts() async {
    const String url = "https://fakestoreapi.com/products";

    try {
      final Response = await http.get(Uri.parse(url));
      if (Response.statusCode == 200) {
        List<dynamic> responceData = json.decode(Response.body);
        List<Product> products = responceData.map((json) {
          return Product.fromJson(json);
        }).toList();
        return products;
      } else {
        print(
            "Failed to fetch the products the state code:${Response.statusCode}");
        throw Exception("Failed to fetch products");
      }
    } catch (error) {
      print("Error:$error");
      throw Exception("Failed to fetch products");
    }
  }

  //fetch a single product by the api
  Future<Product> fetchSingleProduct(int id) async {
    final String url = "https://fakestoreapi.com/products/$id";
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        Product product = Product.fromJson(json.decode(response.body));
        return product;
      } else {
        print(
            "Failed to fetch the product, status code: ${response.statusCode}");
        throw Exception("Failed to fetch product");
      }
    } catch (error) {
      print("Error: $error");
      throw Exception("Failed to fetch product");
    }
  }
}
