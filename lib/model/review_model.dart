
class ReviewModel {
  String? email;
  String? name;
  String? review;

  ReviewModel({this.email, this.name, this.review});

  factory ReviewModel.fromJson(Map<String, dynamic>json){
    print('in review model');
    return ReviewModel(
      email: json['email'],
      name: json['fullname'],
      review: json["review"]
    );
  }
}