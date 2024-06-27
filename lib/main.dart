import 'package:bloc_example/api/ApiService.dart';
import 'package:bloc_example/Bloc/PostEvent.dart';
import 'package:bloc_example/Bloc/data_bloc.dart';
import 'package:bloc_example/Bloc/postBloc.dart';
import 'package:bloc_example/Bloc/productBloc.dart';
import 'package:bloc_example/ProductScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final ApiService apiService = ApiService();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) =>
                DataBloc(apiService: apiService)..add(FetchDataEvent()),
          ),
          BlocProvider(
          create: (context) => PostsBloc()..add(GetPostsEvent()),)
          // BlocProvider(
          //  create: (context) => ProductBloc(apiService: apiService)..add(FetchProductListEvent()),),
        ],
        child: DataScreen(),
      ),
    );
  }
}

class DataScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final DataBloc dataBloc = BlocProvider.of<DataBloc>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Data Fetching App')),
      body: Center(
        child: BlocBuilder<DataBloc, DataState>(
          builder: (context, state) {
            print(state is DataLoadingState);
            if (state is DataLoadingState) {
              return CircularProgressIndicator();
            } else if (state is DataLoadedState) {
              return ListView.builder(
                itemCount: state.data.length,
                // Adjust this based on your API response structure
                itemBuilder: (context, index) {
                  final item = state.data[index];
                  return InkWell(
                    onTap: () {
                      ApiService apiService = ApiService();
                      Navigator.of(context).push(
                        PageRouteBuilder(
                          pageBuilder:
                              (context, animation, secondaryAnimation) {
                            return  BlocProvider(
                              create: (context) => ProductBloc(
                                  apiService: apiService,
                                  categoryId: item['categoryId'].toString(),
                                  subCategoryId: "")
                                ..add(FetchProductListEvent()),
                              child: ProductScreen(),
                            );
                          },
                          transitionsBuilder:
                              (context, animation, secondaryAnimation, child) {
                            const begin = Offset(1.0,
                                0.0); //Change bottom to top screen offset(0.0,1.0)
                            const end = Offset.zero;
                            const curve = Curves.easeInOut;
                            var tween = Tween(begin: begin, end: end)
                                .chain(CurveTween(curve: curve));
                            var offsetAnimation = animation.drive(tween);
                            return SlideTransition(
                              // Apply slide transition
                              position: offsetAnimation,
                              child: child,
                            );
                          },
                        ),
                      );
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //       builder: (context) => BlocProvider(
                      //         create: (context) => ProductBloc(
                      //             apiService: apiService,
                      //             categoryId: item['categoryId'].toString(),
                      //             subCategoryId: "")
                      //           ..add(FetchProductListEvent()),
                      //         child: ProductScreen(),
                      //       ),
                      //     ));
                    },
                    child: ListTile(
                      title: Text(item['categoryName']
                          .toString()), // Adjust based on your API response structure
                    ),
                  );
                },
              );
            } else if (state is DataErrorState) {
              return Text('Error: ${state.error}');
            } else {
              return Text('Initial State');
            }
          },
        ),
      ),
      bottomNavigationBar: InkWell(
        onTap: () {
          ApiService apiService = ApiService();
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BlocProvider(
                  create: (context) => ProductBloc(
                      apiService: apiService,
                      categoryId: "1",
                      subCategoryId: "1")
                    ..add(FetchProductListEvent()),
                  child: ProductScreen(),
                ),
              ));
        },
        child: Container(
          height: 50,
          child: Center(
            child: Text("Show Products"),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          dataBloc.add(FetchDataEvent());
        },
        child: Icon(Icons.refresh),
      ),
    );
  }
}
