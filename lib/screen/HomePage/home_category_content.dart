import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:the_gadget_zone/api_helper/api_url.dart';
import 'package:the_gadget_zone/hive_model/favorite_hive.dart';
import 'package:the_gadget_zone/model/ads_model.dart';
import 'package:the_gadget_zone/model/product_model.dart';
import 'package:the_gadget_zone/model/subcat_model.dart';
import 'package:the_gadget_zone/screen/HomePage/Each_category_page.dart';
import 'package:the_gadget_zone/screen/HomePage/pagination.dart';
import 'package:the_gadget_zone/screen/HomePage/view_product_details.dart';
import 'package:the_gadget_zone/screen/Model/productmodel.dart';

class HomeCategoryContent extends StatefulWidget {
  final List<AdsModel> adsList;
  final List<SubCategoryModel> subcatWithProduct;
  HomeCategoryContent(this.adsList, this.subcatWithProduct);

  FavouriteHiveModel favoriteList = FavouriteHiveModel();

  @override
  _HomeCategoryContentState createState() => _HomeCategoryContentState();
}

class _HomeCategoryContentState extends State<HomeCategoryContent> {
  List<String> advertiseImages = [
    'https://i.pinimg.com/564x/02/32/34/023234c35151d64c76aa844ec21e26c1.jpg',
    'https://i.pinimg.com/564x/07/93/84/079384ceb3664eb57df7ba66f917b7d1.jpg',
    'https://i.pinimg.com/564x/aa/3a/2f/aa3a2f7c6560a3ea9429c7741a883330.jpg',
    'https://i.pinimg.com/564x/0a/3d/6b/0a3d6b2e02490b5ed1220c25126538d8.jpg'
  ];

  // List<String> recommendedImage = [
  //   'https://i.pinimg.com/564x/ad/e9/0d/ade90de3da6e80550c152a0444f36b40.jpg',
  //   'https://i.pinimg.com/564x/99/5b/74/995b74b22e17748ccd5d6d0c599e894d.jpg',
  //   'https://i.pinimg.com/564x/82/94/b7/8294b79dd32ea5149089d12acf85c59e.jpg',
  //   'https://i.pinimg.com/564x/4e/5e/27/4e5e27bd2b93bbc001b6edddcc196cfb.jpg'
  // ];

  List<String> bestPickImages = [
    'https://i.pinimg.com/564x/47/92/d6/4792d679c023b86ab400cf3d883349b6.jpg',
    'https://i.pinimg.com/564x/be/03/28/be0328cae3a623fe0a93cfbff56295c2.jpg',
    'https://i.pinimg.com/564x/f3/3a/4e/f33a4ecd4ead0d8c053b9831b6059b8e.jpg',
    'https://i.pinimg.com/564x/f6/66/bb/f666bba8f341b4eeb7eb8cbc772d1c80.jpg'
  ];

  List<String> forYouImages = [
    'https://i.pinimg.com/564x/fc/42/19/fc4219ed4585de7064cb740c7090095b.jpg',
    'https://i.pinimg.com/564x/e6/9d/1b/e69d1b9d214ea335b96c22268c69aca0.jpg',
    'https://i.pinimg.com/564x/f6/66/bb/f666bba8f341b4eeb7eb8cbc772d1c80.jpg',
    'https://i.pinimg.com/564x/95/d3/e4/95d3e4a49c2f85f3825c19532426cfb3.jpg'
  ];

  // List<FavouriteHiveModel> list = [];
  // final CarouselController _advertiseCarouselController = CarouselController();

  addToHive(FavouriteHiveModel obj) async {
    var box = await Hive.openBox('favorite');

    List searchedKList = box.values
        .where((element) => element.product_title == obj.product_title)
        .toList();
    if (searchedKList.isEmpty) {
      print('hello here');
      box.add(obj);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Product already added to Favorite')));
      return;
    }
  }

  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    print(widget.subcatWithProduct);
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 10),
          CarouselWidget(widget.adsList),
          //Recommended
          const SizedBox(
            height: 12,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Container(
                alignment: Alignment.topLeft,
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const EachCategoryPage()));
                  },
                  child: const Text(
                    'Available Produts',
                    style: TextStyle(
                        fontFamily: 'Montserramedium',
                        fontWeight: FontWeight.bold,
                        fontSize: 15),
                  ),
                )),
          ),
          const SizedBox(
            height: 2,
          ),
          const SizedBox(
            height: 12,
          ),
          ...widget.subcatWithProduct.map((e) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    child: Container(
                        alignment: Alignment.topLeft,
                        child: Text(
                          e.subCat_name!,
                          style: TextStyle(
                              fontFamily: 'Montserramedium',
                              fontWeight: FontWeight.bold,
                              fontSize: 15),
                        )),
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  SizedBox(
                    height: 240,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemCount: e.subCatListOfProducts!.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ProductDetails(
                                      ProductList:
                                          e.subCatListOfProducts![index],
                                      itemModel: items[index],
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: const Color(0xfff0f5f9),
                                ),
                                child: Column(
                                  children: [
                                    Stack(
                                      children: [
                                        Container(
                                          height: 160,
                                          width: 160,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              image: DecorationImage(
                                                  image: NetworkImage(
                                                    ApiUrl.baseUrl +
                                                        '/' +
                                                        e
                                                            .subCatListOfProducts![
                                                                index]
                                                            .product_image!,
                                                  ),
                                                  fit: BoxFit.cover)),
                                        ),
                                        Positioned(
                                          right: 9,
                                          top: 7,
                                          child: InkWell(
                                            onTap: () {
                                              addToHive(FavouriteHiveModel(
                                                  product_title: e
                                                      .subCatListOfProducts![
                                                          index]
                                                      .product_title,
                                                  product_price: e
                                                      .subCatListOfProducts![
                                                          index]
                                                      .product_price,
                                                  product_quantity: e
                                                      .subCatListOfProducts![
                                                          index]
                                                      .product_quantity,
                                                  product_image: e
                                                      .subCatListOfProducts![
                                                          index]
                                                      .product_image));
                                            },
                                            child: Container(
                                              height: 20,
                                              width: 20,
                                              decoration: const BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: Color(0xff635c5b)),
                                              child: const Icon(
                                                EvaIcons.heart,
                                                color: Color(0xffed503b),
                                                size: 15,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Flexible(
                                      child: Container(
                                          width: 160,
                                          decoration: const BoxDecoration(
                                            borderRadius: BorderRadius.vertical(
                                                bottom: Radius.circular(8)),
                                          ),
                                          alignment: Alignment.topLeft,
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 10),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  e.subCatListOfProducts![index]
                                                      .product_title!,
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Text(
                                                  'Rs. ' +
                                                      e
                                                          .subCatListOfProducts![
                                                              index]
                                                          .product_price!,
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                          )),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
                  ),
                ],
              )),
          const SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }
}
