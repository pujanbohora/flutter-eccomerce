class AdsModel{
    String id;
    String? img;
    AdsModel({required this.id,  this.img});

    factory AdsModel.fromJson(Map<String, dynamic> json){
      print('object1234');
      print(json.toString());
      return AdsModel(id: json["_id"], img: json["img"]);
    }


}