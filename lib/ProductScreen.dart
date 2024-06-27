import 'package:bloc_example/Bloc/PostEvent.dart';
import 'package:bloc_example/Bloc/postBloc.dart';
import 'package:bloc_example/Bloc/productBloc.dart';
import 'package:bloc_example/PostPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class ProductScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ProductBloc productBloc = BlocProvider.of<ProductBloc>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Product List')),
      body: Center(
        child: BlocBuilder<ProductBloc, ProductState>(
          builder: (context, state) {
            print(state == ProductLoadingState);
            if (state is ProductLoadingState) {
              return CircularProgressIndicator();
            } else if (state is ProductLoadedState) {
              final productList = state.productList;
              return ListView.builder(
                itemCount: productList.length,
                itemBuilder: (context, index) {
                  final product = productList[index];
                  return ListTile(
                    title: Text(product['productName']), // Adjust based on your API response structure
                    subtitle: Text(product['productBrandName']), // Adjust based on your API response structure
                  );
                },
              );
            } else if (state is ProductErrorState) {
              return Text('Error: ${state.error}');
            } else {
              return Text('Initial State');
            }
          },
        ),
      ),
      bottomNavigationBar: InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>BlocProvider(
                  create: (context) => PostsBloc()..add(GetPostsEvent()),
                  child: PostsPage(),
                ),
              ));
        },
        child: Container(
          height: 50,
          child: Center(
            child: Text("Show Posts"),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          productBloc.add(FetchProductListEvent());
        },
        child: Icon(Icons.refresh),
      ),
    );
  }
}