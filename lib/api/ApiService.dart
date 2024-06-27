import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
//  static const baseUrl = 'https://www.bbedut.com/bbedut_grocery'; // Replace with your API base URL

  Future<dynamic> fetchData() async {
    final response = await http.get(Uri.parse('https://www.bbedut.com/bbedut_grocery/WS/productData.php?method=getCategoryList'));

    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      return json['data'] as List;
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<dynamic> fetchProductList(String categoryId, String subCategoryId) async {
    final url = Uri.parse('https://www.bbedut.com/bbedut_grocery/WS/productData.php?method=getProductList&categoryId=' + categoryId.toString() +'&subCategoryId='+subCategoryId.toString()+'&limit=0&searchStr=');
    print(url.toString());
    final response = await http.get(url);

    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      return json['data'] as List;
      //return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load product list');
    }
  }
}
