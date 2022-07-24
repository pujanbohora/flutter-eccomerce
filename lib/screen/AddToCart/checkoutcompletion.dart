import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:the_gadget_zone/blocs/address_bloc/address_bloc.dart';
import 'package:the_gadget_zone/http/address_repo.dart';
import 'package:the_gadget_zone/main.dart';
import 'package:the_gadget_zone/screen/Delivery/deliverydetails.dart';

class CheckoutCompletion extends StatefulWidget {
  String address;
  CheckoutCompletion(this.address);

  @override
  State<CheckoutCompletion> createState() => _CheckoutCompletionState();
}

class _CheckoutCompletionState extends State<CheckoutCompletion> {
  List<String> product = ["Wireless Headphone RB-650"];

  bool loading = false;

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  onSelectNotification(String? payload) {
    return Navigator.of(context).push(MaterialPageRoute(builder: (_) {
      return DeliveryDetails(
          // payload: payload,
          );
    }));
  }

  showNotification() async {
    var android = AndroidNotificationDetails('id', 'channel ',
        channelDescription: "oleoleole",
        priority: Priority.high,
        importance: Importance.max);
    var platform = new NotificationDetails(android: android);
    await flutterLocalNotificationsPlugin.show(
        0, 'Order Confirmation', 'Order has been received', platform,
        payload: 'Welcome to the Local Notification demo');
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var initializationSettingsAndroid = AndroidInitializationSettings('offer1');

    var initSetttings =
        InitializationSettings(android: initializationSettingsAndroid);

    flutterLocalNotificationsPlugin.initialize(initSetttings,
        onSelectNotification: onSelectNotification);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AddressBloc>(
      create: (context) => AddressBloc(),
      child: BlocConsumer<AddressBloc, AddressState>(
        listener: (context, state) {
          if (state is CompleteOrder) {
            loading = true;
            showNotification();
            // ScaffoldMessenger.of(context)
            //     .showSnackBar(SnackBar(content: Text(state.message)));
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const MainScreen()),
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              elevation: 0,
              iconTheme: const IconThemeData(color: Colors.black),
              backgroundColor: Colors.white,
              title: const Text(
                'Completion',
                style: TextStyle(
                    color: Colors.black, fontFamily: 'Montserratlsemibold'),
              ),
            ),
            body: Center(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Container(
                  constraints: BoxConstraints(maxWidth: 600),
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(5)),
                        child: Column(
                          // mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  EvaIcons.doneAllOutline,
                                  size: 50,
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const [
                                    Text(
                                      'THANK YOU!',
                                      style: TextStyle(
                                          fontFamily: 'MontserratBlack',
                                          fontSize: 14),
                                    ),
                                    Text(
                                      'Your order has been received',
                                      style: TextStyle(
                                          fontFamily: 'Montserramedium',
                                          fontSize: 14),
                                    )
                                  ],
                                ),
                              ],
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              decoration: const BoxDecoration(
                                  border: Border(
                                      top: BorderSide(color: Colors.grey))),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text('Products'),
                                    Column(
                                        children: product
                                            .map(
                                              (e) => Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(e),
                                                  RichText(
                                                    text: const TextSpan(
                                                        text: 'Rs.',
                                                        style: TextStyle(
                                                            color:
                                                                Colors.black),
                                                        children: [
                                                          TextSpan(
                                                              text: '4990',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black)),
                                                        ]),
                                                  ),
                                                ],
                                              ),
                                            )
                                            .toList()),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      InkWell(
                        onTap: () {
                          loading = false;
                          BlocProvider.of<AddressBloc>(context).add(
                              CompleteOrderEvent(addressId: widget.address));
                        },
                        child: Container(
                            height: 40,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(4)),
                            child: Center(
                              child: (state is LoadingSubmitState)
                                  ? const Center(
                                      child: CircularProgressIndicator(
                                      color: Colors.white,
                                    ))
                                  : const Text(
                                      'CHECKOUT NOW',
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
            ),
          );
        },
      ),
    );
  }
}
