class MyOrderModel {
  String? address;
  String? locality;
  String? totalAmount;
  String? orderStatus;
  String? date;
  List? productsName;

  String? admin_name;
  String? admin_image;
  int?admin_price;
  String?admin_address;
  String?admin_locality;
  String?admin_username;
  String? admin_email;
  String? admin_orderStatus;
  String? admin_date;
  int? admin_quantity;
  int? admin_totalAmount;
  String? admin_number;
  String? admin_id;

  


  MyOrderModel(
      {this.address,
      this.locality,
      this.totalAmount,
      this.orderStatus,
      this.date, this.productsName,

      this.admin_name,
      this.admin_image,
      this.admin_price,
      this.admin_quantity,
      this.admin_email,
      this.admin_address,
      this.admin_locality,
      this.admin_username,
      this.admin_totalAmount,
      this.admin_number,
      this.admin_orderStatus,
      this.admin_date,
      this.admin_id});

  factory MyOrderModel.fromJson(Map<String, dynamic> json) {
    return MyOrderModel(
        address: json["address"],
        locality: json["locality"],
        totalAmount: json["totalAmount"].toString(),
        orderStatus: json["orderStatus"],
        date: json["date"],
        productsName: json["products"]);
  }

  factory MyOrderModel.fromAdminOrder(Map<String, dynamic> json) {
    return MyOrderModel(
        // address: json["address"],
        // locality: json["locality"],
        // totalAmount: json["totalAmount"].toString(),
        // orderStatus: json["orderStatus"],
        // date: json["date"],
        admin_name: json["name"],
        admin_image: json["image"],
        admin_price: json["price"],
        admin_quantity: json["quantity"],
        admin_email: json["email"],
        admin_address: json["address"],
        admin_locality: json["locality"],
        admin_username: json["usernanme"],
        admin_totalAmount: json["totalAmount"],
        admin_number: json["number"],
        admin_date: json["date"],
        admin_orderStatus: json["orderStatus"],
        admin_id: json["_id"]);
        
  }
}
