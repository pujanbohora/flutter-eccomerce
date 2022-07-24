import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:the_gadget_zone/blocs/address_bloc/address_bloc.dart';
import 'package:the_gadget_zone/model/address_model.dart';
import 'package:the_gadget_zone/screen/AddToCart/checkoutcompletion.dart';

class Checkout extends StatefulWidget {
  const Checkout({Key? key}) : super(key: key);

  @override
  _CheckoutState createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  GlobalKey<FormState> _form = GlobalKey<FormState>();

  bool loading = false;

  TextEditingController nameController = TextEditingController();
  TextEditingController mobileNumberontroller = TextEditingController();
  TextEditingController localityontroller = TextEditingController();
  TextEditingController addressontroller = TextEditingController();
  TextEditingController cityDistrictTownontroller = TextEditingController();
  TextEditingController landmarkontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider<AddressBloc>(
      create: (context) => AddressBloc(),
      child: BlocConsumer<AddressBloc, AddressState>(
        listener: (context, state) {
          if (state is AcceptAddressId) {
            print('you are in state to check error');
            loading = false;
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => CheckoutCompletion(state.address)),
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
              title: const Text('Checkout',
                  style: TextStyle(
                      fontFamily: 'Montserratlsemibold', color: Colors.black)),
            ),
            body: SingleChildScrollView(
              child: Center(
                child: Container(
                  constraints: const BoxConstraints(maxWidth: 600),
                  child: Form(
                    key: _form,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Delivery Address',
                            style: TextStyle(
                                fontFamily: 'MontserratBlack', fontSize: 15),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const Text(
                            'Full Name*',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey)),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 5),
                              child: TextFormField(
                                validator:
                                    RequiredValidator(errorText: '* required'),
                                controller: nameController,
                                style: TextStyle(fontSize: 14),
                                decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    isDense: true,
                                    // labelStyle: TextStyle(fontSize: 3),
                                    fillColor: Colors.grey),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          const Text(
                            'Phone*',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey)),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 5),
                              child: TextFormField(
                                validator:
                                    RequiredValidator(errorText: '* required'),
                                controller: mobileNumberontroller,
                                style: const TextStyle(fontSize: 14),
                                decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    isDense: true,
                                    fillColor: Colors.grey),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          const Text(
                            'City*',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey)),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 5),
                              child: TextFormField(
                                validator:
                                    RequiredValidator(errorText: '* required'),
                                controller: cityDistrictTownontroller,
                                style: const TextStyle(fontSize: 14),
                                decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    isDense: true,
                                    fillColor: Colors.grey),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          const Text(
                            'Address*',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey)),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 5),
                              child: TextFormField(
                                validator:
                                    RequiredValidator(errorText: '* required'),
                                controller: addressontroller,
                                style: const TextStyle(fontSize: 14),
                                decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    isDense: true,
                                    fillColor: Colors.grey),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          const Text(
                            'Street Name*',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey)),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 5),
                              child: TextFormField(
                                validator:
                                    RequiredValidator(errorText: '* required'),
                                controller: localityontroller,
                                style: const TextStyle(fontSize: 14),
                                decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    isDense: true,
                                    fillColor: Colors.grey),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          const Text(
                            'Landmark',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey)),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 5),
                              child: TextFormField(
                                validator:
                                    RequiredValidator(errorText: '* required'),
                                controller: landmarkontroller,
                                style: const TextStyle(fontSize: 14),
                                decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    isDense: true,
                                    fillColor: Colors.grey),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          const Text(
                            'Payment Methods',
                            style: TextStyle(
                              fontSize: 14,
                              // color: Colors.grey,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'MontserratBlack',
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(8)),
                            child: Row(
                              children: const [
                                Radio(
                                    value: null, groupValue: null, onChanged: null),
                                Text(
                                  'Cash on Delivery',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontFamily: 'Montserratlsemibold'),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          InkWell(
                            onTap: () {
                              if (_form.currentState!.validate()) {
                                loading = true;
                                print("you are in address even check");
                                BlocProvider.of<AddressBloc>(context).add(
                                    UserAddressEvent(
                                        model: AddressModel(
                                            name: nameController.text,
                                            mobileNumber:
                                                mobileNumberontroller.text,
                                            locality: localityontroller.text,
                                            address: addressontroller.text,
                                            cityDistrictTown:
                                                cityDistrictTownontroller.text,
                                            landmark: landmarkontroller.text)));
                              }
                            },
                            child: Center(
                              child: Container(
                                  height: 40,
                                  width: MediaQuery.of(context).size.width  ,
                                  decoration: BoxDecoration(
                                      color: Colors.black,
                                      borderRadius: BorderRadius.circular(4)),
                                  child: Center(
                                    child: (state is LoadingSubmitState)
                                        ? const CircularProgressIndicator( color: Colors.white,)
                                        : const Text(
                                            'CONTINUE',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 12,
                                                fontFamily: 'MontserratBlack'),
                                          ),
                                  )),
                            ),
                          ),
                        ],
                      ),
                    ),
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
