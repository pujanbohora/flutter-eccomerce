part of 'home_content_bloc.dart';

@immutable
abstract class HomeContentState {}

class HomeContentInitial extends HomeContentState {}

class AudioState extends HomeContentState{

  Map<String, dynamic> adsList;
  AudioState(this.adsList);
}
