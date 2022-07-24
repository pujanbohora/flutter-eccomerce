
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_gadget_zone/admin/admin_modules/widgets/drawer.dart';
import 'package:the_gadget_zone/api_helper/api_url.dart';
import 'package:the_gadget_zone/constants/custom_colors.dart';
import '../../../../blocs/ordercompleted/ordercompleted_bloc.dart';

class Completed extends StatefulWidget {
  const Completed({Key? key}) : super(key: key);

  @override
  _CompletedState createState() => _CompletedState();
}

class _CompletedState extends State<Completed> {
  void showDrawer() {
    print('tapped on show drawer!');
    setState(() {
      _showDrawer = !_showDrawer;
    });
  }

  bool _showDrawer = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          backgroundColor: Colors.white,
          floatingActionButton: FloatingActionButton(
            onPressed: showDrawer,
            backgroundColor: Colors.black,
            child: const Icon(
              Icons.menu_rounded,
            ),
          ),
          appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              title: const Text('Completed',
                  style: TextStyle(
                      fontSize: 25,
                      fontFamily: 'Montserramedium',
                      color: Colors.black))),
          body: const RecentOrderWidget(),
        ),
        if (_showDrawer)
          DrawerWidget(
            closeFunction: showDrawer,
          ),
      ],
    );
  }
}

class RecentOrderWidget extends StatelessWidget {
  const RecentOrderWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: BlocProvider<OrdercompletedBloc>(
        create: (context) => OrdercompletedBloc()
          ..add(AdminOrderStatusEvent(status: 'delivered')),
        child: BlocBuilder<OrdercompletedBloc, OrdercompletedState>(
          builder: (context, state) {
            if (state is AdminOrderStatusState) {
              return SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: state.orderinfodetails.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.fromLTRB(10, 0, 10, 20),
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6),
                                  border: Border.all(
                                      color: CustomColors.whiteShade)),
                              child: Column(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: CustomColors.whiteShade)),
                                    padding: EdgeInsets.all(10),
                                    child: Column(
                                      children: [
                                        Container(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const CircleAvatar(
                                                backgroundImage: NetworkImage(
                                                    'https://i.pinimg.com/564x/d9/7b/bb/d97bbb08017ac2309307f0822e63d082.jpg'),
                                                radius: 30,
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    state
                                                            .orderinfodetails[
                                                                index]
                                                            .admin_email ??
                                                        "Empty",
                                                    style: const TextStyle(
                                                        fontFamily:
                                                            'Montserramedium',
                                                        color: Color.fromARGB(
                                                            255, 85, 74, 74),
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 16),
                                                  ),
                                                  Text(
                                                      state
                                                              .orderinfodetails[
                                                                  index]
                                                              .admin_number ??
                                                          "Empty",
                                                      style: const TextStyle(
                                                        fontFamily:
                                                            'Montserramedium',
                                                        color: Colors.grey,
                                                      )),
                                                  Text(
                                                    (state
                                                                .orderinfodetails[
                                                                    index]
                                                                .admin_address ??
                                                            "empty") +
                                                        ', ' +
                                                        (state
                                                                .orderinfodetails[
                                                                    index]
                                                                .admin_locality ??
                                                            'empty'),
                                                    style: const TextStyle(
                                                        fontFamily:
                                                            'Montserramedium',
                                                        color: Colors.grey),
                                                  )
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    // color: CustomColors.whiteShade,
                                    child: Padding(
                                      padding: const EdgeInsets.all(15),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Container(
                                                height: 50,
                                                width: 50,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                    image: DecorationImage(
                                                      fit: BoxFit.cover,
                                                      image: NetworkImage(ApiUrl
                                                              .baseUrl +
                                                          '/' +
                                                          state
                                                              .orderinfodetails[
                                                                  index]
                                                              .admin_image!),
                                                    )),
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Flexible(
                                                child: Text(
                                                  state.orderinfodetails[index]
                                                          .admin_name ??
                                                      'email',
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 14,
                                                      color: Color.fromARGB(
                                                          255, 85, 74, 74)),
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 5,
                                              ),
                                              Text("x " +
                                                  state.orderinfodetails[index]
                                                      .admin_quantity
                                                      .toString()),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          'Total Price',
                                          style: TextStyle(
                                              color: CustomColors.greyShade),
                                        ),
                                        RichText(
                                          text: TextSpan(
                                              text: 'Rs. ',
                                              style: const TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 85, 74, 74)),
                                              children: [
                                                TextSpan(
                                                    text: (state
                                                                .orderinfodetails[
                                                                    index]
                                                                .admin_price! *
                                                            state
                                                                .orderinfodetails[
                                                                    index]
                                                                .admin_quantity!)
                                                        .toString(),
                                                    style: const TextStyle(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                              ]),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 30,
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                  ],
                ),
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
