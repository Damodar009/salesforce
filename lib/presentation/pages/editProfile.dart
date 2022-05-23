import 'dart:io';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:salesforce/data/models/SaveUserDetailsDataModel.dart';
import 'package:salesforce/data/models/userDetailModel.dart';
import 'package:salesforce/domain/entities/userDetailsData.dart';
import 'package:salesforce/domain/usecases/hiveUseCases/hiveUseCases.dart';
import 'package:salesforce/domain/usecases/usecasesForRemoteSource.dart';
import 'package:salesforce/injectable.dart';
import 'package:salesforce/presentation/blocs/profile_bloc/profile_bloc.dart';
import 'package:salesforce/presentation/blocs/upload_image/upload_image_bloc.dart';
import 'package:salesforce/presentation/widgets/radioBotton.dart';
import 'package:salesforce/routes.dart';
import 'package:salesforce/utils/hiveConstant.dart';
import '../../utils/app_colors.dart';
import '../widgets/appBarWidget.dart';
import '../widgets/buttonWidget.dart';
import '../widgets/textformfeild.dart';

class EditProfileScreen extends StatefulWidget {
  UserDetailsData getProfileState;
  var useCaseForHiveImpl = getIt<UseCaseForHiveImpl>();

  EditProfileScreen({
    Key? key,
    required this.getProfileState,
  }) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  var useCaseForHiveImpl = getIt<UseCaseForHiveImpl>();

  File? image;

  String selectedValue = "";

  void selectValueRadioButton(
    String selectValue,
  ) {
    setState(() {
      selectedValue = selectValue;
    });
  }

  bool hasImage = false;
  Future getImage() async {
    final ImagePicker _picker = ImagePicker();
    try {
      final image = await _picker.pickImage(source: ImageSource.gallery);
      print("dfgsadg");
      if (image == null) return;
      print(image.name);
      _pickImageController.text = image.name;
      final imageTemporary = File(image.path);
      print("this is path of image ");
      print(imageTemporary);
      setState(() {
        this.image = imageTemporary;
        hasImage = true;
      });
    } on PlatformException catch (e) {
      debugPrint('Failed to pick image: $e');
    }
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
  final TextEditingController _pickImageController = TextEditingController();

  String dobOnChangeValue = "";

  List<String> items = [
    'CitizenShip',
    'Digination',
    'Employee Contact',
    'Bank Account',
  ];

  Future pickImage() async {
    try {
      ImagePicker picker = ImagePicker();
      final image = await picker.pickImage(source: ImageSource.camera);
      if (image == null) return;
      final imageTemporary = File(image.path);
      setState(() => this.image = imageTemporary);
    } on PlatformException catch (e) {
      print("Failed to pick image $e");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    // String? selectedValue = widget.getProfileState.userDetail?.gender;
    // selectValueRadioButton("",selectedValue: selectedValue!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double mediaQueryHeight = MediaQuery.of(context).size.height;
    double mediaQueryWidth = MediaQuery.of(context).size.width;

    double heightBetweenTextField = mediaQueryHeight * 0.02;

    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, Profilestate) {
        return BlocListener<ProfileBloc, ProfileState>(
          listener: (context, Profilestate) {
            if (Profilestate is SaveUserDetailsLoadedState) {
              // BlocProvider.of<ProfileBloc>(context).add(GetProfileEvent());

              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Profile has been updated')));
            } else if (Profilestate is SaveUserDetailsFailedState) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text('Error while updating profile')));
            }
            // TODO: implement listener
          },
          child: Scaffold(
            appBar: appBar(navTitle: 'EDIT PROFILE', context: context),
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
                        enableTextField: false,
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
                          hintText:
                              // widget.getProfileState.userDetail!.userDocument ??
                              "Choose",
                          item: items),
                    ),
                    SizedBox(
                      height: heightBetweenTextField,
                    ),
                    // image != null ? Image.file(image!) : Container(),
                    const Text('Upload Identification Document'),
                    SizedBox(
                      height: heightBetweenTextField,
                    ),
                    //image

                    Stack(
                      children: [
                        TextField(
                          decoration: InputDecoration(
                              fillColor: Colors.white,
                              errorStyle: const TextStyle(
                                  color: AppColors.primaryColor),
                              border: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(15.0),
                                ),
                                borderSide: BorderSide(
                                    color: AppColors.textFeildINputBorder),
                              ),
                              filled: true,
                              hintStyle: const TextStyle(
                                color: Colors.grey,
                                fontFamily: 'Inter',
                                fontSize: 12,
                              ),
                              hintText: (widget.getProfileState.userDetail!
                                          .userDocument ==
                                      null)
                                  ? "Upload Image"
                                  : widget
                                      .getProfileState.userDetail!.userDocument,
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
                        ),
                        Positioned(
                            right: 10,
                            bottom: 4,
                            child: InkWell(
                              onTap: () {
                                pickImage();
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
                    ),

                    SizedBox(
                      height: heightBetweenTextField,
                    ),
                    BlocBuilder<UploadImageBloc, UploadImageState>(
                      builder: (context, Imagestate) {
                        return Padding(
                          padding: const EdgeInsets.all(13),
                          child: button('Save', () async {
                            print("object99999");

                            //image event
                            BlocProvider.of<UploadImageBloc>(context)
                                .add(SaveImageEvent(imageName: image!.path));

                            //image state check

                            String? imageId = Imagestate is SaveImageLoadedState
                                ? Imagestate.imageResponse
                                : "Image unable to upload";

                            //edit profile event

                            String? phoneNumber;

                            Box box =
                                await Hive.openBox(HiveConstants.userdata);

                            var phoneNumberSuccessOrFailed = useCaseForHiveImpl
                                .getValueByKey(box, "phoneNumber");

                            phoneNumberSuccessOrFailed.fold(
                                (l) => {print("failed")},
                                (r) => {phoneNumber = r!, print(r.toString())});

                            BlocProvider.of<ProfileBloc>(context).add(
                              SaveUserDetailsEvent(
                                saveUserDetailsDataModel:
                                    SaveUserDetailsDataModel(
                                  id: widget.getProfileState.id,
                                  //userid
                                  roleId: widget.getProfileState.roleId,
                                  email: widget.getProfileState.email,
                                  phoneNumber: phoneNumber,
                                  roleName: widget.getProfileState.roleName,
                                  userDetail: UserDetailsModel(
                                    id: widget.getProfileState.userDetail!
                                        .user_detail_id,
                                    fullName: (_userNameController.text == "")
                                        ? widget.getProfileState.userDetail!
                                            .fullName
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
                                    contactNumber2:
                                        _phoneNumberController.text == ""
                                            ? widget.getProfileState.userDetail!
                                                .contactNumber2
                                            : _phoneNumberController.text,
                                    userDocument: imageId, //image id
                                  ),
                                ),
                              ),
                            );

                            // Navigator.pushNamed(context, Routes.menuScreen);
                            // BlocProvider.of<ProfileBloc>(context)
                            //     .add(GetProfileEvent());
                          },
                              (Imagestate is SaveImageLoadingState
                                  ? (Profilestate is SaveUserDetailsLoadedState
                                      ? true
                                      : false)
                                  : false),
                              AppColors.buttonColor),
                        );
                      },
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

Widget imageUpload(Function() onclick) {
  File _image;
  // final picker = ImagePicker();
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
                onclick;
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
