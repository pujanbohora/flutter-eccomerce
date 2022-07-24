import 'package:bloc/bloc.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';
import 'package:the_gadget_zone/hive/hive_db.dart';
import 'package:the_gadget_zone/http/category_view_repo.dart';
import 'package:the_gadget_zone/model/ads_model.dart';

part 'home_content_event.dart';
part 'home_content_state.dart';

class HomeContentBloc extends Bloc<HomeContentEvent, HomeContentState> {
  HomeContentBloc() : super(HomeContentInitial()) {
    on<GetCategoryProductEvent>((event, emit)async{
      print('sdhfjkhsjkdfhsdjkhfjksdhfjkdshjkfhsdpawan');
      try {
        Box box = await SaveLocally().openBox();
        if(box.isNotEmpty){
          String token = box.get("token");
          Map<String ,dynamic> adsMap= await ViewCategoryRepo().viewCategory(token: token, slug: event.slug);
  
          print(event.slug);
          emit(AudioState(adsMap));
        }
      } catch (e) {
      }
    });
  }
}
