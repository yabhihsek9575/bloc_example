import 'dart:convert';
import 'dart:isolate';

import 'package:bloc_example/Model/popularProductModel.dart';
import 'package:bloc_example/Model/posts_model.dart';
import 'package:http/http.dart';

class RequiredArguments {
  final SendPort sendPort;
  final int page;

  RequiredArguments(this.sendPort, this.page);
}

class PostRepository {
  fetchPosts(int page) async {
    try {
      final receivePort = ReceivePort();
      final isolate = await Isolate.spawn(
        _fetchPostIsolate, RequiredArguments(receivePort.sendPort, page),
      );
      final post = await receivePort.first;
      isolate.kill(priority: Isolate.immediate);
      return post;
    } catch (e) {
      throw Exception(e);
    }
  }

  _fetchPostIsolate(RequiredArguments args) async {
    final sendPort = args.sendPort;
    final String postRoute = 'https://www.bbedut.com/bbedut_grocery/WS/productData.php?method=getProductList&categoryId=' + 1.toString() +'&subCategoryId='+1.toString()+'&limit='+args.page.toString()+'&searchStr=';
        //'https://jsonplaceholder.typicode.com/posts?_limit=10&_page=${args.page}';
    print(postRoute.toString());
    final response = await get(Uri.parse(postRoute));
    List<dynamic> jsonResponse = jsonDecode(response.body)['data'];
    final posts = jsonResponse.map((post) => PopularProductModel.fromJson(post)).toList();
    sendPort.send(posts);
  }
}


// final response = await get(Uri.parse(postRoute));
// List<dynamic> jsonResponse = jsonDecode(response.body);
// final posts =
//     jsonResponse.map((post) => PostModel.fromJson(post)).toList();
// return posts;