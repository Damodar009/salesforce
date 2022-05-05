import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salesforce/data/datasource/remotesource.dart';
import 'package:salesforce/presentation/pages/blocs/auth_bloc/auth_bloc.dart';
import 'package:salesforce/utils/app_colors.dart';

import '../widgets/appBarWidget.dart';
import '../widgets/buttonWidget.dart';
import '../widgets/textformfeild.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  TextEditingController _oldPasswordController = TextEditingController();
  TextEditingController _newPasswordController = TextEditingController();
  TextEditingController _reTypePasswordController = TextEditingController();

  bool obsecureTextNewPassword = true;
  bool obsecureTextOldPassword = true;
  bool obsecureTextReTypePassword = true;

  @override
  Widget build(BuildContext context) {
    double mediaQueryHeight = MediaQuery.of(context).size.height;

    double heightBetweenTextField = mediaQueryHeight * 0.03;

    RemoteSourceImplementation remoteSourceImplementation =
        RemoteSourceImplementation();

    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is ChangePasswordSuccessState) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('Password has been successfull updated.')));
        } else if (state is ChangePasswordFailedState) {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text('Error occured.')));
        }
        // TODO: implement listener
      },
      child: Scaffold(
        appBar: appBar(
            icon: Icons.arrow_back_ios_new_outlined,
            navTitle: 'CHANGE PASSWORD',
            backNavigate: () {
              Navigator.pop(context);
            }),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 20),
          child: Form(
            child: Column(
              children: [
                textFormField(
                    showObsecureIcon: true,
                    validator: (value) {
                      if (value!.length < 3) {
                        return "please enter strong password";
                      } else {
                        return null;
                      }
                    },
                    controller: _oldPasswordController,
                    obsecureText: obsecureTextNewPassword,
                    hintText: 'Password',
                    obsecureText1: () {
                      setState(() {
                        obsecureTextNewPassword = !obsecureTextNewPassword;
                      });
                    }),
                SizedBox(
                  height: heightBetweenTextField,
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
                    controller: _newPasswordController,
                    obsecureText: obsecureTextOldPassword,
                    hintText: 'new Password',
                    obsecureText1: () {
                      setState(() {
                        obsecureTextOldPassword = !obsecureTextOldPassword;
                      });
                    }),
                SizedBox(
                  height: heightBetweenTextField,
                ),
                textFormField(
                    showObsecureIcon: true,
                    validator: (value) {},
                    controller: _reTypePasswordController,
                    obsecureText: obsecureTextReTypePassword,
                    hintText: 'Confirm Password',
                    obsecureText1: () {
                      setState(() {
                        obsecureTextReTypePassword =
                            !obsecureTextReTypePassword;
                        print("hgchgfcxhgfcdgrvhctdx");
                      });
                    }),
                const Spacer(),
                button('Save', () {
                  // if (_newPasswordController.text ==
                  //     _oldPasswordController.text) {
                    BlocProvider.of<AuthBloc>(context).add(ChangePasswordEvent(
                        oldPassword: _oldPasswordController.text,
                        newPassword: _newPasswordController.text));
                  // } else {
                  //   ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  //       content: Text("Both password doesn't match")));
                  // }
                }, false, AppColors.buttonColor),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
