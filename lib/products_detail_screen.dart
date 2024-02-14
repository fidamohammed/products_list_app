import 'package:flutter/material.dart';
import 'package:products_list_app/product_list_model.dart';
import 'package:products_list_app/products_list_api.dart';


class ProductDetailScreen extends StatelessWidget {
  final int productId;
  const ProductDetailScreen({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {
    // final productDetail = getProductDetail(productId);
    return FutureBuilder(
      future: getProductDetail(productId),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasData) {
          final productDetails = snapshot.data as ProductsListModel;
          return Scaffold(
            appBar: AppBar(
              title: Text(productDetails.title ?? "Product Detail"),
            ),
            body: Center(
              child: Column(
                children: [
                  _titleCard(context, productDetails),
                  _detailBody(productDetails),
                  _images(productDetails),
                ],
              ),
            ),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text(snapshot.error.toString()),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}

Widget _titleCard(BuildContext context, ProductsListModel product) {
  return SizedBox(
    width: MediaQuery.of(context).size.width,
    child: Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: 200,
            decoration: BoxDecoration(
              // shape: BoxShape.circle,
              image: DecorationImage(
                  image: NetworkImage(
                    product.thumbnail ?? "",
                  ),
                  fit: BoxFit.cover),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            product.title ?? "",
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      ),
    ),
  );
}

Widget _detailBody(ProductsListModel product) {
  return Column(
    children: [
      Text(product.description ?? ""),
      Text(product.rating.toString()),
      Text(product.category ?? ""),
      Text(product.brand ?? "")
    ],
  );
}

Widget _images(ProductsListModel product) {
  return Container(
    height: 200,
    child: ListView(
      scrollDirection: Axis.horizontal,
      children: product.images?.map(
            (e) {
              return Container(
                padding: EdgeInsets.all(10),
                width: 150,
                child: Image.network(
                  e,
                  fit: BoxFit.fitWidth,
                ),
              );
            },
          ).toList() ??
          [],
    ),
  );
}

// class ProductDetailScreen extends StatefulWidget {
//   final int productId;
//   const ProductDetailScreen({super.key, required this.productId});

//   @override
//   State<ProductDetailScreen> createState() => _ProductDetailScreenState();
// }

// class _ProductDetailScreenState extends State<ProductDetailScreen> {

//   late Future<ProductsListModel> productDetail;

//   @override
//   void initState() {
//     super.initState();
//     productDetail = getProductDetail(widget.productId);
//   }

//   @override
//   Widget build(BuildContext context) {
    
//     return FutureBuilder(
//       future: productDetail,
//       builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
//         if (snapshot.hasData) {
//           final productDetails = snapshot.data as ProductsListModel;
//           return Scaffold(
//             appBar: AppBar(
//               title: Text(productDetails.title ?? "Product Detail"),
//             ),
//             body: Center(
//               child: Column(
//                 children: [
//                   _titleCard(context, productDetails),
//                   _detailBody(productDetails),
//                   _images(productDetails),
//                 ],
//               ),
//             ),
//           );
//         } else if (snapshot.hasError) {
//           return Center(
//             child: Text(snapshot.error.toString()),
//           );
//         } else {
//           return const Center(
//             child: CircularProgressIndicator.adaptive(),
//           );
//         }
//       },
//     );
//   }
// }
