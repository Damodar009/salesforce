import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salesforce/presentation/blocs/profile_bloc/profile_bloc.dart';
import 'package:salesforce/presentation/pages/changePasswordPage.dart';
import 'package:salesforce/presentation/pages/editProfile.dart';
import '../../utils/app_colors.dart';
import '../widgets/appBarWidget.dart';
import '../widgets/buttonWidget.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    // TODO: implement initState
    print("your are in profile page");
    BlocProvider.of<ProfileBloc>(context).add(GetProfileEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double mediaQueryHeight = MediaQuery.of(context).size.height;

    double heightBetweenTextField = mediaQueryHeight * 0.04;

    return Scaffold(
      appBar: appBar(
          // icon: Icons.arrow_back_ios_new_outlined,
          navTitle: 'PROFILE',
          context: context
          // backNavigate: () {
          //   Navigator.pop(context);
          // },
          ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 20),
          child: LayoutBuilder(builder: (context, constraints) {
            return ConstrainedBox(
              constraints: BoxConstraints(maxHeight: constraints.maxHeight),
              child: BlocBuilder<ProfileBloc, ProfileState>(
                builder: (context, getProfilestate) {
                  if (getProfilestate is GetProfileLoadedState) {
                    return Column(
                      children: [
                        SizedBox(
                          height: 430,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                getProfilestate
                                        .userDetailsdata.userDetail?.fullName ??
                                    "No name",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2!
                                    .copyWith(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                              ),
                              Text(
                                getProfilestate.userDetailsdata.email!,
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
                                    Text(
                                      getProfilestate.userDetailsdata
                                              .userDetail!.contactNumber2 ??
                                          "No phone number",
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
                                    Text(
                                      getProfilestate.userDetailsdata
                                              .userDetail!.permanentAddress ??
                                          "No Address",
                                    ),
                                    SizedBox(
                                      height: heightBetweenTextField,
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                            Text(
                                              getProfilestate.userDetailsdata
                                                      .userDetail!.dob ??
                                                  "No dob".toString(),
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
                                            Text(
                                              getProfilestate
                                                      .userDetailsdata
                                                      .userDetail!
                                                      .temporaryAddress ??
                                                  "No address",
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
                                    Text(
                                      getProfilestate.userDetailsdata
                                              .userDetail!.gender ??
                                          "No gender",
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
                        Row(
                          children: [
                            Stack(
                              children: [
                                Container(
                                  height: 100,
                                  width: 100,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: NetworkImage(getProfilestate
                                                  .userDetailsdata
                                                  .userDetail!
                                                  .userDocument ??
                                              ""))),
                                ),
                                const Positioned(
                                    right: 17,
                                    child: Text(
                                      'x',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold),
                                    )),
                              ],
                            ),
                          ],
                        ),
                        // GridView.count(
                        //     shrinkWrap: true,
                        //     primary: true,
                        //     physics:
                        //         const NeverScrollableScrollPhysics(),
                        //     crossAxisCount: 2,
                        //     children: List.generate(4, (index) {
                        //       return Center(
                        //         child: Column(children: [
                        //           const Text(
                        //             'CitizenShip',
                        //           ),
                        //           Stack(
                        //             children: const [
                        //               Icon(
                        //                 Icons.image,
                        //                 size: 100,
                        //               ),
                        //               Positioned(
                        //                   right: 17,
                        //                   top: 6,
                        //                   child: Text(
                        //                     'x',
                        //                     style: TextStyle(
                        //                         color: Colors.white,
                        //                         fontSize: 24,
                        //                         fontWeight:
                        //                             FontWeight.bold),
                        //                   )),
                        //             ],
                        //           ),
                        //           const Text(
                        //             'view',
                        //           )
                        //         ]),
                        //       );
                        //     })),
                        //
                        SizedBox(
                          height: mediaQueryHeight * 0.04,
                        ),
                        button('Edit Profile', () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      EditProfileScreen(
                                          getProfileState: getProfilestate
                                              .userDetailsdata)));
                        }, false, AppColors.buttonColor),
                        SizedBox(
                          height: mediaQueryHeight * 0.01,
                        ),
                        button('Change password', () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      const ChangePasswordScreen()));
                        }, false, const Color(0xfffa8b7cb)),
                      ],
                    );
                  } else if (getProfilestate is GetProfileFailedState) {
                    return const Center(child: Text('No data found'));
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              ),
            );
          }),
        ),
      ),
    );
  }
}
