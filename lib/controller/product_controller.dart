import 'package:http/http.dart' as http;
import 'package:shop_api/model/product_model.dart';
import 'package:shop_api/server/global_service.dart';

class ProductController {
  Future getProucts() async {
    String url = ApiRoute().productRoute;
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return productModelFromJson(response.body);
    }
    return [];
  }
}
