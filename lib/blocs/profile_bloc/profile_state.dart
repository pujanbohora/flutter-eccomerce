part of 'profile_bloc.dart';

@immutable
abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class LoadingState extends ProfileState{}

class ProfileUpdateSucess extends ProfileState {
  final String message;
  ProfileUpdateSucess({required this.message});
}

class ProfileUpdateFailed extends ProfileState {
  final String message;
  ProfileUpdateFailed({required this.message});
}

class ProfileViewFailed extends ProfileState {
  final String message;
  ProfileViewFailed({required this.message});
}

class ProfileViewSuccess extends ProfileState{
  final CustomerModel profileSave;
  ProfileViewSuccess({required this.profileSave});
}
