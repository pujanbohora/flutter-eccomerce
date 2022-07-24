
import 'package:flutter/material.dart';

class Category extends StatefulWidget {
  const Category({Key? key}) : super(key: key);

  @override
  _CategoryState createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Categoriess',
          style:
              TextStyle(fontFamily: 'Montserratlsemibold', color: Colors.black),
        ),
      ),
      body: GridView.builder(
          itemCount: 4,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: 0.709,
              crossAxisCount: 2,
              crossAxisSpacing: 15.0,
              mainAxisSpacing: 20.0),
          itemBuilder: (BuildContext context, int index) {
            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(0),
                color: const Color(0xfff0f5f9),
              ),
              child: Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        height: 200,
                        // width: 157,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(0),
                            image: const DecorationImage(
                                image: NetworkImage(
                                  ('https://i.pinimg.com/564x/0a/3d/6b/0a3d6b2e02490b5ed1220c25126538d8.jpg'),
                                ),
                                fit: BoxFit.cover)),
                      ),
                    ],
                  ),
                  Container(
                    width: 150,
                    decoration: const BoxDecoration(
                      borderRadius:
                          BorderRadius.vertical(bottom: Radius.circular(8)),
                    ),
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 5, vertical: 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'Audio',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 14),
                          ),
                          SizedBox(
                            height: 3,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }
}
