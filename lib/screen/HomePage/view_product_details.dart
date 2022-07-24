import 'package:carousel_slider/carousel_slider.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_gadget_zone/api_helper/api_url.dart';
import 'package:the_gadget_zone/blocs/order_bloc/order_bloc.dart';
import 'package:the_gadget_zone/blocs/review_bloc/review_bloc.dart';
import 'package:the_gadget_zone/model/order_model.dart';
import 'package:the_gadget_zone/model/product_model.dart';
import 'package:the_gadget_zone/screen/Model/productmodel.dart';

class ProductDetails extends StatefulWidget {
  final ItemModel itemModel;
  final ProductModel ProductList;

  ProductDetails({required this.itemModel, required this.ProductList});

  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  bool isSeeMore = false;

  final CarouselController _carouselController = CarouselController();
  final ScrollController _scrollController = ScrollController();

  TextEditingController review = TextEditingController();

  bool isFLoatingButtonNeeded = false;

  int quantity = 1;
  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();

    _scrollController.addListener(() {
      setState(() {
        double offset = _scrollController.offset;
        if (offset < 150) {
          isFLoatingButtonNeeded = false;
        } else {
          isFLoatingButtonNeeded = true;
        }
      });
    });
  }

  @override
  void dispose() {
    // ignore: todo
    // TODO: implement dispose
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<ReviewBloc>(
            create: (context) => ReviewBloc(),
          ),
          BlocProvider(
              create: (context) => ReviewBloc()
                ..add(ReviewViewEvent(productId: widget.ProductList.id!))),
        ],
        child: MultiBlocListener(
          listeners: [
            BlocListener<ReviewBloc, ReviewState>(
              listener: (context, state) {
                if (state is AddReviewSuccess) {
                  print('review now');
                  setState(() {
                    review.text = "";
                  });

                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text(state.message!)));
                }
              },
            ),
            BlocListener<ReviewBloc, ReviewState>(
                listener: ((context, stateReview) {
              if (stateReview is ViewReviewState) {
                print('inside blochahkdjdkfjsdkjf');
              }
            }))
          ],
          child: BlocBuilder<ReviewBloc, ReviewState>(
            builder: (context, state) {
              return Scaffold(
                floatingActionButton: SizedBox(
                  height: 190,
                  width: 50,
                  child: (isFLoatingButtonNeeded == false)
                      ? Container()
                      : FloatingActionButton(
                          onPressed: () {
                            _scrollController.animateTo(0,
                                duration: const Duration(seconds: 1),
                                curve: Curves.ease);
                          },
                          child: const Icon(EvaIcons.arrowUpwardOutline),
                        ),
                ),
                backgroundColor: Colors.white,
                body: SafeArea(
                  child: Stack(
                    children: [
                      SingleChildScrollView(
                        physics: BouncingScrollPhysics(),
                        controller: _scrollController,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Stack(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Container(
                                    alignment: Alignment.topLeft,
                                    height: 340,
                                    width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: NetworkImage(ApiUrl.baseUrl +
                                                '/' +
                                                widget.ProductList
                                                    .product_image!),
                                            fit: BoxFit.contain)),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Padding(
                                    padding: EdgeInsets.fromLTRB(18, 10, 0, 0),
                                    child: Icon(
                                      EvaIcons.arrowIosBackOutline,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 18),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Flexible(
                                    child: Text(
                                      widget.ProductList.product_title!,
                                      style: const TextStyle(
                                          fontFamily: 'Montserramedium',
                                          fontSize: 16),
                                    ),
                                  ),
                                  Text(
                                    "Rs." + widget.ProductList.product_price!,
                                    style: const TextStyle(
                                        fontFamily: 'MontserratBold',
                                        fontSize: 18),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 18, vertical: 10),
                              child: InkWell(
                                highlightColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                splashColor: Colors.transparent,
                                onTap: () {
                                  setState(() {
                                    isSeeMore = true;
                                  });
                                },
                                child: RichText(
                                  textAlign: TextAlign.justify,
                                  overflow: (isSeeMore == false)
                                      ? TextOverflow.ellipsis
                                      : TextOverflow.visible,
                                  maxLines: (isSeeMore == false) ? 3 : null,
                                  text: TextSpan(
                                    style: TextStyle(color: Colors.grey[600]),
                                    children: [
                                      TextSpan(
                                        text: widget
                                            .ProductList.product_description!,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 18),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: TextField(
                                      controller: review,
                                      decoration: InputDecoration(
                                          hintText: "Write a review",
                                          isDense: true),
                                    ),
                                  ),
                                  IconButton(
                                      onPressed: () {
                                        BlocProvider.of<ReviewBloc>(context)
                                            .add(ReviewPostEvent(
                                                review: review.text,
                                                pid: widget.ProductList.id!));
                                      },
                                      icon: const Icon(
                                          EvaIcons.paperPlaneOutline))
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 18),
                              child: Text(
                                'Review',
                                style: TextStyle(
                                    fontFamily: 'MontserratBold', fontSize: 14),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            BlocBuilder<ReviewBloc, ReviewState>(
                              builder: (context, reviewState) {
                                if (reviewState is ViewReviewState) {
                                  return ListView.builder(
                                    padding: EdgeInsets.only(bottom: 80),
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: reviewState.reviews!.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10, horizontal: 18),
                                        child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            child: Container(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 12,
                                                        vertical: 10),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            const CircleAvatar(
                                                              backgroundImage:
                                                                  NetworkImage(
                                                                      'https://www.woolha.com/media/2020/03/eevee.png'),
                                                              radius: 21,
                                                            ),
                                                            Padding(
                                                              padding: const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      5),
                                                              child: Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                    reviewState
                                                                        .reviews![
                                                                            index]
                                                                        .email!,
                                                                    // widget.productModel.review[index].username,
                                                                    style: TextStyle(
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold,
                                                                        fontSize:
                                                                            15),
                                                                  ),
                                                                  const Text(
                                                                    'Nov 9, 2021',
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            10,
                                                                        fontWeight:
                                                                            FontWeight.bold),
                                                                  ),
                                                                ],
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                        // Row(
                                                        //   mainAxisAlignment:
                                                        //       MainAxisAlignment
                                                        //           .start,
                                                        //   children: [
                                                        //     // InkWell(
                                                        //     //   onTap: () {},
                                                        //     //   child: Container(
                                                        //     //     height: 28,
                                                        //     //     width: 28,
                                                        //     //     child:
                                                        //     //         const Icon(
                                                        //     //       EvaIcons
                                                        //     //           .edit2Outline,
                                                        //     //       color: Colors
                                                        //     //           .white,
                                                        //     //       size: 14,
                                                        //     //     ),
                                                        //     //     decoration:
                                                        //     //         BoxDecoration(
                                                        //     //       color: Colors
                                                        //     //           .black,
                                                        //     //       borderRadius:
                                                        //     //           BorderRadius
                                                        //     //               .circular(
                                                        //     //                   5),
                                                        //     //       border: Border.all(
                                                        //     //           color: Colors
                                                        //     //               .white),
                                                        //     //     ),
                                                        //     //   ),
                                                        //     // ),
                                                        //     const SizedBox(
                                                        //         width: 7),
                                                        //     InkWell(
                                                        //       onTap: () {},
                                                        //       child: Container(
                                                        //         height: 28,
                                                        //         width: 28,
                                                        //         child:
                                                        //             const Icon(
                                                        //           EvaIcons
                                                        //               .trash2Outline,
                                                        //           color: Colors
                                                        //               .white,
                                                        //           size: 16,
                                                        //         ),
                                                        //         decoration:
                                                        //             BoxDecoration(
                                                        //           color: Colors
                                                        //               .red,
                                                        //           borderRadius:
                                                        //               BorderRadius
                                                        //                   .circular(
                                                        //                       5),
                                                        //           border: Border.all(
                                                        //               color: Colors
                                                        //                   .white),
                                                        //         ),
                                                        //       ),
                                                        //     ),
                                                        //   ],
                                                        // ),
                                                      
                                                      ],
                                                    ),
                                                    const SizedBox(height: 12),
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 50),
                                                      child: Text(
                                                        reviewState
                                                            .reviews![index]
                                                            .review!,
                                                        style: TextStyle(
                                                            fontSize: 13),
                                                      ),
                                                    ),
                                                    const SizedBox(height: 12),
                                                  ],
                                                ),
                                              ),
                                              decoration: const BoxDecoration(
                                                  border: Border(),
                                                  color: Color(0xfff0f5f9)),
                                            )),
                                      );
                                    },
                                  );
                                } else {
                                  return Center(child: Text('No Review'));
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                      BlocProvider<OrderBloc>(
                        create: (context) => OrderBloc(),
                        child: BlocConsumer<OrderBloc, OrderState>(
                          listener: (context, state) {
                            if (state is OrderPlacedState) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(state.message)));
                            }
                          },
                          builder: (context, state) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 18, vertical: 10),
                              child: Center(
                                child: Container(
                                  constraints: BoxConstraints(maxWidth: 350),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Container(
                                        height: 60,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        decoration: BoxDecoration(
                                            color: Colors.black,
                                            borderRadius:
                                                BorderRadius.circular(7)),
                                        child: Row(
                                          children: [
                                            const SizedBox(
                                              width: 20,
                                            ),
                                            Container(
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(3)),
                                              height: 30,
                                              width: 28,
                                              child: GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    if (quantity > 1) {
                                                      quantity = quantity - 1;
                                                    }
                                                  });
                                                },
                                                child: const Icon(
                                                  EvaIcons.minus,
                                                  color: Colors.black,
                                                  size: 20,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 10),
                                              child: Text(
                                                quantity.toString(),
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 19),
                                              ),
                                            ),
                                            Container(
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(3)),
                                              height: 30,
                                              width: 28,
                                              child: GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    quantity = quantity + 1;
                                                  });
                                                },
                                                child: const Icon(
                                                  EvaIcons.plus,
                                                  color: Colors.black,
                                                  size: 20,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 20),
                                              child: Container(
                                                  height: 30,
                                                  width: 1,
                                                  color: Colors.white),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 10),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  const Text('Total Price',
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 10,
                                                          fontFamily:
                                                              'Montserratlsemibold')),
                                                  RichText(
                                                    text: TextSpan(
                                                        text: 'Rs ',
                                                        style: TextStyle(
                                                            fontSize: 13,
                                                            fontFamily:
                                                                'MontserratBlack'),
                                                        children: [
                                                          TextSpan(
                                                            text: ((int.parse(widget
                                                                            .ProductList
                                                                            .product_price ??
                                                                        '0')) *
                                                                    quantity)
                                                                .toString(),
                                                            style: const TextStyle(
                                                                fontSize: 16,
                                                                fontFamily:
                                                                    'Montserratlsemibold'),
                                                          )
                                                        ]),
                                                  )
                                                ],
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 7,
                                            ),
                                            InkWell(
                                              onTap: () {
                                                BlocProvider.of<
                                                        OrderBloc>(context)
                                                    .add(AddProductToCart(Order(
                                                        id:
                                                            widget.ProductList
                                                                .id!,
                                                        product_price:
                                                            ((int.parse(widget
                                                                        .ProductList
                                                                        .product_price!)) *
                                                                    quantity)
                                                                .toString(),
                                                        product_quantity:
                                                            quantity)));
                                              },
                                              child: Container(
                                                height: 30,
                                                width: 95,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  color: Colors.white,
                                                ),
                                                child: (state
                                                        is LoadingSubmitState)
                                                    ? Center(
                                                      child: CircularProgressIndicator(
                                                          strokeWidth: 1,
                                                          color: Colors.black),
                                                    )
                                                    : const Center(
                                                        child: Text(
                                                            'Add to Cart',
                                                            style: TextStyle(
                                                                fontSize: 11,
                                                                fontFamily:
                                                                    'Montserratlsemibold')),
                                                      ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        ));
  }
}
