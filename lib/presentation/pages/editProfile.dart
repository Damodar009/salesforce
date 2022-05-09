import 'package:flutter/material.dart';
import 'package:salesforce/data/datasource/remoteSource/remotesource.dart';
import 'package:salesforce/data/models/RetailerPojo.dart';
import 'package:salesforce/domain/usecases/useCaseForAttebdenceSave.dart';
import 'package:salesforce/domain/usecases/usecasesForRemoteSource.dart';
import 'package:salesforce/injectable.dart';
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
                  // RetailerPojoModel retailerPojoModel1 =
                  //     const RetailerPojoModel(
                  //         name: 'Gopaldf Prakash Pasal',
                  //         latitude: 12455.3211,
                  //         longitude: 21252.2123,
                  //         address: 'Rampursd',
                  //         contactPerson: 'Gopalsdaf Prakash',
                  //         contactNumber: '89786711564556',
                  //         retailerClass: 'C',
                  //         retailerType: '506buVWacVShn32ccOHCTw==',
                  //         region: '506buVWacVShn32ccOHCTw==');

                  // RetailerPojoModel retailerPojoModel2 =
                  //     const RetailerPojoModel(
                  //         name: 'Haiiri Prakash Pasal',
                  //         latitude: 112333.3211,
                  //         longitude: 2524531.2123,
                  //         address: 'Rampreur',
                  //         contactPerson: 'Harrei Prakash',
                  //         contactNumber: '89786337564446',
                  //         retailerClass: 'B',
                  //         retailerType: 'ZRlecVfxmjPY1xs!@sHCIgXP2Q==',
                  //         region: '506buVWacVShn32ccOHCTw==');

                  // useCaseForRemoteSourceimpl.saveAllRetailer(
                  //     [retailerPojoModel1, retailerPojoModel2]);

                  // RemoteSourceImplementation().saveSalesDataCollection();

                  // useCaseForRemoteSourceimpl.getUserDetailsData();
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
