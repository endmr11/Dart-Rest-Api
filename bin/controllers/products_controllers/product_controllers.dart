import 'dart:convert';

import 'package:alfred/alfred.dart';

import '../../config/config.dart';

class ProductControllers extends Config {
  allProductsController(HttpRequest req, HttpResponse res) async {
    print("Controller: allProductsController start");
    final response = await dbConfig.getAllProducts();
    List<Map<String, dynamic>> model = [];
    for (final element in response) {
      Map<String, dynamic> modelMap = {'product_id': element[0], 'product_name': element[1], 'product_desc': element[2], 'product_price': element[3],'product_url': element[4]};
      model.add(modelMap);
    }
    final responseMap = generateOkResMap("/products/all-products", model,true);
    res.send(jsonEncode(responseMap));
  }

  productController(HttpRequest req, HttpResponse res) async {
    print("Controller: productController start");
    String productId = req.params['id'];
    final response = await dbConfig.getProduct(productId);
    List<Map<String, dynamic>> model = [];
    for (final element in response) {
      Map<String, dynamic> modelMap = {'product_id': element[0], 'product_name': element[1], 'product_desc': element[2], 'product_price': element[3],'product_url': element[4]};
      model.add(modelMap);
    }
    if (model.isNotEmpty) {
      final responseMap = generateOkResMap("/products/product/$productId", model,true);
      res.send(jsonEncode(responseMap));
    } else {
      throw AlfredException(400, generateOkResMap("/products/product/$productId", {"error":"Product Error"},false));
    }
  }
}
