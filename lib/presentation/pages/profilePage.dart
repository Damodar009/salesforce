import 'package:flutter/material.dart';
import 'package:salesforce/presentation/pages/changePasswordPage.dart';
import 'package:salesforce/presentation/pages/editProfile.dart';
import '../../utils/app_colors.dart';
import '../widgets/appBarWidget.dart';
import '../widgets/buttonWidget.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double mediaQueryHeight = MediaQuery.of(context).size.height;

    double heightBetweenTextField = mediaQueryHeight * 0.04;

    return Scaffold(
      appBar: appBar(
          icon: Icons.arrow_back_ios_new_outlined,
          navTitle: 'PROFILE',
          backNavigate: () { Navigator.pop(context); }),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 20),
          child: LayoutBuilder(builder: (context, constraints) {
            return ConstrainedBox(
              constraints: BoxConstraints(maxHeight: constraints.maxHeight),
              child: Column(
                children: [
                  SizedBox(
                    height: 430,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Frank Miler',
                          style:
                              Theme.of(context).textTheme.bodyText2!.copyWith(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                        ),
                        const Text(
                          'miller.frank@gmail.com',
                        ),
                        SizedBox(
                          height: mediaQueryHeight * 0.07,
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 20),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: const [
                              BoxShadow(
                                color: AppColors.backgroundColor,
                                blurRadius: 70,
                                spreadRadius: 1,
                                offset: Offset(0, 80), // Shadow position
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Contact No.',
                              ),
                              SizedBox(
                                height: mediaQueryHeight * 0.01,
                              ),
                              const Text(
                                '977-9875755775',
                              ),
                              SizedBox(
                                height: heightBetweenTextField,
                              ),
                              const Text(
                                'Permanent Address',
                              ),
                              SizedBox(
                                height: mediaQueryHeight * 0.01,
                              ),
                              const Text(
                                'Suhaim Bin Hamad St, Doha',
                              ),
                              SizedBox(
                                height: heightBetweenTextField,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Date of Birth',
                                      ),
                                      SizedBox(
                                        height: mediaQueryHeight * 0.01,
                                      ),
                                      const Text(
                                        '2022/02/02',
                                      ),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Temporary Address',
                                      ),
                                      SizedBox(
                                        height: mediaQueryHeight * 0.01,
                                      ),
                                      const Text(
                                        'Suhaim Bin Hamad St',
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              SizedBox(
                                height: heightBetweenTextField,
                              ),
                              const Text(
                                'Gender',
                              ),
                              SizedBox(
                                height: mediaQueryHeight * 0.01,
                              ),
                              const Text(
                                'Male',
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: mediaQueryHeight * 0.04,
                  ),
                  GridView.count(
                      shrinkWrap: true,
                      primary: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: 2,
                      children: List.generate(4, (index) {
                        return Center(
                          child: Column(children: [
                            const Text(
                              'CitizenShip',
                            ),
                            Stack(
                              children: const [
                                Icon(
                                  Icons.image,
                                  size: 100,
                                ),
                                Positioned(
                                    right: 17,
                                    top: 6,
                                    child: Text(
                                      'x',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold),
                                    )),
                              ],
                            ),
                            const Text(
                              'view',
                            )
                          ]),
                        );
                      })),
                  SizedBox(
                    height: mediaQueryHeight * 0.04,
                  ),
                  button('Edit Profile', () {
                    Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => const EditProfileScreen()));
                  }, false, AppColors.buttonColor),
                  SizedBox(
                    height: mediaQueryHeight * 0.01,
                  ),
                  button('Change password', () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                                ChangePasswordScreen()));
                  }, false, const Color(0xfffa8b7cb)),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}
