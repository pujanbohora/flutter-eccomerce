part of 'profile_bloc.dart';

@immutable
abstract class ProfileEvent {}

class ProfileUpdateEvent extends ProfileEvent{
  String? fullname;
  String? phone;

  ProfileUpdateEvent({this.fullname, this.phone});
}

class ProfileShow extends ProfileEvent{}
