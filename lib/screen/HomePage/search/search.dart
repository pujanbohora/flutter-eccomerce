import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_gadget_zone/api_helper/api_url.dart';
import 'package:the_gadget_zone/blocs/search_bloc/search_bloc.dart';

class SearchProduct extends StatefulWidget {
  const SearchProduct({Key? key}) : super(key: key);

  @override
  _SearchProductState createState() => _SearchProductState();
}

class _SearchProductState extends State<SearchProduct> {
  TextEditingController name = TextEditingController();

  // bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SearchBloc>(
      create: (context) => SearchBloc(),
      child: BlocConsumer<SearchBloc, SearchState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          if (state is SeachProductState) {
            return Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                elevation: 0,
                iconTheme: const IconThemeData(color: Colors.black),
                backgroundColor: Colors.white,
                title: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        key: Key('Search'),
                        controller: name,
                        style: const TextStyle(color: Colors.black),
                        cursorColor: Colors.black,
                        decoration: const InputDecoration(
                          hintText: 'Search',
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black)),
                        ),
                      ),
                    ),
                    InkWell(
                        onTap: () {
                          // isLoading =! isLoading;
                          BlocProvider.of<SearchBloc>(context)
                            ..add(SearchProductEvent(name: name.text));
                        },
                        child: Icon(EvaIcons.search))
                  ],
                ),
              ),
              body: SingleChildScrollView(
                child: Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.only(top: 10),
                    child: Wrap(
                      runAlignment: WrapAlignment.center,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      alignment: WrapAlignment.center,
                      runSpacing: 20,
                      spacing: 20,
                      direction: Axis.horizontal,
                      children: state.searchList
                          .map((item) => Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(0),
                                  color: const Color(0xfff0f5f9),
                                ),
                                child: Container(
                                  child: Column(
                                    children: [
                                      Container(
                                        height: 200,
                                        width: 157,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(0),
                                            image: DecorationImage(
                                                image: NetworkImage(
                                                  (ApiUrl.baseUrl +
                                                      '/' +
                                                      item.product_image!),
                                                ),
                                                fit: BoxFit.cover)),
                                      ),
                                      Container(
                                        width: 150,
                                        decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.vertical(
                                              bottom: Radius.circular(8)),
                                        ),
                                        alignment: Alignment.topLeft,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 5, vertical: 5),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                item.product_title!,
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 2,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 14),
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                  'Rs. ' + item.product_price!),
                                              SizedBox(
                                                height: 3,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ))
                          .toList(),
                    )),
              ),
            );
          } else if (state is LoadingSearch) {
            return Scaffold(body: Center(child: CircularProgressIndicator()));
          } else {
            return Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                elevation: 0,
                iconTheme: const IconThemeData(color: Colors.black),
                backgroundColor: Colors.white,
                title: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: name,
                        style: const TextStyle(color: Colors.black),
                        cursorColor: Colors.black,
                        decoration: const InputDecoration(
                          hintText: 'Search',
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black)),
                        ),
                      ),
                    ),
                    InkWell(
                        onTap: () {
                          BlocProvider.of<SearchBloc>(context)
                            ..add(SearchProductEvent(name: name.text));
                        },
                        child: Icon(EvaIcons.search))
                  ],
                ),
              ),
              body: Center(child: Text('Search Product')),
            );
          }
        },
      ),
    );
  }
}
