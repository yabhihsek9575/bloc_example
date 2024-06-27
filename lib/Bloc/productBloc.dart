import 'package:bloc/bloc.dart';
import 'package:bloc_example/api/ApiService.dart';

// Events
abstract class ProductEvent {}

class FetchProductListEvent extends ProductEvent {}

// States
abstract class ProductState {}

class ProductInitialState extends ProductState {}

class ProductLoadingState extends ProductState {}

class ProductLoadedState extends ProductState {
  final dynamic productList;

  ProductLoadedState(this.productList);
}

class ProductErrorState extends ProductState {
  final String error;

  ProductErrorState(this.error);
}

// Bloc
class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ApiService apiService;
  final categoryId, subCategoryId;

  ProductBloc({this.categoryId, this.subCategoryId,required this.apiService}) : super(ProductInitialState()){
    on<FetchProductListEvent>(_handleFetchDataEvent);
  }


  Future<void> _handleFetchDataEvent(
      ProductEvent event,
      Emitter<ProductState> emit,
      ) async {
    // TODO do your thing and create and emit the SignInWithGoogleState
    emit(ProductLoadingState());
    try {
       await Future.delayed(Duration(seconds: 1));
      final productList = await apiService.fetchProductList(categoryId.toString(),subCategoryId.toString());
      print("DataAll " + productList.toString());
      emit(ProductLoadedState(productList));
    } catch (_) {
      emit(ProductErrorState("Error Occurs"));
    }
    //emit(DataErrorState("Error Occurs"));
  }

  // @override
  // Stream<ProductState> mapEventToState(ProductEvent event) async* {
  //   if (event is FetchProductListEvent) {
  //     yield ProductLoadingState();
  //     try {
  //       final productList = await apiService.productList();
  //       yield ProductLoadedState(productList);
  //     } catch (e) {
  //       yield ProductErrorState('Failed to fetch product list');
  //     }
  //   }
  // }
}
