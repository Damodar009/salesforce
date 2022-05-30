import 'package:flutter/material.dart';
import 'package:salesforce/data/datasource/remoteSource/salesDataRemoteSource.dart';
import 'package:salesforce/routes.dart';
import '../../utils/app_colors.dart';

class OutletScreen extends StatefulWidget {
  const OutletScreen({Key? key}) : super(key: key);

  @override
  _OutletScreenState createState() => _OutletScreenState();
}

class _OutletScreenState extends State<OutletScreen> {
  // var useCaseForSalesPersonImpl = getIt<UseCaseForSalesPersonImpl>();
  final SalesDataRemoteSourceImpl _salesDataRemoteSourceImpl =
      SalesDataRemoteSourceImpl();

  @override
  void initState() {}

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            const SizedBox(
              height: 75,
            ),
            const Text(
              "Outlets",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            outletsCard(
                "Create new orders",
                "To create new Orders and \n send or save the data ",
                " Add now",
                Routes.newOrderRoute),
            outletsCard(
                "Create new Outlets",
                "To Create New Outlets and \nSave Outlets",
                "Add now",
                Routes.newOutletsRoute),
            outletsCard("Sales Data Collection", "From\n 2022/1/1/ to 2022/1/1",
                "Check In", Routes.salesDataCollection),
          ]),
        )
      ],
    );
  }

  Widget outletsCard(
      String title, String subtitle, String text, String navigateTo) {
    return outletsCardOutline(
      Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Text(title,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Text(subtitle, style: const TextStyle(fontSize: 12)),
                ),
                const SizedBox(
                  height: 10,
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).pushNamed(navigateTo);
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 15),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30)),
                    child: Text(
                      text,
                      style: const TextStyle(
                          fontSize: 13, color: AppColors.textColor),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              height: 70,
              width: 70,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(40)),
            )
          ],
        ),
      ),
    );
  }

  Widget outletsCardOutline(Widget widget) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
          decoration: BoxDecoration(
              color: const Color(0xffB5E8FC),
              borderRadius: BorderRadius.circular(15)),
          child: widget),
    );
  }
}
