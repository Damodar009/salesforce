import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';
import '../widgets/appBarWidget.dart';
import '../widgets/buttonWidget.dart';

class VisitedOutletWidget extends StatelessWidget {
  final IconData? icon;
  final String? navTitle;
  final String? settingTitle;
  final IconData? settingIcon;
  final String? imageUrl;
  final String? bodyTitle;
  final String? bodySubTitle;
  final String? buttonText;

  const VisitedOutletWidget(
      {Key? key,
      this.icon,
      this.settingIcon,
      this.settingTitle,
      this.navTitle,
      this.imageUrl,
      this.bodyTitle,
      this.bodySubTitle,
      this.buttonText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double mediaQuery = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: appBar(
          navTitle: navTitle ?? "",
          icon: Icons.arrow_back,
          
          backNavigate: () {
            Navigator.pop(context);
          }),
      body: Column(
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
                image: AssetImage(imageUrl!),
              ),
            ),
          ),
          SizedBox(
            height: mediaQuery * 0.05,
          ),
          Text(
            bodyTitle ?? "",
            style: Theme.of(context)
                .textTheme
                .bodyText2!
                .copyWith(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          SizedBox(
            height: mediaQuery * 0.01,
          ),
          Text(
            bodySubTitle ?? "",
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
            child: button(buttonText ?? "Go to Home", () {}, false,
                AppColors.buttonColor),
          )
        ],
      ),
    );
  }
}
