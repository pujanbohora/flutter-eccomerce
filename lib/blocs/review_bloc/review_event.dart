part of 'review_bloc.dart';

@immutable
abstract class ReviewEvent {}

class ReviewPostEvent extends ReviewEvent{
  String pid;
  String review;
  ReviewPostEvent({required this.review, required this.pid});
}

class ReviewViewEvent extends ReviewEvent{
  String productId;

  ReviewViewEvent({required this.productId});
}


