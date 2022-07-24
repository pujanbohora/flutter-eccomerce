import 'dart:ui';

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_gadget_zone/api_helper/api_url.dart';
import 'package:the_gadget_zone/blocs/order_bloc/order_bloc.dart';
import 'package:the_gadget_zone/model/order_model.dart';
import 'package:the_gadget_zone/screen/AddToCart/checkout.dart';

class AddToCart extends StatefulWidget {
  const AddToCart({Key? key}) : super(key: key);

  @override
  _AddToCartState createState() => _AddToCartState();
}

class _AddToCartState extends State<AddToCart> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  showAddtoCartBottomSheet(BuildContext context, {required int totalPrice}) {
    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      _scaffoldKey.currentState!.showBottomSheet((context) {
        return Container(
          color: Colors.grey[200],
          child: BlocProvider<OrderBloc>(
            create: (context) => OrderBloc()..add(GetCartProduct()),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Sub Total',
                        style: TextStyle(fontSize: 18),
                      ),
                      RichText(
                        text: TextSpan(
                            text: 'Rs ',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                            children: [
                              TextSpan(
                                  text: totalPrice.toString(),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color: Colors.black,
                                  ))
                            ]),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Delivery Charge',
                        style: TextStyle(fontSize: 18),
                      ),
                      RichText(
                        text: const TextSpan(
                            text: 'Rs ',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                            children: [
                              TextSpan(
                                  text: '100.00',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color: Colors.black,
                                  ))
                            ]),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        height: 1,
                        width: 90,
                        color: Colors.grey,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Total',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      RichText(
                        text: TextSpan(
                            text: 'Rs ',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                            children: [
                              TextSpan(
                                  text: (totalPrice + 100).toString(),
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color: Colors.black,
                                  ))
                            ]),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Checkout()),
                      );
                    },
                    child: Container(
                        height: 40,
                        width: MediaQuery.of(context).size.width < 768
                            ? MediaQuery.of(context).size.width
                            : 600,
                        decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(4)),
                        child: const Center(
                          child: Text(
                            'PROCEED TO CHECKOUT',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontFamily: 'MontserratBlack'),
                          ),
                        )),
                  ),
                ],
              ),
            ),
          ),
        );
      });
    });
  }

  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: BlocProvider<OrderBloc>(
        create: (context) => OrderBloc()..add(TestEvent()),
        child: BlocListener<OrderBloc, OrderState>(
          listener: (context, state) {
            if (state is MyCartItems) {
              int total = 0;
              for (var item in state.orderModel) {
                total += ((item.product_price != null)
                        ? (int.parse(item.product_price!))
                        : 1) *
                    (item.product_quantity ?? 1);
              }
              showAddtoCartBottomSheet(context, totalPrice: total);
              print("TestState");
            }
          },
          child: BlocBuilder<OrderBloc, OrderState>(
            builder: (context, state) {
              if (state is MyCartItems) {
                return Scaffold(
                  key: _scaffoldKey,
                  backgroundColor: Colors.white,
                  appBar: AppBar(
                      automaticallyImplyLeading: false,
                      elevation: 0,
                      backgroundColor: Colors.white,
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'My cart',
                            style: TextStyle(
                                fontFamily: 'Montserratlsemibold',
                                color: Colors.black),
                          ),
                          InkWell(
                            onTap: () {
                              // BlocProvider<OrderBloc>(
                              //     create: (context) =>
                              //         OrderBloc()..add(DeleteCartEvent()));
                              
                              BlocProvider.of<OrderBloc>(context)
                                ..add(DeleteCartEvent());
                            },
                            child: (state is LoadingSubmitState) ? const Center(child: CircularProgressIndicator()) : Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 8),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6),
                                  color: Colors.redAccent),
                              child: const Text(
                                'Clear',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 12),
                              ),
                            ),
                          )
                        ],
                      )),
                  body: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: SafeArea(
                      child: ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          padding: EdgeInsets.only(bottom: 200),
                          shrinkWrap: true,
                          itemCount: state.orderModel.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: const EdgeInsets.fromLTRB(10, 0, 10, 20),
                              child: Container(
                                height: 100,
                                color: const Color(0xfff0f5f9),
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5, vertical: 10),
                                      child: Container(
                                        width: 120,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: NetworkImage(
                                                ApiUrl.baseUrl +
                                                    '/' +
                                                    state.orderModel[index]
                                                        .product_image!,
                                              ),
                                              fit: BoxFit.cover),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              state.orderModel[index]
                                                      .product_name ??
                                                  "...",
                                              style: const TextStyle(
                                                  fontFamily:
                                                      'Montserratlsemibold',
                                                  fontSize: 14),
                                            ),
                                            Row(
                                              // crossAxisAlignment: CrossAxisAlignment.end,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                RichText(
                                                  text: TextSpan(
                                                      text: 'Rs ',
                                                      style: const TextStyle(
                                                          color: Colors.black),
                                                      children: [
                                                        TextSpan(
                                                          text: state
                                                                  .orderModel[
                                                                      index]
                                                                  .product_price ??
                                                              "...",
                                                          style: const TextStyle(
                                                              fontFamily:
                                                                  'Montserratlsemibold',
                                                              fontSize: 23),
                                                        )
                                                      ]),
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                        child: Text("Q: ")),
                                                    const SizedBox(
                                                      width: 5,
                                                    ),
                                                    Text(
                                                      state.orderModel[index]
                                                          .product_quantity
                                                          .toString(),
                                                    ),
                                                    const SizedBox(
                                                      width: 5,
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }),
                    ),
                  ),
                );
              } else {
                return const Center(child: Text(("No Product in Cart")));
              }
            },
          ),
        ),
      ),
    );
  }
}
