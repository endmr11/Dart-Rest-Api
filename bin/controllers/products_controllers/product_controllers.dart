import 'package:alfred/alfred.dart';

import '../../config/config.dart';

class ProductControllers extends Config {
  allProductsController(HttpRequest req, HttpResponse res) async {
    print("Controller: allProductsController start");
  }

  productController(HttpRequest req, HttpResponse res) async {
    print("Controller: productController start");
    String productId = req.params['id'];
  }
}
