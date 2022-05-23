import 'package:flutter/material.dart';
import 'package:salesforce/routes.dart';
import '../../utils/app_colors.dart';
import '../widgets/appBarWidget.dart';
import '../widgets/buttonWidget.dart';

class VistedOutlets {
  final IconData? icon;
  final String? navTitle;
  final String? settingTitle;
  final IconData? settingIcon;
  final String? imageUrl;
  final String? bodyTitle;
  final String? bodySubTitle;
  final String? buttonText;

  VistedOutlets(
      {this.icon,
      this.navTitle,
      this.settingTitle,
      this.settingIcon,
      this.imageUrl,
      this.bodyTitle,
      this.bodySubTitle,
      this.buttonText});
}

class VisitedOutletWidget extends StatelessWidget {
  final VistedOutlets visitedOutlets;

  const VisitedOutletWidget({Key? key, required this.visitedOutlets})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double mediaQuery = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: appBar(
          navTitle: visitedOutlets.navTitle ?? "",
          context: context
          // icon: Icons.arrow_back,
          // backNavigate: () {
          //   Navigator.pop(context);
          // },
          ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            SizedBox(
              height: mediaQuery * 0.11,
            ),
            Container(
              height: MediaQuery.of(context).size.height / 3,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.contain,
                  image: AssetImage(visitedOutlets.imageUrl!),
                ),
              ),
            ),
            SizedBox(
              height: mediaQuery * 0.05,
            ),
            Text(
              visitedOutlets.bodyTitle ?? "",
              style: Theme.of(context)
                  .textTheme
                  .bodyText2!
                  .copyWith(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            SizedBox(
              height: mediaQuery * 0.01,
            ),
            Text(
              visitedOutlets.bodySubTitle ?? "",
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .bodyText2!
                  .copyWith(color: Colors.grey),
            ),
            SizedBox(
              height: mediaQuery * 0.1,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: button(visitedOutlets.buttonText ?? "Go to Home", () {
                Navigator.of(context).pushNamedAndRemoveUntil(
                    Routes.dashboardRoute, (route) => false);
              }, false, AppColors.buttonColor),
            )
          ],
        ),
      ),
    );
  }
}
