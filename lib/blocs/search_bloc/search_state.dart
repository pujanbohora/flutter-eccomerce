part of 'search_bloc.dart';

@immutable
abstract class SearchState {}

class SearchInitial extends SearchState {}

class SeachProductState extends SearchState {
  final List<ProductModel> searchList;

  SeachProductState({required this.searchList});
}

class LoadingSearch extends SearchState{}
