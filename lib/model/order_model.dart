class Order {
  String? product_price;
  int? product_quantity;
  String? product_image;
  String? product_name;
  String? id;

  Order(
      {this.product_quantity,
      this.product_price,
       this.id,
      this.product_image,
      this.product_name});

      factory Order.fromJson(Map<String, dynamic> json) {
    
    return Order(
      product_name: json ["product"][0]['product_title'],
      product_quantity: json['quantity'],
      product_price: json["product"][0]['product_price'].toString(),
      product_image: json["product"][0]['product_image'], 
    );
  }
}
