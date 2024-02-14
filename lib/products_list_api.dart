import 'package:http/http.dart' as http;
import 'package:products_list_app/product_list_model.dart';
import 'package:products_list_app/product_result_model.dart';

Future<List<ProductsListModel>> getProducts() async{
    try{
      final apiResult = await http.get(Uri.parse('https://dummyjson.com/products'));
      final productList = ProductsResultModel.fromJson(apiResult.body);
      return productList.products!;
    }catch(e){
      throw e.toString();
    }
  }

  Future<ProductsListModel> getProductDetail(int id) async{
    try{
      final apiResult = await http.get(Uri.parse('https://dummyjson.com/products/$id'));
      final productList = ProductsListModel.fromJson(apiResult.body);
      return productList;
    }catch(e){
      throw e.toString();
    }
  }