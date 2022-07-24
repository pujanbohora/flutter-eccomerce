import 'dart:io';

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cross_file/cross_file.dart';
import 'package:the_gadget_zone/blocs/profile_bloc/profile_bloc.dart';
import 'package:the_gadget_zone/screen/auth/login.dart';

class AdminProfile extends StatefulWidget {
  const AdminProfile({Key? key}) : super(key: key);

  @override
  _AdminProfileState createState() => _AdminProfileState();
}

class _AdminProfileState extends State<AdminProfile> {
  /// Get from gallery
  File? profile;
  pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        profile = File(image.path);
      });
    }
  }

  TextEditingController fullname = TextEditingController();
  TextEditingController phone = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileBloc()..add(ProfileShow()),
      child: BlocConsumer<ProfileBloc, ProfileState>(
        listener: (context, state) {
          if (state is ProfileViewFailed) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              iconTheme: const IconThemeData(color: Colors.black),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Profile',
                    style: TextStyle(
                        fontFamily: 'Montserralsemibold', color: Colors.black),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Login()));
                    },
                    child: Container(   
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.black),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: const [
                            Icon(
                              EvaIcons.logOut,
                              color: Colors.white,
                              size: 14,
                            ),
                            Text(
                              '  Log out',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            body: SingleChildScrollView(
              child: Center(
                child: Container(
                  constraints: BoxConstraints(maxWidth: 600),
                  child: Column(children: [
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Container(
                        height: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: const Color(0xfff0f5f9),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(10, 10, 10, 10),
                              child: InkWell(
                                onTap: () {
                                  pickImage();
                                },
                                child: Stack(
                                  children: [
                                    CircleAvatar(
                                      radius: 35,
                                      backgroundImage: (profile != null)
                                          ? FileImage(profile!) as ImageProvider
                                          : const NetworkImage(
                                              'https://i.pinimg.com/564x/e1/49/2f/e1492ff2dcc2e4f435759285dbe59bc7.jpg'),
                                    ),
                                    Positioned(
                                      bottom: 0,
                                      right: 0,
                                      child: Container(
                                          padding: const EdgeInsets.all(3),
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.white,
                                                  width: 2),
                                              borderRadius:
                                                  BorderRadius.circular(25),
                                              color: Colors.blue),
                                          child: const Icon(
                                            Icons.add_a_photo,
                                            color: Colors.white,
                                            size: 15,
                                          )),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    (state is ProfileViewSuccess)
                                        ? state.profileSave.fullname!
                                        : "Bohorapawan@gmail.com",
                                    style: const TextStyle(
                                        fontFamily: "Montserratlsemibold")),
                                Text(
                                    (state is ProfileViewSuccess)
                                        ? state.profileSave.email!
                                        : "9849161751",
                                    style: const TextStyle(
                                        fontFamily: "Montserratlsemibold")),
                                // Text(
                                //     (state is ProfileViewSuccess)
                                //         ? state.profileSave.contactNumber!
                                //         : "XXXXXXXXX",
                                //     style: const TextStyle(
                                //         fontFamily: "Montserratlsemibold")),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Form(
                          child: Column(
                        children: [
                          TextField(
                            controller: fullname,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Enter your name'),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextField(
                            controller: phone,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Phone Number'),
                          ),
                          // const SizedBox(
                          //   height: 20,
                          // ),
                          // const TextField(
                          //   decoration: InputDecoration(
                          //       border: OutlineInputBorder(),
                          //       labelText: 'Shipping Address'),
                          // ),
                          const SizedBox(
                            height: 20,
                          ),
                          const TextField(
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Old Password'),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const TextField(
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'New Password'),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Builder(builder: (context) {
                            return BlocConsumer<ProfileBloc, ProfileState>(
                              listener: (context, state) {
                                if (state is ProfileUpdateSucess) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text(state.message)));
                                } else if (state is ProfileUpdateFailed) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text(state.message)));
                                }
                              },
                              builder: (context, state) => InkWell(
                                onTap: () {
                                  BlocProvider.of<ProfileBloc>(context).add(
                                      ProfileUpdateEvent(
                                          fullname: fullname.text,
                                          phone: phone.text));
                                },
                                child: Container(
                                    height: 40,
                                    width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(
                                        color: Colors.black,
                                        borderRadius: BorderRadius.circular(4)),
                                    child: Center(
                                      child: (state is LoadingState)
                                          ? CircularProgressIndicator()
                                          : Text(
                                              'Update Profile',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 12,
                                                  fontFamily:
                                                      'MontserratBlack'),
                                            ),
                                    )),
                              ),
                            );
                          }),
                        ],
                      )),
                    )
                  ]),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
