part of 'category_bloc.dart';

@immutable
abstract class CategoryState {}

class CategoryInitial extends CategoryState {}

class CategoryGetSuccess extends CategoryState{
  final List<CategoryModel> categoriesModel;

  CategoryGetSuccess({required this.categoriesModel});
}

class CategoryGetFailed extends CategoryState{
  final message;

  CategoryGetFailed(this.message);
}
