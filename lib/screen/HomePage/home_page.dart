import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_gadget_zone/blocs/category_bloc/category_bloc.dart';
import 'package:the_gadget_zone/blocs/home_content/home_content_bloc.dart';
import 'package:the_gadget_zone/model/ads_model.dart';
import 'package:the_gadget_zone/model/category_model.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:the_gadget_zone/screen/HomePage/home_category_content.dart';
import 'package:the_gadget_zone/screen/HomePage/profile/profile.dart';
import 'package:the_gadget_zone/screen/HomePage/search/search.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // tabController = TabController(length: 1, vsync: this, initialIndex: 0);
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CategoryBloc()..add(CategoryView()),
        ),
        BlocProvider(
          create: (context) => HomeContentBloc(),
        ),
      ],
      child: MultiBlocListener(
        listeners: [
          BlocListener<CategoryBloc, CategoryState>(
            listener: (context, state) {
              if (state is CategoryGetSuccess) {
                print('successsssss');
                tabController = TabController(
                    length: state.categoriesModel.length, vsync: this);

                BlocProvider.of<HomeContentBloc>(context).add(
                    GetCategoryProductEvent(
                        slug: state.categoriesModel[tabController.index]
                            .slug!)); //null check operator
              }
            },
          ),
          BlocListener<HomeContentBloc, HomeContentState>(
            listener: (context, categorystate) {
              // TODO: implement listener
            },
          ),
        ],
        child: BlocBuilder<CategoryBloc, CategoryState>(
          builder: (context, state) {
            if (state is CategoryGetSuccess) {
              print(tabController.index.toString() + 'hggj');
              return Scaffold(
                backgroundColor: Colors.white,
                appBar: AppBar(
                  automaticallyImplyLeading: false,
                  backgroundColor: Colors.white,
                  elevation: 0,
                  title: const Text(
                    "THEGADGETZONE",
                    style: TextStyle(
                        fontFamily: "MontserratBlack",
                        fontSize: 13,
                        color: Colors.black),
                  ),
                  actions: [
                    IconButton(
                      icon: const Icon(
                        EvaIcons.searchOutline,
                        color: Colors.black,
                        size: 25,
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    SearchProduct()));
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Profile()));
                        },
                        child: const CircleAvatar(
                          radius: 13,
                          backgroundImage:
                              NetworkImage('https://picsum.photos/250?image=9'),
                        ),
                      ),
                    )
                  ],
                  bottom: PreferredSize(
                    preferredSize: const Size(150, 50),
                    child: SizedBox(
                      height: 50,
                      width: 350,
                      child: ListView.builder(
                          padding: EdgeInsets.only(left: 20),
                          scrollDirection: Axis.horizontal,
                          itemCount: state.categoriesModel.length,
                          itemBuilder: (context, index) => InkWell(
                                onTap: () {
                                  BlocProvider.of<HomeContentBloc>(context).add(
                                      GetCategoryProductEvent(
                                          slug: state
                                              .categoriesModel[index].slug!));
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(state.categoriesModel[index]
                                          .categoryName ??
                                      ''),
                                ),
                              )),
                    ),
                  ),
                ),
                body: BlocBuilder<HomeContentBloc, HomeContentState>(
                  builder: (context, categorystate) {
                    if (categorystate is AudioState) {
                      return HomeCategoryContent(categorystate.adsList["ads"],
                          categorystate.adsList["subcatWithProduct"]);
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  },
                ),
              );
            } else {
              return Scaffold(
                body: Center(child: CircularProgressIndicator()),
              );
            }
          },
        ),
      ),
    );
  }
}
