part of 'category_bloc.dart';

@immutable
abstract class CategoryEvent {}

class CategoryView extends CategoryEvent{}

// class GetCategoryProduct extends  CategoryEvent{
//   String slug;
//   GetCategoryProduct({required this.slug});
// }
