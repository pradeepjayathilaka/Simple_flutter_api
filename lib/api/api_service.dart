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

  //add a product to the api
  Future<Product> addProduct(Product product) async {
    const String url = "https://fakestoreapi.com/products";
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {"Content-Type": "application/json"},
        body: json.encode(product.toJson()),
      );

      print("Response status code: ${response.statusCode}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        Product newProduct = Product.fromJson(json.decode(response.body));
        // Print the full response
        print("Response body: ${response.body}");
        return newProduct;
      } else {
        print("Failed to add product. Status code: ${response.statusCode}");
        print("Response body: ${response.body}");
        throw Exception("Failed to add product");
      }
    } catch (e) {
      print("Error: $e");
      throw Exception("Failed to add product");
    }
  }

  //Update a product in the API
  Future<Product> updatedProduct(int id, Product product) async {
    final String url = "https://fakestoreapi.com/products/$id";
    try {
      final responce = await http.put(
        Uri.parse(url),
        headers: {"Content-Type": "application/json"},
        body: json.encode(product.toJson()),
      );
      if (responce.statusCode == 200) {
        print(("response:${responce.body}"));
        Product updateProduct = Product.fromJson(json.decode(responce.body));
        return updateProduct;
      } else {
        print("Failed to update product.State code:${responce.statusCode}");
        throw Exception("Failed to update product");
      }
    } catch (error) {
      print("Error: $error");
      throw Exception("Failed to update product");
    }
  }
}
