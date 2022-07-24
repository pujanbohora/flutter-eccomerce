import 'package:flutter/foundation.dart';

class CustomerModel{
   String? fullname;
   String? contactNumber;
   String? email;

  CustomerModel({ this.fullname,  this.contactNumber,  this.email}); 


    factory CustomerModel.fromJson(Map<String, dynamic> json){
      return CustomerModel(
        contactNumber: json['contactNumber'],
        email: json['email'],
        fullname: json['fullname'],

      );
    }

  // Map<String, dynamic> toJson() => {
  //       'name': name,
  //       'email': email,
  //     };
}

