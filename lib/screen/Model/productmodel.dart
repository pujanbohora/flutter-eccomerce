// ignore_for_file: file_names

class ItemModel {
  int id;
  String title;
  String price;
  List<String> alternativeImages;
  String? coverImage;
  String description;
  DateTime? createdAt;
  DateTime? updatedAt;

  ItemModel(
      {required this.id,
      required this.title,
      required this.price,
      required this.alternativeImages,
      this.coverImage,
      required this.description,
      this.createdAt,
      this.updatedAt});
}

List<ItemModel> items = [
  ItemModel(
    id: 1,
    title: "Iphone",
    price: "800010",
    alternativeImages: [
      'https://i.pinimg.com/564x/02/32/34/023234c35151d64c76aa844ec21e26c1.jpg',
      'https://i.pinimg.com/564x/07/93/84/079384ceb3664eb57df7ba66f917b7d1.jpg',
      'https://i.pinimg.com/564x/aa/3a/2f/aa3a2f7c6560a3ea9429c7741a883330.jpg',
      'https://i.pinimg.com/564x/0a/3d/6b/0a3d6b2e02490b5ed1220c25126538d8.jpg',
      'https://i.pinimg.com/564x/7a/9e/1d/7a9e1d169534471ba5c4088c4dedd2f2.jpg'
    ],
    coverImage:
        'https://i.pinimg.com/564x/02/32/34/023234c35151d64c76aa844ec21e26c1.jpg',
    description: 'Lorem',
  ),
  ItemModel(
    id: 2,
    title: "Airpods",
    price: "800",
    alternativeImages: [
      'https://i.pinimg.com/564x/a8/4c/bb/a84cbbda3fe77b9b72898d4abaddd9ac.jpg',
      'https://i.pinimg.com/564x/30/87/96/30879615e175002755303ddd7f242a7b.jpg',
      'https://i.pinimg.com/564x/83/38/e6/8338e698f48b526de8854a7d41bf91f9.jpg',
      'https://i.pinimg.com/564x/62/f9/0a/62f90abb0dda73d93002cf3b1781bf45.jpg',
      'https://i.pinimg.com/564x/7a/9e/1d/7a9e1d169534471ba5c4088c4dedd2f2.jpg'
    ],
    coverImage:
        'https://i.pinimg.com/564x/7a/9e/1d/7a9e1d169534471ba5c4088c4dedd2f2.jpg',
    description: 'Lorem',
  ),
  ItemModel(
    id: 3,
    title: "Iphone",
    price: "800010",
    alternativeImages: [
      'https://i.pinimg.com/564x/02/32/34/023234c35151d64c76aa844ec21e26c1.jpg',
      'https://i.pinimg.com/564x/07/93/84/079384ceb3664eb57df7ba66f917b7d1.jpg',
      'https://i.pinimg.com/564x/aa/3a/2f/aa3a2f7c6560a3ea9429c7741a883330.jpg',
      'https://i.pinimg.com/564x/0a/3d/6b/0a3d6b2e02490b5ed1220c25126538d8.jpg',
      'https://i.pinimg.com/564x/7a/9e/1d/7a9e1d169534471ba5c4088c4dedd2f2.jpg'
    ],
    coverImage:
        'https://i.pinimg.com/564x/02/32/34/023234c35151d64c76aa844ec21e26c1.jpg',
    description: 'Lorem',
  ),
  ItemModel(
    id: 4,
    title: "Airpods",
    price: "800",
    alternativeImages: [
      'https://i.pinimg.com/564x/a8/4c/bb/a84cbbda3fe77b9b72898d4abaddd9ac.jpg',
      'https://i.pinimg.com/564x/30/87/96/30879615e175002755303ddd7f242a7b.jpg',
      'https://i.pinimg.com/564x/83/38/e6/8338e698f48b526de8854a7d41bf91f9.jpg',
      'https://i.pinimg.com/564x/62/f9/0a/62f90abb0dda73d93002cf3b1781bf45.jpg',
      'https://i.pinimg.com/564x/7a/9e/1d/7a9e1d169534471ba5c4088c4dedd2f2.jpg'
    ],
    coverImage:
        'https://i.pinimg.com/564x/7a/9e/1d/7a9e1d169534471ba5c4088c4dedd2f2.jpg',
    description: 'Lorem',
  ),
];
 