part of 'review_bloc.dart';

@immutable
abstract class ReviewState {}

class ReviewInitial extends ReviewState {}

class AddReviewSuccess extends ReviewState {
  String? message;
  AddReviewSuccess({this.message});
}

class ViewReviewState extends ReviewState{
  final List <ReviewModel>? reviews;

  ViewReviewState({this.reviews});

}