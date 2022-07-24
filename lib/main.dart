import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:the_gadget_zone/hive_model/favorite_hive.dart';
import 'package:the_gadget_zone/screen/AddToCart/add_to_cart.dart';
import 'package:the_gadget_zone/screen/Category/category.dart';
import 'package:the_gadget_zone/screen/Delivery/Delivery.dart';
import 'package:the_gadget_zone/screen/HomePage/home_page.dart';
import 'package:the_gadget_zone/screen/Wishlist/wishlist.dart';
import 'package:the_gadget_zone/screen/auth/login.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart' as pathprovider;
import 'package:shake/shake.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final directory = await pathprovider.getApplicationDocumentsDirectory();
  // Hive.initFlutter());
  Hive.init(directory.path);
  Hive.registerAdapter(FavouriteHiveModelAdapter());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const _title = 'TGZ';

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: _title,
      debugShowCheckedModeBanner: false,
      home: Login(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();

}

class _MainScreenState extends State<MainScreen> {
  int currentIndex = 0;

  List<Widget> navigationPages = [
    HomePage(),
    const WishList(),
    const AddToCart(),
    const Category(),
    const Delivery(),
  ];

  changePageIndex(int changedIndex) {
    setState(() {
      currentIndex = changedIndex;
    });
  }

  @override
  void initState() {
    ShakeDetector detector = ShakeDetector.waitForStart(onPhoneShake: () {
      Navigator.push(
          context, MaterialPageRoute(builder: ((context) => const Login())));
    });

    detector.startListening();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationPages[currentIndex],
      bottomNavigationBar: Container(
        height: 60,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Center(
          child: Container(
            constraints: BoxConstraints(maxWidth: 400),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {
                    setState(
                      () {
                        changePageIndex(0);
                      },
                    );
                  },
                  icon: currentIndex == 0
                      ? const Icon(
                          EvaIcons.home,
                          color: Colors.black,
                          size: 30,
                        )
                      : const Icon(
                          EvaIcons.homeOutline,
                          color: Color(0xffbfbfbf),
                          size: 30,
                        ),
                ),
                IconButton(
                  onPressed: () {
                    setState(
                      () {
                        changePageIndex(1);
                      },
                    );
                  },
                  icon: currentIndex == 1
                      ? const Icon(
                          EvaIcons.heart,
                          color: Colors.black,
                          size: 30,
                        )
                      : const Icon(
                          EvaIcons.heartOutline,
                          color: Color(0xffbfbfbf),
                          size: 30,
                        ),
                ),
                Center(
                  child: IconButton(
                    onPressed: () {
                      changePageIndex(2);
                    },
                    icon: currentIndex == 2
                        ? const Icon(
                            EvaIcons.shoppingCart,
                            color: Colors.black,
                            size: 30,
                          )
                        : const Icon(
                            EvaIcons.shoppingCartOutline,
                            color: Color(0xffbfbfbf),
                            size: 30,
                          ),
                  ),
                ),
                // IconButton(
                //   onPressed: () {
                //     changePageIndex(3);
                //   },
                //   icon: currentIndex == 3
                //       ? const Icon(
                //           EvaIcons.grid,
                //           color: Colors.black,
                //           size: 30,
                //         )
                //       : const Icon(
                //           EvaIcons.gridOutline,
                //           color: Color(0xffbfbfbf),
                //           size: 30,
                //         ),
                // ),
                IconButton(
                  onPressed: () {
                    changePageIndex(4);
                  },
                  icon: currentIndex == 4
                      ? const Icon(
                          EvaIcons.car,
                          color: Colors.black,
                          size: 30,
                        )
                      : const Icon(
                          EvaIcons.carOutline,
                          color: Color(0xffbfbfbf),
                          size: 30,
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
