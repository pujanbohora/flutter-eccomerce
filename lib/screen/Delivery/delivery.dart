import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_gadget_zone/blocs/ordercompleted/ordercompleted_bloc.dart';
import 'package:the_gadget_zone/screen/Delivery/deliverydetails.dart';

class Delivery extends StatefulWidget {
  const Delivery({Key? key}) : super(key: key);

  @override
  _DeliveryState createState() => _DeliveryState();
}

class _DeliveryState extends State<Delivery> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<OrdercompletedBloc>(
      create: (context) => OrdercompletedBloc()..add(MyOrderCompleteEvent()),
      child: BlocConsumer<OrdercompletedBloc, OrdercompletedState>(
        listener: (context, state) {
          if (state is MyOrderCompleteState) {
            print('order details state');
          }
        },
        builder: (context, state) {
          if (state is MyOrderCompleteState) {
            return Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                backgroundColor: Colors.white,
                automaticallyImplyLeading: false,
                elevation: 0,
                title: const Text(
                  'My Orders',
                  style: TextStyle(
                      fontFamily: 'Montserratlsemibold', color: Colors.black),
                ),
              ),
              body: SingleChildScrollView(
                child: ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: state.orderinfodetails.length,
                    itemBuilder: (BuildContext context, int index) {
                      print(state.orderinfodetails[index].address);
                      return Padding(
                        padding: const EdgeInsets.fromLTRB(10, 0, 10, 20),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (contex) => const DeliveryDetails()),
                            );
                          },
                          child: Container(
                            color: const Color(0xfff0f5f9),
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                       Flexible(
                                        child: Text(
                                          state.orderinfodetails[index].productsName!.join("\n"),
                                          
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18),
                                        ),
                                      ),
                                      // const SizedBox(height: 10,),
                                      Container(
                                        height: 25,
                                        width: 90,
                                        decoration: BoxDecoration(
                                            color: Colors.green[100],
                                            borderRadius:
                                                BorderRadius.circular(2)),
                                        child: Center(
                                            child: Text(
                                          state.orderinfodetails[index]
                                              .orderStatus!
                                              .toUpperCase(),
                                          style: const TextStyle(
                                              fontSize: 10,
                                              fontFamily: 'Montserramedium',
                                              fontWeight: FontWeight.bold),
                                        )),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          RichText(
                                            text: TextSpan(
                                              text: state
                                                  .orderinfodetails[index]
                                                  .date!,
                                              style: TextStyle(
                                                  color: Colors.brown),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Row(
                                            children: [
                                              Icon(
                                                EvaIcons.pin,
                                                color: Colors.brown,
                                                size: 19,
                                              ),
                                              Text(
                                                  state.orderinfodetails[index]
                                                      .address!,
                                                  style: TextStyle(
                                                      color: Colors.brown))
                                            ],
                                          ),
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text('Grand Total',
                                              style: TextStyle(
                                                  color: Colors.brown)),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          RichText(
                                            text: TextSpan(
                                                text: 'Rs. ',
                                                style: TextStyle(
                                                    color: Colors.black),
                                                children: [
                                                  TextSpan(
                                                      text: state.orderinfodetails[index].totalAmount,
                                                      style: const TextStyle(
                                                          fontSize: 20,
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                ]),
                                          ),
                                        ],
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
              ),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
