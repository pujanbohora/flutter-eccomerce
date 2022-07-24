import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_auth/local_auth.dart';
import 'package:the_gadget_zone/auth_model/auth_user_model.dart';
import 'package:the_gadget_zone/blocs/login_bloc/login_bloc.dart';
import 'package:the_gadget_zone/blocs/validation_bloc/validation_bloc.dart';
import 'package:the_gadget_zone/main.dart';
import 'package:the_gadget_zone/screen/auth/admin_login.dart';
import 'package:the_gadget_zone/screen/auth/signup.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool obscureValue = true;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  //biometrics
  final LocalAuthentication _auth = LocalAuthentication();
  String _message = "Not Authorized";

  Future<bool> checkingForBioMetrics() async {
    bool hasBioMetrics = await _auth.canCheckBiometrics;

    print(hasBioMetrics);
    print('biometrics');

    return hasBioMetrics;
  }

  bool authenticated = false;
  Future<void> _authenticateMe() async {
    print('inside');
    try {
      authenticated = await _auth.authenticate(
        localizedReason: "Authenticate", // message for dialog
        useErrorDialogs: true, // show error in dialog
        stickyAuth: true, // native process
      );

      print(authenticated);
      print('returned true');

      setState(() {
        _message = authenticated ? "Authorized" : "Not Authorized";
      });
    } catch (e) {
      print('inside catch');
    }
    if (!mounted) return;
  }

  //biometrics End

  @override
  void initState() {
    checkingForBioMetrics();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => LoginBloc(),
              ),
              BlocProvider(
                create: (context) => ValidationBloc(),
              ),
            ],
            child: MultiBlocListener(
              listeners: [
                BlocListener<ValidationBloc, ValidationState>(
                  listener: (context, state) {
                    if (state is LoginValidationSuccess) {
                      BlocProvider.of<LoginBloc>(context)
                        ..add(LoginFormSubmitEvent(model: state.model));
                    } else if (state is LoginValidationFailed) {
                      ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(content: Text(state.message)));
                    }
                  },
                ),
                BlocListener<LoginBloc, LoginState>(
                  listener: (context, state) {
                    if (state is LoginSuccessState) {
                      ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(content: Text(state.message)));
                      print('login completed');
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MainScreen()));
                    } else if (state is LoginFailedState) {
                      ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(content: Text(state.message)));
                    }
                  },
                ),
              ],
              child: BlocBuilder<LoginBloc, LoginState>(
                builder: (context, state) {
                  return SingleChildScrollView(
                    child: Center(
                      child: Container(
                        constraints: const BoxConstraints(maxWidth: 600),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              child: Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const [
                                    CircleAvatar(
                                      radius: 40,
                                      backgroundImage:
                                          AssetImage("assets/images/logo.png"),
                                    ),
                                    SizedBox(
                                      height: 40,
                                    ),
                                    Text(
                                      'Welcome',
                                      style: TextStyle(
                                          fontSize: 14, color: Colors.black),
                                    ),
                                    Text(
                                      'Log in',
                                      style: TextStyle(
                                          fontSize: 35,
                                          color: Colors.black,
                                          fontFamily: 'MontserratBold',
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Align(
                              // alignment: Alignment.bottomCenter,
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
                                        key: Key('email'),
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
                                        key: Key('password'),
                                        controller: passwordController,
                                        cursorColor: Colors.black,
                                        obscureText: obscureValue,
                                        decoration: InputDecoration(
                                            labelText: "Password",
                                            labelStyle: const TextStyle(
                                                color: Colors.black),
                                            // hintText: "Enter your email",
                                            focusedBorder:
                                                const UnderlineInputBorder(
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
                                      const SizedBox(
                                        height: 50,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          BlocProvider.of<ValidationBloc>(context)
                                              .add(LoginValidationCheckEvent(
                                                  model: AuthUserModel(
                                                      email: emailController.text
                                                          .trim(),
                                                      password: passwordController
                                                          .text
                                                          .trim())));
                                        },
                                        child: Container(
                                          constraints:
                                              BoxConstraints(maxWidth: 300),
                                          height: 50,
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                              color: const Color(0xff5a8a82),
                                              borderRadius:
                                                  BorderRadius.circular(15)),
                                          child: Center(
                                            child: state is LoadingState
                                                ? CircularProgressIndicator()
                                                : const Text(
                                                    'Sign in',
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
                                            "Don't have an account ",
                                            style: TextStyle(color: Colors.black),
                                          ),
                                          InkWell(
                                              onTap: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder:
                                                        (BuildContext context) =>
                                                            const Signup(),
                                                  ),
                                                );
                                              },
                                              child: const Text('Sign up?',
                                                  style: TextStyle(
                                                      decoration: TextDecoration
                                                          .underline))),
                                        ],
                                      ),
                                      InkWell(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (BuildContext context) =>
                                                    const AdminLogin(),
                                              ),
                                            );
                                          },
                                          child: Text('Login in as Admin')),
                                      SizedBox(
                                        height: 35,
                                      ),
                                      InkWell(
                                          onTap: () async {
                                            await _authenticateMe();
                                            if (authenticated) {
                                              print(authenticated);
                                              print('hello fomr authenticated');
                                              BlocProvider.of<LoginBloc>(context)
                                                  .add(LoginThroughBiometrics());
                                            }
                                          },
                                          child: Icon(
                                            Icons.fingerprint_rounded,
                                            color: Colors.black,
                                            size: 60,
                                          )),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
