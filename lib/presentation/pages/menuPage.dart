import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:salesforce/presentation/blocs/publish_notification/publish_notification_bloc.dart';
import 'package:salesforce/presentation/pages/changePasswordPage.dart';
import 'package:salesforce/presentation/pages/notice_board_table_page.dart';
import 'package:salesforce/presentation/pages/profilePage.dart';
import 'package:salesforce/presentation/widgets/backgroundShadesWidget.dart';
import 'package:salesforce/presentation/widgets/buttonWidget.dart';
import 'package:salesforce/routes.dart';
import 'package:salesforce/utils/hiveConstant.dart';

import '../../utils/app_colors.dart';
import '../widgets/delete_theory_testPopup_widget.dart';

class MenuScreen extends StatefulWidget {
  final IconData? icon;
  final String? title;

  const MenuScreen({Key? key, this.icon, this.title}) : super(key: key);

  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  bool showAnswer = false;
  late bool plusIcon;
  String? userImage;
  String? userName;

  getImageAndNameFromHIve() async {
    Box userBox = await Hive.openBox(HiveConstants.userData);

    userName = userBox.get(HiveConstants.userName);
    userImage = userBox.get(HiveConstants.userImages);
  }

  @override
  void initState() {
    super.initState();
    getImageAndNameFromHIve();
  }

  @override
  Widget build(BuildContext context) {
    double mediaQueryHeight = MediaQuery.of(context).size.height;
    double mediaQueryWidth = MediaQuery.of(context).size.width;
    return BlocBuilder<PublishNotificationBloc, PublishNotificationState>(
      builder: (context, state) {
        return SizedBox(
          child: Scaffold(
            body: SingleChildScrollView(
                child: Stack(
              children: [
                const BackgroundShades(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: mediaQueryHeight * 0.12,
                    ),
                    Align(
                        alignment: Alignment.center,
                        child: userImage != null
                            ? CircleAvatar(
                                radius: 60,
                                backgroundImage: NetworkImage(userImage!))
                            : const CircleAvatar(
                                radius: 60,
                                backgroundImage: AssetImage(
                                    "assets/images/userProfilePicture.png"))),
                    SizedBox(
                      height: mediaQueryHeight * 0.01,
                    ),
                    Text(
                      userName ?? "",
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: mediaQueryHeight * 0.09,
                    ),
                    InkWell(
                      onTap: (() {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    ProfileScreen()));
                      }),
                      child: profileOptions(mediaQueryWidth, context,
                          Icons.edit_outlined, 'Edit Account Info'),
                    ),
                    SizedBox(
                      height: mediaQueryHeight * 0.001,
                    ),
                    // profileOptions(mediaQueryWidth, context,
                    //     Icons.location_on_sharp, 'Address Info'),
                    SizedBox(
                      height: mediaQueryHeight * 0.001,
                    ),
                    Center(
                      child: Column(
                        children: [
                          InkWell(
                            onTap: () {
                              setState(() {
                                showAnswer = !showAnswer;
                              });
                            },
                            child: Container(
                              decoration: const BoxDecoration(
                                color: Colors.white,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                        decoration: BoxDecoration(
                                            color: AppColors.iconBoxColor,
                                            border: Border.all(
                                                color: AppColors.iconBoxColor),
                                            borderRadius:
                                                BorderRadius.circular(6)),
                                        child: const Padding(
                                          padding: EdgeInsets.all(2.0),
                                          child: Icon(
                                            Icons.settings,
                                            size: 22,
                                          ),
                                        )),
                                    SizedBox(width: mediaQueryWidth * 0.03),
                                    Expanded(
                                      child: Text(
                                        'Setting',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1,
                                      ),
                                    ),
                                    Icon(showAnswer
                                        ? Icons.arrow_downward_outlined
                                        : Icons.arrow_forward_ios_outlined)
                                  ],
                                ),
                              ),
                            ),
                          ),
                          showAnswer
                              ? InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                const ChangePasswordScreen()));
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        // color: Colors.grey,
                                        color: const Color(0xffD3D3D3),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(16),
                                        child: Text(
                                          'Change Password',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1,
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              : Container(),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: mediaQueryHeight * 0.001,
                    ),
                    // profileOptions(mediaQueryWidth, context,
                    //     Icons.sticky_note_2_outlined, 'Privacy Policy'),
                    InkWell(
                      onTap: () {
                        BlocProvider.of<PublishNotificationBloc>(context)
                            .add(GetAllPublishNotificationEvent());
                        if (state is PublishNotificationLoadedState) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      NoticeBoardTableScreen()));
                        } else {}
                      },
                      child: profileOptions(mediaQueryWidth, context,
                          Icons.notifications, 'Notice Board'),
                    ),
                    InkWell(
                      onTap: (() {
                        displayTextInputDialog(context);
                        //pop up for request
                      }),
                      child: profileOptions(mediaQueryWidth, context,
                          Icons.edit_outlined, 'Request a Leave'),
                    ),
                    // const Spacer(),
                    SizedBox(
                      height: mediaQueryHeight * 0.095,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(13),
                      child: button('LogOut', () {
                        Navigator.of(context).pushNamed(Routes.logOUtRoutes);
                      }, false, AppColors.buttonColor),
                    )
                  ],
                ),
              ],
            )),
          ),
        );
      },
    );
  }

  Widget profileOptions(double mediaQueryWidth, BuildContext context,
      IconData icon, String title) {
    return Padding(
      padding: const EdgeInsets.all(13.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                  decoration: BoxDecoration(
                      color: AppColors.iconBoxColor,
                      border: Border.all(color: AppColors.iconBoxColor),
                      borderRadius: BorderRadius.circular(6)),
                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Icon(
                      icon,
                      size: 22,
                    ),
                  )),
              SizedBox(width: mediaQueryWidth * 0.03),
              Text(
                title,
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ],
          ),
          const Icon(Icons.arrow_forward_ios_outlined)
        ],
      ),
    );
  }
}

//
//
// DateTime selectedDate = DateTime.now();
//
// var as = showDatePicker(
//     context: context,
//     initialDate: selectedDate,
//     firstDate: DateTime(2001),
//     lastDate: DateTime(2101, 8))
//     .then(
//         (value) => print(value?.month));

//userImage !=null ? NetworkImage(userImage!)
