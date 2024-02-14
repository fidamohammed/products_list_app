import 'package:flutter/material.dart';
import 'package:products_list_app/product_list_model.dart';
import 'package:products_list_app/products_detail_screen.dart';
import 'package:products_list_app/products_list_api.dart';
import 'package:products_list_app/products_list_item.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  late Future<List<ProductsListModel>> products;
  @override
  void initState() {
    super.initState();
    products = getProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [],
          title: const Text('Products List'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8),
          child: FutureBuilder(
            future: products,
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      return ProductListItem(
                        productsListModel: snapshot.data[index],
                        onClick: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProductDetailScreen(
                                  productId: snapshot.data[index].id),
                            ),
                          );
                        },
                      );
                    });
              } else if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              } else {
                return const Center(child: CircularProgressIndicator.adaptive());
              }
            },
          ),
        ));
  }
}
