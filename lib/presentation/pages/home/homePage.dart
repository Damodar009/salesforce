import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive/hive.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:salesforce/presentation/blocs/Attendence_Bloc/attendence_cubit.dart';
import 'package:salesforce/presentation/blocs/publish_notification/publish_notification_bloc.dart';
import 'package:salesforce/presentation/pages/todaysTarget/todaysTarget.dart';
import 'package:salesforce/presentation/widgets/notice_list_view_widget.dart';
import 'package:salesforce/routes.dart';
import 'package:salesforce/utils/initialData.dart';
import '../../../data/datasource/local_data_sources.dart';
import '../../../data/datasource/remoteSource/remotesource.dart';
import '../../../domain/entities/AttendendenceDashbard.dart';
import '../../../domain/entities/requestDeliver.dart';
import '../../../domain/usecases/useCaseForAttebdenceSave.dart';
import '../../../domain/usecases/useCaseForSalesData.dart';
import '../../../injectable.dart';
import '../../../utils/AapiUtils.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/geolocation.dart';
import '../../../utils/hiveConstant.dart';
import '../userTrackScreen.dart';
import 'attendenceRow.dart';
import 'card.dart';
import 'constants.dart';
import 'doughnatChart.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final geoLocation = getIt<GeoLocationData>();
  var useCaseForAttendanceImpl = getIt<UseCaseForAttendenceImpl>();
  var salesData = getIt<UseCaseForSalesDataImpl>();

  AttendanceDashboard attendanceDashboard = AttendanceDashboard(
    0.0,
    12.0,
    18.0,
  );

  bool loading = false;
  DateTime todayDateTime = DateTime.now();

  int? totalOutletsCount, newOutletsCount, visitedOutletCount, totalSalesCount;
  List<int?> todayTargets = [0, 0, 0, 0];

  String distanceTraveled = "0 km";
  String userName = "";
  bool? checkNotice;

  noticeCheck() {
    setState(() {
      checkNotice = checkNotice;
    });
  }

  getUserName() async {
    final signInLocalDataSource = getIt<SignInLocalDataSource>();
    await signInLocalDataSource
        .getUserDataFromLocal()
        .then((value) => setState(() {
              if (value != null && value.full_name != null) {
                userName = value.full_name!;
              }
            }));
  }

  getTodayTargetData() async {
    TodayTarget todayTarget = TodayTarget();
    List<dynamic> salesData = [];
    salesData = await todayTarget.getSalesData();
    totalSalesCount = salesData.length;
    newOutletsCount = await todayTarget.getNewOutlets();
    totalOutletsCount = await todayTarget.getTotalOutlets();
    visitedOutletCount = await todayTarget.getTotalOutletsVisitedToday();

    if (mounted) {
      setState(() {
        todayTargets[0] = totalOutletsCount;
        todayTargets[1] = newOutletsCount;
        todayTargets[2] = visitedOutletCount;
        todayTargets[3] = totalSalesCount;
      });
    }
  }

  getChartData() async {
    var successOrFailed =
        await useCaseForAttendanceImpl.getDashBoardAttendance();
    successOrFailed.fold(
        (l) => {},
        (r) => {
              if (r != null)
                {
                  setState(() {
                    attendanceDashboard = AttendanceDashboard(
                      r.percentile,
                      r.present_days,
                      r.absent_days,
                    );
                  }),
                }
            });
  }

  final int _widgetIndex = 1;
  @override
  void initState() {
    // salesData.saveDeliveredRequest(requestDelivered);
    BlocProvider.of<AttendenceCubit>(context).getCheckInStatus();
    getChartData();
    getTodayTargetData();
    getUserName();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var attendanceCubit = BlocProvider.of<AttendenceCubit>(context);

    return IndexedStack(
      children: [
        Stack(
          children: [
            SingleChildScrollView(
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
                            return const Text("Please checkout when completed",
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
                        InkWell(
                          onTap: () {
                            Navigator.of(context)
                                .pushNamed(Routes.userTrackScreen);
                          },
                          child: Row(
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
                                          style: const TextStyle(fontSize: 12))
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
                                            bool check = await attendanceCubit
                                                .checkOut();

                                            if (!check) {
                                              Navigator.of(context).pushNamed(
                                                  Routes.attendanceRoute);
                                            } else {
                                              Fluttertoast.showToast(
                                                  msg: 'Checkout failed',
                                                  toastLength:
                                                      Toast.LENGTH_SHORT,
                                                  gravity: ToastGravity.BOTTOM,
                                                  backgroundColor:
                                                      AppColors.primaryColor,
                                                  textColor: Colors.white);
                                            }

                                            setState(() {
                                              loading = false;
                                            });
                                          }, loading);
                                        } else {
                                          return attendanceRow("Check In",
                                              () async {
                                            RemoteSourceImplementation
                                                remoteSourceImpl =
                                                RemoteSourceImplementation();
                                            var okay = await remoteSourceImpl
                                                .refreshToken();
                                            print(okay);
                                            // setState(() {
                                            //   loading = true;
                                            // });
                                            // // check internet
                                            // bool result =
                                            //     await InternetConnectionChecker()
                                            //         .hasConnection;
                                            //
                                            // if (result) {
                                            //   bool check = await attendanceCubit
                                            //       .checkIn();
                                            //   if (check) {
                                            //     Navigator.of(context).pushNamed(
                                            //         Routes.attendanceRoute);
                                            //   } else {
                                            //     Fluttertoast.showToast(
                                            //         msg: "failed",
                                            //         toastLength:
                                            //             Toast.LENGTH_SHORT,
                                            //         gravity:
                                            //             ToastGravity.BOTTOM,
                                            //         backgroundColor:
                                            //             AppColors.primaryColor,
                                            //         textColor: Colors.white);
                                            //   }
                                            // } else {
                                            //   Fluttertoast.showToast(
                                            //       msg:
                                            //           'PLease connect to internet',
                                            //       toastLength:
                                            //           Toast.LENGTH_SHORT,
                                            //       gravity: ToastGravity.BOTTOM,
                                            //       backgroundColor:
                                            //           AppColors.primaryColor,
                                            //       textColor: Colors.white);
                                            // }
                                            //
                                            // setState(() {
                                            //   loading = false;
                                            // });
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
                        DoughnutChart(
                          percentile: attendanceDashboard.percentile.toDouble(),
                          presentDays:
                              attendanceDashboard.present_days.toDouble(),
                          absentDays:
                              attendanceDashboard.absent_days.toDouble(),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        const Text("Today Target"),
                        SizedBox(
                            height: 400,
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
                                        Navigator.of(context).pushNamed(
                                            Routes.totalOutletsRoute);
                                        break;
                                      case 1:
                                        Navigator.of(context)
                                            .pushNamed(Routes.newOutletRoute);
                                        break;
                                      case 2:
                                        break;
                                      case 3:
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
            BlocBuilder<PublishNotificationBloc, PublishNotificationState>(
              builder: (context, state) {
                if (state is PublishNotificationLoadedState) {
                  return Center(
                    child: NoticeListViewWidget(
                        data: state.publishNotificationState,
                        widgetIndex: _widgetIndex),
                  );
                } else {
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
