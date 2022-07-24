import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:the_gadget_zone/api_helper/api_url.dart';
import 'package:the_gadget_zone/hive_model/favorite_hive.dart';
import 'package:the_gadget_zone/model/product_model.dart';

class WishList extends StatefulWidget {
  const WishList({Key? key}) : super(key: key);

  @override
  _WishListState createState() => _WishListState();
}

class _WishListState extends State<WishList> {


  clearFav() async {
    var box = await Hive.openBox('favorite');
    box.clear();
    setState(() {});
  }

  Future openBox() async {
    var box = await Hive.openBox('favorite');

    var listOf = box.values.toList();

    print(listOf);
    print('pawanisa hero');
    return listOf;
  }

  @override
  void dispose() {
    // TODO: implement dis
    //
    // Hpose

    Hive.close();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Favourite',
          style:
              TextStyle(color: Colors.black, fontFamily: 'Montserratlsemibold'),
        ),
        actions: [
          TextButton(
              onPressed: () {
                clearFav();
              },
              child: Text('Clear'))
        ],
      ),
      body: FutureBuilder(
          future: openBox(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return GridView.builder(
                  itemCount: snapshot.data!.length,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 0.81,
                      crossAxisCount: MediaQuery.of(context).size.width < 768 ? 2 : 4,
                      crossAxisSpacing: 15.0,
                      mainAxisSpacing: 20.0),
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Container()),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: const Color(0xfff0f5f9),
                          
                        ),
                        child: Column(
                          children: [
                            Column(
                              children: [
                                Container(
                                  height: MediaQuery.of(context).size.width< 768 ? 152 : 300,
                                  // width: 157,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(0),
                                      image: DecorationImage(
                                          image: NetworkImage(
                                            (ApiUrl.baseUrl+'/'+ snapshot.data![index].product_image),
                                          ),
                                          fit: BoxFit.contain)),
                                ),
                              ],
                            ),
                            Container(
                              // width: 150,
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.vertical(
                                    bottom: Radius.circular(8)),
                              ),
                              alignment: Alignment.topLeft,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 5, vertical: 5),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      snapshot.data![index].product_title,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14),
                                    ),
                                    const SizedBox(
                                      height: 3,
                                    ),
                                    RichText(
                                      text: TextSpan(
                                          text: 'Rs. ',
                                          style: TextStyle(color: Colors.black),
                                          children: [
                                            TextSpan(
                                              text: snapshot.data![index].product_price,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 19,
                                                  color: Colors.black),
                                            ),
                                          ]),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  });
            } else if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            } else {
              return Center(child: Text('No Favorite to Show'));
            }
          }),
    );
  }
}
