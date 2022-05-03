import 'package:flutter/material.dart';

import '../widgets/visitedOutletWidget.dart';


class VisitedOutletScreen extends StatelessWidget {
  const VisitedOutletScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const VisitedOutletWidget(
      navTitle : 'VISITED OUTLET',
      imageUrl: 'assets/images/visited_outlet.png',
      bodyTitle : 'No orders founded',
      bodySubTitle : 'Try to visit other Outlets to get results',
      buttonText : 'Go to Home',
    );
  }
}