import 'package:bloc/bloc.dart';
import 'package:bloc_example/api/ApiService.dart';
import 'package:http/http.dart' as http;

// Events
abstract class DataEvent {}

class FetchDataEvent extends DataEvent {}

// States
abstract class DataState  {}

class DataInitialState extends DataState {}

class DataLoadingState extends DataState {

}

class DataLoadedState extends DataState {
  final dynamic data;

  DataLoadedState(this.data);
}

class DataErrorState extends DataState {
  final String error;

  DataErrorState(this.error);
}

// Bloc
class DataBloc extends Bloc<DataEvent, DataState> {
  final ApiService apiService;

  DataBloc({required this.apiService}) : super(DataInitialState()) {
    on<FetchDataEvent>(_handleFetchDataEvent);
  }

  Future<void> _handleFetchDataEvent(
      DataEvent event,
      Emitter<DataState> emit,
      ) async {
    // TODO do your thing and create and emit the SignInWithGoogleState
    emit(DataLoadingState());
    try {
      await Future.delayed(Duration(seconds: 1));
      final data = await apiService.fetchData();
      print("DataAll " + data.toString());
      emit(DataLoadedState(data));
    } catch (_) {}
    //emit(DataErrorState("Error Occurs"));
  }

  // @override
  // Stream<DataState> mapEventToState(DataEvent event) async* {
  //   if (event is FetchDataEvent) {
  //     yield DataLoadingState();
  //     try {
  //       final data = await apiService.fetchData();
  //       yield DataLoadedState(data);
  //     } catch (e) {
  //       yield DataErrorState('Failed to fetch data');
  //     }
  //   }
  // }
}
