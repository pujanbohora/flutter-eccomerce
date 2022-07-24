import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_gadget_zone/auth_model/auth_user_model.dart';
import 'package:the_gadget_zone/blocs/register_bloc/register_bloc.dart';
import 'package:the_gadget_zone/blocs/validation_bloc/validation_bloc.dart';
import 'package:the_gadget_zone/screen/auth/login.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmpasswordController = TextEditingController();

  bool obscureValue = true;
  bool obscureValueConfirm = true;
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => RegisterBloc(),
        ),
        BlocProvider(
          create: (context) => ValidationBloc(),
        ),
      ],
      child: MultiBlocListener(
        listeners: [
          BlocListener<RegisterBloc, RegisterState>(
            listener: (context, state) {
              if (state is RegistrationSuccessState) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text(state.message)));
                // emailController.text = "";
                // passwordController.text = "";
              } else if (state is RegistrationFailedState) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text(state.message)));
              }
            },
          ),
          BlocListener<ValidationBloc, ValidationState>(
            listener: (context, state) {
              if (state is ValidationSuccess) {
                BlocProvider.of<RegisterBloc>(context)
                  ..add(
                    RegisterFormSubmitEvent(model: state.model),
                  );
              } else if (state is ValidationError) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text(state.message)));
              }
            },
          ),
        ],
        child: BlocBuilder<RegisterBloc, RegisterState>(
          builder: (context, state) {
            return Scaffold(
              backgroundColor: Colors.white,
              body: SingleChildScrollView(
                child: SafeArea(
                  child: Center(
                    child: Container(
                      constraints: BoxConstraints(maxWidth: 600),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Container(
                              child: Column(
                                children: [
                                  CircleAvatar(
                                    radius: 40,
                                    backgroundImage:
                                        AssetImage("assets/images/logo.png"),
                                  ),
                                  SizedBox(
                                    height: 40,
                                  ),
                                  Container(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: const [
                                        Text(
                                          'Welcome',
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.black),
                                        ),
                                        Text(
                                          'Sign up',
                                          style: TextStyle(
                                              fontSize: 35,
                                              color: Colors.black,
                                              fontFamily: 'MontserratBold',
                                              fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              height: MediaQuery.of(context).size.height / 1.5,
                              width: double.infinity,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(40),
                                ),
                              ),
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(20, 60, 20, 0),
                                child: Column(
                                  children: [
                                    TextField(
                                      controller: emailController,
                                      cursorColor: Colors.black,
                                      decoration: const InputDecoration(
                                        labelText: "Email",
                                        labelStyle:
                                            TextStyle(color: Colors.black),
                                        // hintText: "Enter your email",
                                        focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.black)),
                                      ),
                                    ),
                                    const SizedBox(height: 30),
                                    TextField(
                                      controller: passwordController,
                                      cursorColor: Colors.black,
                                      obscureText: obscureValue,
                                      decoration: InputDecoration(
                                          labelText: "Password",
                                          labelStyle:
                                              TextStyle(color: Colors.black),
                                          // hintText: "Enter your email",
                                          focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.black)),
                                          suffixIcon: IconButton(
                                              onPressed: () {
                                                setState(() {
                                                  obscureValue = !obscureValue;
                                                });
                                              },
                                              icon: Icon(
                                                obscureValue
                                                    ? EvaIcons.eyeOff
                                                    : EvaIcons.eye,
                                                color: Colors.black,
                                              ))),
                                    ),
                                    const SizedBox(height: 30),
                                    TextField(
                                      controller: confirmpasswordController,
                                      cursorColor: Colors.black,
                                      obscureText: obscureValueConfirm,
                                      decoration: InputDecoration(
                                          labelText: "Confirm Password",
                                          labelStyle:
                                              TextStyle(color: Colors.black),
                                          // hintText: "Enter your email",
                                          focusedBorder:
                                              const UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.black)),
                                          suffixIcon: IconButton(
                                              onPressed: () {
                                                setState(() {
                                                  obscureValueConfirm =
                                                      !obscureValueConfirm;
                                                });
                                              },
                                              icon: Icon(
                                                obscureValueConfirm
                                                    ? EvaIcons.eyeOff
                                                    : EvaIcons.eye,
                                                color: Colors.black,
                                              ))),
                                    ),
                                    const SizedBox(
                                      height: 50,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        BlocProvider.of<ValidationBloc>(context)
                                          ..add(ValidationCheckEvent(
                                              model: AuthUserModel(
                                                  email: emailController.text,
                                                  password:
                                                      passwordController.text,
                                                  confirmPassword:
                                                      confirmpasswordController
                                                          .text)));
                                      },
                                      child: Container(
                                        constraints:
                                            BoxConstraints(maxWidth: 300),
                                        height: 50,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                            color: Color(0xff5a8a82),
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                        child: Center(
                                          child: (state is LoginSubmitLoading)
                                              ? CircularProgressIndicator()
                                              : const Text(
                                                  'Sign up',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 18,
                                                      fontFamily:
                                                          'Montserratlsemibold'),
                                                ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Text(
                                          'Already have an account  ',
                                          style: TextStyle(color: Colors.black),
                                        ),
                                        InkWell(
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder:
                                                      (BuildContext context) =>
                                                          const Login(),
                                                ),
                                              );
                                            },
                                            child: const Text('Sign in?',
                                                style: TextStyle(
                                                    decoration: TextDecoration
                                                        .underline))),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
