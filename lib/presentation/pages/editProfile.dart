import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';
import '../widgets/appBarWidget.dart';
import '../widgets/buttonWidget.dart';
import '../widgets/textformfeild.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _dateOfBirthController = TextEditingController();
  final TextEditingController _permanentAddressController =
      TextEditingController();
  final TextEditingController _temporaryAddressController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    double mediaQueryHeight = MediaQuery.of(context).size.height;
    double mediaQueryWidth = MediaQuery.of(context).size.width;

    double heightBetweenTextField = mediaQueryHeight * 0.02;

    return Scaffold(
      appBar: appBar(
          icon: Icons.arrow_back_ios_new_outlined,
          navTitle: 'EDIT PROFILE',
          backNavigate: () {
            print('Navigator.pop(context);');
            Navigator.pop(context);
          }),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              textFormField(
                  // obsecureTextOldPassword: false,
                  validator: (value) {},
                  controller: _userNameController,
                  hintText: 'Username',
                  obsecureText1: () {
                    setState(() {});
                  }),
              SizedBox(
                height: heightBetweenTextField,
              ),
              textFormField(
                  validator: (value) {},
                  controller: _phoneNumberController,
                  hintText: 'Phone number',
                  obsecureText1: () {
                    setState(() {});
                  }),
              SizedBox(
                height: heightBetweenTextField,
              ),
              textFormField(
                  validator: (value) {},
                  controller: _emailController,
                  hintText: 'Email',
                  obsecureText1: () {
                    setState(() {});
                  }),
              SizedBox(
                height: heightBetweenTextField,
              ),
              textFormField(
                  validator: (value) {},
                  controller: _dateOfBirthController,
                  hintText: 'Date of Birth',
                  obsecureText1: () {
                    setState(() {});
                  }),
              SizedBox(
                height: heightBetweenTextField,
              ),
              textFormField(
                  validator: (value) {},
                  controller: _permanentAddressController,
                  hintText: 'Permanent Address',
                  obsecureText1: () {
                    setState(() {});
                  }),
              SizedBox(
                height: heightBetweenTextField,
              ),
              textFormField(
                  validator: (value) {},
                  controller: _temporaryAddressController,
                  hintText: 'Temporary Address',
                  obsecureText1: () {
                    setState(() {});
                  }),
              SizedBox(
                height: heightBetweenTextField,
              ),
              const Text('Gender'),
              SizedBox(
                height: heightBetweenTextField,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  radioButtonWidget('Male', 'Male', () {}),
                  radioButtonWidget('Male', 'Female', () {}),
                  radioButtonWidget('Male', 'others', () {}),
                ],
              ),
              SizedBox(
                height: heightBetweenTextField,
              ),
              const Text('Upload Identification Document'),
              SizedBox(
                height: heightBetweenTextField,
              ),
              const Text('Upload Identification Document'),
              Padding(
                padding: const EdgeInsets.all(13),
                child: button('Save', () {
                  Navigator.pop(context);
                }, false, AppColors.buttonColor),
              )
            ],
          ),
        ),
      ),
    );
  }
}

Widget radioButtonWidget(
    String _selectedGender, String genderTitle, Function() onclick) {
  return Row(
    children: [
      Radio(
        value: 'Male',
        groupValue: _selectedGender,
        onChanged: (value) {
          onclick();
        },
      ),
      Text(genderTitle)
    ],
  );
}
