import 'package:bloc/bloc.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';
import 'package:the_gadget_zone/hive/hive_db.dart';
import 'package:the_gadget_zone/http/search_repo.dart';
import 'package:the_gadget_zone/http/user_http.dart';
import 'package:the_gadget_zone/model/product_model.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(SearchInitial()) {
    on<SearchProductEvent>((event, emit) async {
      emit(LoadingSearch());
      try {
        print('in try');
        Box box = await SaveLocally().openBox();
        if (box.isNotEmpty) {
          print('hellhhhhhhhho');
          String token = box.get('token');
          print(token);
          List<ProductModel> searchList =
              await SearchRepo().searchProduct(token: token, name: event.name);

          print(searchList);

          emit(SeachProductState(searchList: searchList));
        }
        else{
          print('not in hive');
        }
      } catch (e) {
        print(e);
      }
    });
  }
}
