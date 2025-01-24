import 'package:flutter/material.dart';
import 'package:simple_flutter_api/api/api_service.dart';
import 'package:simple_flutter_api/models/product_model.dart';
import 'package:simple_flutter_api/screens/edit_product.dart';

class SingleProduct extends StatelessWidget {
  final int productId;
  SingleProduct({
    super.key,
    required this.productId,
  });
  final ApiService apiService = ApiService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Product Details"),
      ),
      body: SingleChildScrollView(
        child: FutureBuilder<Product>(
          future: apiService.fetchSingleProduct(productId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text("error: ${snapshot.error}"),
              );
            } else if (!snapshot.hasData) {
              return const Center(
                child: Text("Product not found"),
              );
            } else {
              Product product = snapshot.data!;

              return Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.network(
                      product.image,
                      width: 400,
                      height: 400,
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(height: 16.0),
                    Text(
                      product.title,
                      style: TextStyle(
                        fontSize: 24,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      "\$${product.price}",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Text(product.description),
                    const SizedBox(height: 30.0),
                    Row(
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    EditProduct(product: product),
                              ),
                            );
                          },
                          child: Text("Updated"),
                        ),
                        ElevatedButton(
                          onPressed: () {},
                          child: const Text("Delete"),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
