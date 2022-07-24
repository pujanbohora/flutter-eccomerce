part of 'search_bloc.dart';

@immutable
abstract class SearchEvent {}

class SearchProductEvent extends SearchEvent {
  String name;
  SearchProductEvent({required this.name});
}
