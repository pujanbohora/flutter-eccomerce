import 'package:flutter/material.dart';

class DeliveryDetails extends StatefulWidget {
  const DeliveryDetails({Key? key}) : super(key: key);

  @override
  State<DeliveryDetails> createState() => _DeliveryDetailsState();
}

class _DeliveryDetailsState extends State<DeliveryDetails> {
  List<String> product = ["Bluethooth Headphone"];
  List<String> customerdetails = [
    "sujan pradhan",
    "9817034302",
    "Gausala, kathmandu"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        title: const Text(
          'Order Details',
          style:
              TextStyle(color: Colors.black, fontFamily: 'Montserratlsemibold'),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(5)),
                  child: Column(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Product',
                                style: TextStyle(
                                    fontSize: 17,
                                    fontFamily: 'Montserratlsemibold'),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Column(
                                  children: product
                                      .map(
                                        (e) => Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 3),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(e),
                                              RichText(
                                                text: const TextSpan(
                                                    text: 'Rs. ',
                                                    style: TextStyle(
                                                        color: Colors.black),
                                                    children: [
                                                      TextSpan(
                                                          text: '1600',
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .black)),
                                                    ]),
                                              ),
                                            ],
                                          ),
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
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(5)),
                  child: Column(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Shipping Address',
                                style: TextStyle(
                                    fontSize: 17,
                                    fontFamily: 'Montserratlsemibold'),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Column(
                                  // mainAxisAlignment: MainAxisAlignment.start,
                                  children: customerdetails
                                      .map(
                                        (e) => Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 3),
                                          child: Row(
                                            children: [Text(e)],
                                          ),
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}
