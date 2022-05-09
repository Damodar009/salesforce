import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:salesforce/routes.dart';
import '../../../utils/app_colors.dart';
import 'card.dart';
import 'doughnatChart.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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

  String distanceTraveled = "12 km";
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraint) {
      return ConstrainedBox(
        constraints: BoxConstraints(minHeight: constraint.maxHeight),

        // height: MediaQuery.of(context).size.height + 375,
        // width: MediaQuery.of(context).size.width,

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
                  const Text("Hello Frank!",
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryColor)),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                      "Please check in to entry your attendence \n for today",
                      style: TextStyle(
                        fontSize: 18,
                      )),
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
                          const Text("Walked Today \nFeild name",
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: const [
                                Text("ATTENDENCE"),
                                SizedBox(
                                  height: 5,
                                ),
                                Text("Today,Thus 28 \n 2022/01/01",
                                    style: TextStyle(fontSize: 12))
                              ],
                            ),
                            Row(
                              children: [
                                const Text(
                                  "Check in",
                                  style: TextStyle(fontSize: 18),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                InkWell(
                                  onTap: () {
                                    Routes.attendanceRoute;
                                    Navigator.of(context)
                                        .pushNamed(Routes.attendanceRoute);
                                  },
                                  child: Container(
                                    height: 40,
                                    width: 40,
                                    decoration: BoxDecoration(
                                        color: const Color(0xffF29F05),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: const Icon(
                                      Icons.arrow_forward,
                                      size: 20,
                                    ),
                                  ),
                                ),
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
                  const Text("TOTAL ATTENDENCE"),
                  const DoughnutChart(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(13),
                            decoration: BoxDecoration(
                                color: AppColors.buttonColor,
                                borderRadius: BorderRadius.circular(8)),
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          const Text(
                            'Present',
                          ),
                        ],
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(13),
                            decoration: BoxDecoration(
                                color: AppColors.primaryColor,
                                borderRadius: BorderRadius.circular(8)),
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          const Text(
                            'Absent',
                          ),
                        ],
                      ),
                    ],
                  ),
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
                      crossAxisCount: 2,
                      childAspectRatio: 1.1,
                      crossAxisSpacing: 2,
                      mainAxisSpacing: 15,
                    ),
                    itemBuilder: (_, index) => InkWell(
                        onTap: () {
                          switch (index) {
                            case 0:
                              Navigator.of(context)
                                  .pushNamed(Routes.totalOutletsRoute);
                              break;
                            case 1:
                              Navigator.of(context)
                                  .pushNamed(Routes.newOutletRoute);
                              break;
                            case 2:
                              Navigator.of(context)
                                  .pushNamed(Routes.totalOutLetsVisitedRoute);
                              break;
                            case 3:
                              Navigator.of(context)
                                  .pushNamed(Routes.totalSalesRoute);
                              break;
                            default:
                          }
                        },
                        child: card(icons[index], title[index], 34, context)),
                    itemCount: 4,
                  )),
                ],
              ),
            )
          ],
        ),
      );
    });
  }
}
