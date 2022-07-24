part of 'home_content_bloc.dart';

@immutable
abstract class HomeContentEvent {}

class GetCategoryProductEvent extends HomeContentEvent{
  String slug;
  GetCategoryProductEvent({required this.slug});
}
