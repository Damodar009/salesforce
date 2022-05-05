import 'package:flutter/material.dart';
import 'package:salesforce/data/datasource/remotesource.dart';
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
  bool obse3cure = true;
  @override
  Widget build(BuildContext context) {
    double mediaQueryHeight = MediaQuery.of(context).size.height;

    double heightBetweenTextField = mediaQueryHeight * 0.03;

    RemoteSourceImplementation remoteSourceImplementation =
        RemoteSourceImplementation();

    return Scaffold(
      appBar: appBar(
          icon: Icons.arrow_back_ios_new_outlined, navTitle: 'CHANGE PASSWORD'),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 20),
        child: Column(
          children: [
            textFormField(
                obsecureText: obse3cure,
                showObsecureIcon: true,
                validator: (value) {},
                controller: _oldPasswordController,
                hintText: 'Old password',
                obsecureText1: () {
                  setState(() {
                    obse3cure = !obse3cure ;
                  });
                }),
            SizedBox(
              height: heightBetweenTextField,
            ),
            textFormField(
                obsecureText: true,
                showObsecureIcon: true,
                validator: (value) {},
                controller: _newPasswordController,
                hintText: 'New password',
                obsecureText1: () {
                  setState(() {});
                }),
            SizedBox(
              height: heightBetweenTextField,
            ),
            textFormField(
                obsecureText: true,
                showObsecureIcon: true,
                validator: (value) {},
                controller: _reTypePasswordController,
                hintText: 'Re-type password',
                obsecureText1: () {
                  setState(() {});
                }),
            Spacer(),
            button('Save', () {
              remoteSourceImplementation.changePassword(
                  _oldPasswordController.text, _newPasswordController.text);
            }, false, AppColors.buttonColor),
          ],
        ),
      ),
    );
  }
}
