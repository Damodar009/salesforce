import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salesforce/domain/entities/userDetail.dart';
import 'package:salesforce/domain/usecases/usecasesForRemoteSource.dart';
import 'package:salesforce/injectable.dart';
import 'package:salesforce/presentation/blocs/profile_bloc/profile_bloc.dart';
import 'package:salesforce/presentation/widgets/radioBotton.dart';
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
  String selectedValue = "";
  void selectValueRadioButton(String selectValue) {
    setState(() {
      selectedValue = selectValue;
    });
  }

  var useCaseForRemoteSourceimpl = getIt<UseCaseForRemoteSourceimpl>();

  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _dateOfBirthController = TextEditingController();
  final TextEditingController _permanentAddressController =
      TextEditingController();
  final TextEditingController _temporaryAddressController =
      TextEditingController();
  final TextEditingController _documentTypesController =
      TextEditingController();

  final TextEditingController _genderController = TextEditingController();

  List<String> items = [
    'CitizenShip',
    'Digination',
    'Employee Contact',
    'Bank Account',
  ];

  @override
  Widget build(BuildContext context) {
    double mediaQueryHeight = MediaQuery.of(context).size.height;
    double mediaQueryWidth = MediaQuery.of(context).size.width;

    double heightBetweenTextField = mediaQueryHeight * 0.02;

    return BlocProvider<ProfileBloc>(
      create: (context) => ProfileBloc(),
      child: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          return BlocListener<ProfileBloc, ProfileState>(
            listener: (context, state) {
              if (state is SaveUserDetailsLoadedState) {
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Profile has been updated')));
              } else if (state is SaveUserDetailsFailedState) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('Error while updating profile')));
              }
              // TODO: implement listener
            },
            child: Scaffold(
              appBar: appBar(
                  icon: Icons.arrow_back_ios_new_outlined,
                  navTitle: 'EDIT PROFILE',
                  backNavigate: () {
                    print('Navigator.pop(context);');
                    Navigator.pop(context);
                  }),
              body: SingleChildScrollView(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 13, vertical: 25),
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
                      DateTimePicker(
                        controller: _dateOfBirthController,
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2100),
                        dateLabelText: 'Date',
                        decoration: const InputDecoration(
                            fillColor: Colors.white,
                            errorStyle:
                                TextStyle(color: AppColors.primaryColor),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(30.0),
                              ),
                              borderSide: BorderSide(
                                  color: AppColors.textFeildINputBorder),
                            ),
                            filled: true,
                            hintStyle: TextStyle(
                              color: Colors.blue,
                              fontFamily: 'Inter',
                              fontSize: 15,
                            ),
                            hintText: 'DD/MM/YYYY',
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 5),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.blue),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(30.0),
                                )),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.blue),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(30.0),
                                ))),
                        onChanged: (val) => print(val),
                        validator: (val) {
                          print(val);
                          return null;
                        },
                        onSaved: (val) => print(val),
                      ),
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
                        children: [
                          buildIndividualRadio(
                              "Male", selectedValue, selectValueRadioButton),
                          buildIndividualRadio(
                              "Female", selectedValue, selectValueRadioButton),
                          buildIndividualRadio(
                              "others", selectedValue, selectValueRadioButton),
                        ],
                      ),
                      SizedBox(
                        height: heightBetweenTextField,
                      ),
                      const Text('Upload Identification Document'),
                      SizedBox(
                        height: heightBetweenTextField,
                      ),
                      const Text('Types'),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: textFeildWithDropDown(
                            controller: _documentTypesController,
                            validator: (string) {},
                            hintText: 'Choose',
                            item: items),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(13),
                        child: button('Save', () async {
                          BlocProvider.of<ProfileBloc>(context).add(
                              SaveUserDetailsEvent(
                                  userDetails: UserDetails(
                                      fullName: _userNameController.text,
                                      contactNumber2:
                                          _phoneNumberController.text,
                                      permanentAddress:
                                          _permanentAddressController.text,
                                      temporaryAddress:
                                          _temporaryAddressController.text,
                                      userDocument:
                                          _documentTypesController.text,
                                      gender: selectedValue,
                                      dob: _dateOfBirthController.text)));
                        }, state is SaveUserDetailsLoadedState ? true : false,
                            AppColors.buttonColor),
                      )
                    ],
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

Widget radioButtonWidget(
    int selectedValue, int value, String genderTitle, Function() onclick) {
  return Row(
    children: [
      Radio(
        value: selectedValue,
        groupValue: selectedValue,
        onChanged: (value) {
          onclick();
        },
      ),
      Text(genderTitle)
    ],
  );
}
