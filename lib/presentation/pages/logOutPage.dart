import 'package:flutter/material.dart';

import '../../utils/app_colors.dart';
import '../widgets/buttonWidget.dart';

class LogOutPage extends StatelessWidget {
  const LogOutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double mediaQuery = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height / 2,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.contain,
                    image: AssetImage('assets/images/logging_off.png'),
                  ),
                ),
              ),
              SizedBox(
                height: mediaQuery * 0.1,
              ),
              Text(
                "Logging off",
                style: Theme.of(context)
                    .textTheme
                    .bodyText2!
                    .copyWith(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              SizedBox(
                height: mediaQuery * 0.01,
              ),
              Text(
                "Are you sure you want to Log Out",
                style: Theme.of(context)
                    .textTheme
                    .bodyText2!
                    .copyWith(color: Colors.grey),
              ),
              SizedBox(
                height: mediaQuery * 0.09,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: button("Cancel", () {
                  Navigator.pop(context);
                }, false, AppColors.buttonColor),
              ),
              SizedBox(
                height: mediaQuery * 0.01,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: button("Log off", () {}, false, AppColors.primaryColor),
              )
            ],
          ),
        ],
      ),
    );
  }
}
