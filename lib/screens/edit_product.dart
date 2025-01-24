import 'package:flutter/material.dart';
import 'package:simple_flutter_api/api/api_service.dart';
import 'package:simple_flutter_api/models/product_model.dart';

class EditProduct extends StatefulWidget {
  final Product product;
  const EditProduct({
    super.key,
    required this.product,
  });

  @override
  State<EditProduct> createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {
  final ApiService apiService = ApiService();
  final _formKey = GlobalKey<FormState>();

  late String title;
  late double price;
  late String descripton;
  late String image;
  late String category;

  @override
  void initState() {
    super.initState();
    title = widget.product.title;
    price = widget.product.price;
    descripton = widget.product.description;
    image = widget.product.image;
    category = widget.product.category;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Product"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: title,
                decoration: const InputDecoration(
                  labelText: 'Title',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
                onSaved: (value) {
                  title = value!;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                initialValue: price.toString(),
                decoration: const InputDecoration(labelText: 'price'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please Enter a price';
                  }
                  return null;
                },
                onSaved: (Value) {
                  price = double.parse(Value!);
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                initialValue: descripton,
                decoration: const InputDecoration(labelText: 'Description'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
                onSaved: (value) {
                  descripton = value!;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                initialValue: image,
                decoration: InputDecoration(labelText: 'Image URL'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an image URL';
                  }
                  return null;
                },
                onSaved: (value) {
                  image = value!;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                initialValue: category,
                decoration: const InputDecoration(labelText: 'Category'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a category';
                  }
                  return null;
                },
                onSaved: (value) {
                  category = value!;
                },
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    Product updatedProduct = Product(
                      title: title,
                      price: price,
                      description: descripton,
                      image: image,
                      category: category,
                    );
                    try {
                      apiService.updatedProduct(
                          widget.product.id!, updatedProduct);
                      Navigator.pop(context);
                    } catch (error) {
                      print(error.toString());
                    }
                  }
                },
                child: const Text('Update Product'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
