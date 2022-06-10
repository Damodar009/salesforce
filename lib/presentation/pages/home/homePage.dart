import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hive/hive.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:salesforce/domain/entities/attendence.dart';
import 'package:salesforce/presentation/blocs/Attendence_Bloc/attendence_cubit.dart';
import 'package:salesforce/presentation/pages/todaysTarget/todaysTarget.dart';
import 'package:salesforce/presentation/blocs/publish_notification/publish_notification_bloc.dart';
import 'package:salesforce/presentation/widgets/notice_list_view_widget.dart';
import 'package:salesforce/routes.dart';
import 'package:salesforce/utils/initialData.dart';
import '../../../domain/usecases/useCaseForAttebdenceSave.dart';
import '../../../injectable.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/geolocation.dart';
import '../../../utils/hiveConstant.dart';
import 'attendenceRow.dart';
import 'card.dart';
import 'doughnatChart.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final InitialData _initialData = InitialData();
  final geoLocation = getIt<GeoLocationData>();
  bool loading = false;
  DateTime todayDateTime = DateTime.now();

  int? totalOutletsCount, newOutletsCount, visitedOutletCount, totalSalesCount;
  List<int?> todayTargets = [0, 0, 0, 0];

  List<String> title = [
    "Total Outlets",
    "New Outlets",
    "Total Outlets Visited Today",
    "Total Sales Today"
  ];
  List<String> icons = [
    "assets/icons/cardtotal.png",
    "assets/icons/cardtotal.png",
    "assets/icons/cardOutlets.png",
    "assets/icons/cardOutlets.png",
  ];
  String distanceTraveled = "0 km";
  String userName = "";

  bool? checkNotice;

  noticeCheck() {
    setState(() {
      checkNotice = checkNotice;
    });
  }

  getUserName() async {
    Box box = await Hive.openBox(HiveConstants.userdata);
    String tempname = await box.get("name");
    setState(() {
      userName = tempname;
    });
  }

  getTodayTargetData() async {
    TodayTarget todayTarget = TodayTarget();
    List<dynamic> salesData = [];
    salesData = await todayTarget.getSalesData();
    totalSalesCount = salesData.length;
    newOutletsCount = await todayTarget.getNewOutlets();
    totalOutletsCount = await todayTarget.getTotalOutlets();
    visitedOutletCount = await todayTarget.getTotalOutletsVisitedToday();

    setState(() {
      todayTargets.add(totalOutletsCount);
      todayTargets.add(newOutletsCount);
      todayTargets.add(visitedOutletCount);
      todayTargets.add(totalSalesCount);
    });
    // todayTarget.getAndSendSalesDataToApi(salesData);
  }

  saveCheckOutDataToApi() {
    Attendence attendence = Attendence(
      id: null,
      macAddress: "30-65-EC-6F-C4-58",
      checkin: "2022-12-21 09:30:00",
      checkin_latitude: 21.21,
      checkin_longitude: 122.12,
      checkout: null,
      checkout_latitude: null,
      checkout_longitude: null,
      user: "NGBifEuwYylJoyRt7a8bkA==",
    );
    print("started");
    var useCaseForAttendenceImpl = getIt<UseCaseForAttendenceImpl>();
    useCaseForAttendenceImpl.attendenceSave(attendence);
  }

  // TodayTarget todayTarget = TodayTarget();
  // todayTarget.sendListOfNewRetailer();
  final int _widgetIndex = 1;
  @override
  void initState() {
    BlocProvider.of<AttendenceCubit>(context).getCheckInStatus();
    _initialData.getAndSaveInitalData();
    getTodayTargetData();
    getUserName();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double mediaQueryHeight = MediaQuery.of(context).size.height;
    double mediaQueryWidth = MediaQuery.of(context).size.width;
    var attendenceCubit = BlocProvider.of<AttendenceCubit>(context);

    return IndexedStack(
      children: [
        Stack(
          children: [
            SingleChildScrollView(
              //todo
              child: SizedBox(
                height: MediaQuery.of(context).size.height + 395,
                width: MediaQuery.of(context).size.width,
                child: Stack(
                  children: [
                    Positioned(
                        child: SvgPicture.asset(
                      "assets/images/hometopleft.svg",
                      color: const Color(0xffDAA53B),
                    )),
                    Positioned(
                        right: 0,
                        child: SvgPicture.asset(
                          "assets/images/hometopright.svg",
                          color: const Color(0xffDAA53B),
                        )),
                    Positioned(
                        bottom: -50,
                        child: SvgPicture.asset(
                          "assets/images/homebottomleft.svg",
                          color: const Color(0xffDAA53B),
                        )),
                    Positioned(
                        bottom: -50,
                        right: 0,
                        child: SvgPicture.asset(
                          "assets/images/homebottomright.svg",
                          color: const Color(0xffDAA53B),
                        )),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 60,
                          ),
                          Text("Hello $userName!",
                              style: const TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.primaryColor)),
                          const SizedBox(
                            height: 10,
                          ),
                          BlocBuilder<AttendenceCubit, AttendenceState>(
                              builder: (context, state) {
                            if (state is CheckedInState) {
                              return const Text(
                                  "Please checkout when completed",
                                  style: TextStyle(
                                    fontSize: 18,
                                  ));
                            } else {
                              return const Text(
                                  "Please check in to enter your attendance \n for today",
                                  style: TextStyle(
                                    fontSize: 18,
                                  ));
                            }
                          }),
                          const SizedBox(
                            height: 40,
                          ),
                          Row(
                            children: [
                              SvgPicture.asset("assets/images/homeWalked.svg"),
                              const SizedBox(
                                width: 40,
                              ),
                              Column(
                                children: [
                                  Text(
                                    distanceTraveled,
                                    style: const TextStyle(
                                        fontSize: 35,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.primaryColor),
                                  ),
                                  const Text("Walked Today \nField name",
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: AppColors.primaryColor))
                                ],
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(13.0),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: const Color(0xffB5E8FC),
                                  borderRadius: BorderRadius.circular(15)),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      children: [
                                        const Text("ATTENDANCE"),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Text(todayDateTime.toString(),
                                            style:
                                                const TextStyle(fontSize: 12))
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        BlocBuilder<AttendenceCubit,
                                                AttendenceState>(
                                            builder: (context, state) {
                                          if (state is CheckedInState) {
                                            return attendanceRow("Check Out",
                                                () async {
                                              setState(() {
                                                loading = true;
                                              });
                                              bool check = await attendenceCubit
                                                  .checkOut();
                                              if (!check) {
                                                Navigator.of(context).pushNamed(
                                                    Routes.attendanceRoute);
                                              } else {
                                                // ScaffoldMessenger.of(context)
                                                //     .showSnackBar(const SnackBar(
                                                //         content:
                                                //             Text('check out failed ')));
                                              }

                                              setState(() {
                                                loading = false;
                                              });
                                            }, loading);
                                          } else {
                                            return attendanceRow("Check In",
                                                () async {
                                              setState(() {
                                                loading = true;
                                              });
                                              // check internet
                                              bool result =
                                                  await InternetConnectionChecker()
                                                      .hasConnection;

                                              if (result) {
                                                bool check =
                                                    await attendenceCubit
                                                        .checkIn();
                                                if (!check) {
                                                  Navigator.of(context)
                                                      .pushNamed(Routes
                                                          .attendanceRoute);
                                                } else {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(const SnackBar(
                                                          content: Text(
                                                              'Please go to depot first')));
                                                }
                                              } else {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(const SnackBar(
                                                        content: Text(
                                                            'Please connect to internet')));
                                              }

                                              setState(() {
                                                loading = false;
                                              });
                                            }, loading);
                                          }
                                        }),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          const Text("TOTAL ATTENDANCE"),
                          const DoughnutChart(),
                          const SizedBox(
                            height: 40,
                          ),
                          const Text("Today Target"),
                          Expanded(
                              child: GridView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            primary: true,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2),
                            itemBuilder: (_, index) => InkWell(
                                onTap: () {
                                  switch (index) {
                                    case 0:
                                      //todo get all  retailer  data from hive
                                      Navigator.of(context)
                                          .pushNamed(Routes.totalOutletsRoute);
                                      break;
                                    case 1:
                                      //todo get new retailer  data from hive
                                      Navigator.of(context)
                                          .pushNamed(Routes.newOutletRoute);
                                      break;
                                    case 2:
                                      // todo get data from hive for today visited outlet
                                      Navigator.of(context).pushNamed(
                                          Routes.totalOutLetsVisitedRoute);
                                      break;
                                    case 3:
                                      //todo get data from hive for total sales report
                                      Navigator.of(context)
                                          .pushNamed(Routes.totalSalesRoute);
                                      break;
                                    default:
                                  }
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: card(icons[index], title[index],
                                      todayTargets[index] ?? 0, context),
                                )),
                            itemCount: 4,
                          )),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            BlocBuilder<PublishNotificationBloc, PublishNotificationState>(
              builder: (context, state) {
                if (state is PublishNotificationLoadedState) {
                  print("shot notice mannnnnnn");
                  return Center(
                    child: NoticeListViewWidget(
                        data: state.publishNotificationState,
                        widgetIndex: _widgetIndex),
                  );
                } else {
                  print("you have an error so no notice");
                  return Container();
                }
              },
            ),
          ],
        ),
      ],
    );
  }
}
