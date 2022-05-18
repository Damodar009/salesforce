import 'dart:io';

import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:salesforce/data/models/SaveUserDetailsDataModel.dart';
import 'package:salesforce/data/models/userDetailModel.dart';
import 'package:salesforce/domain/entities/userDetailsData.dart';
import 'package:salesforce/domain/usecases/usecasesForRemoteSource.dart';
import 'package:salesforce/injectable.dart';
import 'package:salesforce/presentation/blocs/profile_bloc/profile_bloc.dart';
import 'package:salesforce/presentation/widgets/radioBotton.dart';
import 'package:salesforce/routes.dart';
import '../../utils/app_colors.dart';
import '../widgets/appBarWidget.dart';
import '../widgets/buttonWidget.dart';
import '../widgets/textformfeild.dart';

class EditProfileScreen extends StatefulWidget {
  UserDetailsData getProfileState;
  EditProfileScreen({Key? key, required this.getProfileState})
      : super(key: key);

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

  String dobOnChangeValue = "";

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

    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        return BlocListener<ProfileBloc, ProfileState>(
          listener: (context, state) {
            if (state is SaveUserDetailsLoadedState) {
              BlocProvider.of<ProfileBloc>(context).add(GetProfileEvent());
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
                  Navigator.pushNamed(context, Routes.profileRoute);
                }),
            body: SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 13, vertical: 25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Enter Full Name",
                      style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    textFormField(
                        // obsecureTextOldPassword: false,
                        validator: (value) {},
                        controller: _userNameController,
                        hintText:
                            (widget.getProfileState.userDetail!.fullName) ?? "",
                        obsecureText1: () {
                          setState(() {});
                        }),
                    SizedBox(
                      height: heightBetweenTextField,
                    ),
                    Text(
                      "Enter Your Phone Number",
                      style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    textFormField(
                        validator: (value) {},
                        controller: _phoneNumberController,
                        hintText: (widget
                                .getProfileState.userDetail!.contactNumber2 ??
                            ""),
                        obsecureText1: () {
                          setState(() {});
                        }),
                    SizedBox(
                      height: heightBetweenTextField,
                    ),
                    textFormField(
                        validator: (value) {},
                        controller: _emailController,
                        hintText: widget.getProfileState.email ?? "Email",
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
                      decoration: InputDecoration(
                          fillColor: Colors.white,
                          errorStyle: const TextStyle(
                              color: Color.fromRGBO(2, 40, 89, 1)),
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(30.0),
                            ),
                            borderSide: BorderSide(
                                color: AppColors.textFeildINputBorder),
                          ),
                          filled: true,
                          hintStyle: const TextStyle(
                            color: Colors.black,
                            fontFamily: 'Inter',
                            fontSize: 15,
                          ),
                          hintText:
                              (widget.getProfileState.userDetail!.dob == null)
                                  ? "Choose your dob"
                                  : widget.getProfileState.userDetail!.dob,
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 5),
                          focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.blue),
                              borderRadius: BorderRadius.all(
                                Radius.circular(30.0),
                              )),
                          enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.blue),
                              borderRadius: BorderRadius.all(
                                Radius.circular(30.0),
                              ))),
                      onChanged: (val) {
                        setState(() {
                          dobOnChangeValue = val;
                          // print(dobOnChangeValue);
                          // print("your dob is");
                        });
                      },
                      validator: (val) {
                        print(val);
                        return null;
                      },
                      onSaved: (val) => print(val),
                    ),
                    SizedBox(
                      height: heightBetweenTextField,
                    ),
                    Text(
                      "Enter Permanent address",
                      style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    textFormField(
                        validator: (value) {},
                        controller: _permanentAddressController,
                        hintText: (widget.getProfileState.userDetail!
                                .permanentAddress) ??
                            "",
                        obsecureText1: () {
                          setState(() {});
                        }),
                    SizedBox(
                      height: heightBetweenTextField,
                    ),
                    Text(
                      "Enter Temporary Address",
                      style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    textFormField(
                        validator: (value) {},
                        controller: _temporaryAddressController,
                        hintText: widget
                                .getProfileState.userDetail!.temporaryAddress ??
                            "",
                        obsecureText1: () {
                          setState(() {});
                        }),
                    SizedBox(
                      height: heightBetweenTextField,
                    ),
                    Text(
                      'Gender',
                      style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                    ),
                    const SizedBox(
                      height: 5,
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
                    const Text('Types'),
                    SizedBox(
                      height: heightBetweenTextField,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: textFeildWithDropDown(
                          controller: _documentTypesController,
                          validator: (string) {},
                          hintText: 'Choose',
                          item: items),
                    ),
                    SizedBox(
                      height: heightBetweenTextField,
                    ),
                    const Text('Upload Identification Document'),
                    SizedBox(
                      height: heightBetweenTextField,
                    ),
                    imageUpload(),
                    SizedBox(
                      height: heightBetweenTextField,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(13),
                      child: button('Save', () async {
                        BlocProvider.of<ProfileBloc>(context).add(
                          SaveUserDetailsEvent(
                            saveUserDetailsDataModel: SaveUserDetailsDataModel(
                              id: 'Fii0wdochNnYL15BnZAJMg==', //userid
                              roleId: 'Nh5PXNgMPBdS1gqJOz7PoQ==',
                              email: 'test12345@gmail.com',
                              phoneNumber: '0978676543',
                              roleName: 'SALES REPRESENTATIVE',
                              userDetail: UserDetailsModel(
                                  fullName: (_userNameController.text == "")
                                      ? widget
                                          .getProfileState.userDetail!.fullName
                                      : _userNameController.text,
                                  gender: (selectedValue == "")
                                      ? widget
                                          .getProfileState.userDetail!.gender
                                      : selectedValue,
                                  dob: (_dateOfBirthController.text == "")
                                      ? widget.getProfileState.userDetail!.dob
                                      : _dateOfBirthController.text,
                                  permanentAddress:
                                      _permanentAddressController.text == ""
                                          ? widget.getProfileState.userDetail!
                                              .permanentAddress
                                          : _permanentAddressController.text,
                                  temporaryAddress:
                                      _temporaryAddressController.text == ""
                                          ? widget.getProfileState.userDetail!
                                              .temporaryAddress
                                          : _temporaryAddressController.text,
                                  contactNumber2: _phoneNumberController.text ==
                                          ""
                                      ? widget.getProfileState.userDetail!
                                          .contactNumber2
                                      : _phoneNumberController.text,
                                  userDocument:
                                      _documentTypesController.text == ""
                                          ? widget.getProfileState.userDetail!
                                              .userDocument
                                          : _documentTypesController.text,
                                  id: 'KdNUBc6r+5WeVj1uUOLKnw=='),
                            ),
                          ),
                        );
                        // clearText();
                        // Navigator.pushNamed(context, Routes.profileRoute);
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

Widget imageUpload() {
  File _image;
  final picker = ImagePicker();
  return Stack(
    // textDirection: TextDirection.rtl,
    children: [
      const TextField(
        decoration: InputDecoration(
            fillColor: Colors.white,
            errorStyle: TextStyle(color: AppColors.primaryColor),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(15.0),
              ),
              borderSide: BorderSide(color: AppColors.textFeildINputBorder),
            ),
            filled: true,
            hintStyle: TextStyle(
              color: Colors.grey,
              fontFamily: 'Inter',
              fontSize: 15,
            ),
            hintText: 'Upload Image',
            contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
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
      ),
      Positioned(
          right: 10,
          bottom: 4,
          child: InkWell(
            onTap: () {
              Future selectOrTakePhoto() async {
                final pickedFile =
                    await picker.getImage(source: ImageSource.gallery);

                print('object of iamge 1234');

                // setState(() {
                //   if (pickedFile != null) {
                //     _image = File(pickedFile.path);
                //     // Navigator.pushNamed(context, routeEdit,
                //     //     arguments: _image);
                //     print('object of image');
                //   } else
                //     print('No photo was selected or taken');
                // });
              }
            },
            child: Container(
              height: 40,
              width: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: AppColors.buttonColor,
              ),
              child: const Center(
                child: Text(
                  'Upload',
                  style: TextStyle(
                      fontSize: 12,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ))
    ],
  );
}
