import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:salesforce/data/datasource/remoteSource/remotesource.dart';

import 'package:salesforce/utils/app_colors.dart';
import 'package:salesforce/utils/validators.dart';
import '../../../routes.dart';
import '../../blocs/auth_bloc/auth_bloc.dart';
import '../../widgets/buttonWidget.dart';
import '../../widgets/textformfeild.dart';

class LOginScreen extends StatefulWidget {
  const LOginScreen({Key? key}) : super(key: key);
  @override
  State<LOginScreen> createState() => _LOginScreenState();
}

class _LOginScreenState extends State<LOginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool rememberMe = false;
  bool obsecureText = true;
  bool isLoading = false;
  RemoteSourceImplementation remoteSourceImplementation =
      RemoteSourceImplementation();
  void login() {
    if (_formKey.currentState!.validate()) {
      remoteSourceImplementation.login(
          _emailController.text, _passwordController.text);
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    var authbloc = BlocProvider.of<AuthBloc>(context);
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is LoginSuccessState) {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text('Login successful')));
          print("routinhg");
          Navigator.of(context).pushNamed(Routes.dashboardRoute);
        } else if (state is LoginFailedState) {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('password or email mismatch')));
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: LayoutBuilder(
          builder: (context, constraints) {
            return Builder(builder: (context) {
              return ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: SingleChildScrollView(
                  child: Stack(
                    children: [
                      Positioned(
                          child: SvgPicture.asset(
                        "assets/images/login.svg",
                        color: const Color(0xffDAA53B),
                        height: 300,
                        width: 200,
                      )),
                      Column(
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.26,
                          ),
                          const Text(
                            "LOGIN",
                            style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF022859)),
                          ),
                          const SizedBox(
                            height: 85,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Form(
                                key: _formKey,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    textFormField(
                                        validator: (value) {
                                          if (!Validators.isValidEmail(
                                              value!)) {
                                            return "please enter valid username";
                                          } else {
                                            return null;
                                          }
                                        },
                                        controller: _emailController,
                                        hintText: 'Username',
                                        obsecureText1: () {
                                          setState(() {});
                                        }),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    textFormField(
                                        showObsecureIcon: true,
                                        validator: (value) {
                                          if (value!.length < 3) {
                                            return "please enter strong password";
                                          } else {
                                            return null;
                                          }
                                        },
                                        controller: _passwordController,
                                        obsecureText: obsecureText,
                                        hintText: 'Password',
                                        obsecureText1: () {
                                          setState(() {
                                            obsecureText = !obsecureText;
                                          });
                                        }),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: <Widget>[
                                        StatefulBuilder(
                                            builder: (context, setStat) {
                                          return Checkbox(
                                              value: rememberMe,
                                              activeColor:
                                                  AppColors.outLetSalesCard,
                                              fillColor: MaterialStateColor
                                                  .resolveWith((states) =>
                                                      AppColors.buttonColor),
                                              checkColor:
                                                  AppColors.outLetSalesCard,
                                              onChanged: (newValue) {
                                                //todo write code for remember me
                                                setStat(() {
                                                  rememberMe = newValue!;
                                                });
                                              });
                                        }),
                                        const Padding(
                                          padding: EdgeInsets.only(right: 8.0),
                                          child: Text(
                                            'Remember me',
                                            style: TextStyle(
                                                color: Color(0xFF003049)),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.2,
                                    ),
                                    BlocBuilder<AuthBloc, AuthState>(
                                      builder: (context, state) {
                                        if (state is AuthInitial) {
                                          return button(("Log in"), () {
                                            if (_formKey.currentState!
                                                .validate()) {
                                              print("is valid ");
                                              authbloc.add(LoginAttemptEvent(
                                                  username:
                                                      _emailController.text,
                                                  password: _passwordController
                                                      .text));
                                            } else {}
                                          }, isLoading, AppColors.buttonColor);
                                        } else if (state is LoginLoadingState) {
                                          return button(("Log in"), () {}, true,
                                              AppColors.buttonColor);
                                        } else {
                                          return button(("Log in"), () {
                                            if (_formKey.currentState!
                                                .validate()) {
                                              print("is valid ");
                                              authbloc.add(LoginAttemptEvent(
                                                  username:
                                                      _emailController.text,
                                                  password: _passwordController
                                                      .text));
                                            } else {}
                                          }, isLoading, AppColors.buttonColor);
                                        }
                                      },
                                    ),
                                  ],
                                )),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              );
            });
          },
        ),
      ),
    );
  }
//       ));
// }
}
