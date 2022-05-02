import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:salesforce/data/datasource/remotesource.dart';
import 'package:salesforce/presentation/pages/blocs/auth_bloc/auth_bloc.dart';
import 'package:salesforce/utils/app_colors.dart';
import 'package:salesforce/utils/validators.dart';
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
  @override
  Widget build(BuildContext context) {
    void login() {
      if (_formKey.currentState!.validate()) {
        // box.put(Constants.EMAIL,
        //     _emailController.value.text);
        setState(() {
          isLoading = true;
        });
      } else {
        setState(() {
          isLoading = true;
        });
      }
    }

    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is LoginSuccessState) {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text('Login sucessful')));
        }
      },
      builder: (context, state) {
        return Scaffold(
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
                                            if (value!.length < 8) {
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
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
                                            padding:
                                                EdgeInsets.only(right: 8.0),
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
                                      button(
                                          // state is LoginLoadingState
                                          //     ? CircularProgressIndicator()
                                          //     : Text
                                          ("Log in"), () {
                                        remoteSourceImplementation.login(
                                            _emailController.text,
                                            _passwordController.text);
                                        // BlocProvider.of<LoginBloc>(context).add(
                                        //     LoginAttemptEvent(
                                        //         username: _emailController.text,
                                        //         password:
                                        //             _passwordController.text));
                                      }, isLoading, AppColors.buttonColor),
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
        );
      },
    );
  }
//       ));
// }
}
