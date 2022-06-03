import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salesforce/presentation/blocs/publish_notification/publish_notification_bloc.dart';
import 'package:salesforce/presentation/pages/changePasswordPage.dart';
import 'package:salesforce/presentation/pages/notice_board_table_page.dart';
import 'package:salesforce/presentation/pages/profilePage.dart';
import 'package:salesforce/presentation/widgets/backgroundShadesWidget.dart';
import 'package:salesforce/presentation/widgets/buttonWidget.dart';
import 'package:salesforce/routes.dart';

import '../../utils/app_colors.dart';

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
  @override
  Widget build(BuildContext context) {
    double mediaQueryHeight = MediaQuery.of(context).size.height;
    double mediaQueryWidth = MediaQuery.of(context).size.width;
    return BlocBuilder<PublishNotificationBloc, PublishNotificationState>(
      builder: (context, state) {
        return BlocListener<PublishNotificationBloc, PublishNotificationState>(
          listener: (context, state) {},
          child: SingleChildScrollView(
            child: Container(
              height: (mediaQueryHeight > mediaQueryWidth)
                  ? mediaQueryHeight 
                  : mediaQueryWidth,
              child: Scaffold(
                  body: Stack(
                children: [
                  BackgroundShades(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: mediaQueryHeight * 0.12,
                      ),
                      Align(
                          alignment: Alignment.center,
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          const ProfileScreen()));
                            },
                            child: const CircleAvatar(
                              radius: 40,
                              backgroundImage: AssetImage(
                                  'assets/images/userProfilePicture.png'),
                            ),
                          )),
                      SizedBox(
                        height: mediaQueryHeight * 0.01,
                      ),
                      Text(
                        'Frank Miller',
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
                        child: ProfileOptions(mediaQueryWidth, context,
                            Icons.edit_outlined, 'Edit Account Info'),
                      ),
                      SizedBox(
                        height: mediaQueryHeight * 0.001,
                      ),
                      ProfileOptions(mediaQueryWidth, context,
                          Icons.location_on_sharp, 'Address Info'),
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
                                                  color:
                                                      AppColors.iconBoxColor),
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
                                        width:
                                            MediaQuery.of(context).size.width,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          // color: Colors.grey,
                                          color: Color(0xffD3D3D3),
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
                      ProfileOptions(mediaQueryWidth, context,
                          Icons.sticky_note_2_outlined, 'Privacy Policy'),
                      InkWell(
                        onTap: () {
                          BlocProvider.of<PublishNotificationBloc>(context)
                              .add(GetAllPublishNotificationEvent());
                          if (state is PublishNotificationLoadedState) {
                            print(
                                "psuh me to this page mahh NoticeBoardTableScreen");
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        NoticeBoardTableScreen()));
                          }
                        },
                        child: ProfileOptions(mediaQueryWidth, context,
                            Icons.notifications, 'Notice Board'),
                      ),
                      // const Spacer(),
                      SizedBox(
                        height: mediaQueryHeight * 0.12,
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
          ),
        );
      },
    );
  }

  Widget ProfileOptions(double mediaQueryWidth, BuildContext context,
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
          Icon(Icons.arrow_forward_ios_outlined)
        ],
      ),
    );
  }
}
