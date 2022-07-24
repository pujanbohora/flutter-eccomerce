import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'advertisment_event.dart';
part 'advertisment_state.dart';

class AdvertismentBloc extends Bloc<AdvertismentEvent, AdvertismentState> {
  AdvertismentBloc() : super(AdvertismentInitial()) {
    on<AdvertismentEvent>((event, emit) {
    });
  }
}
