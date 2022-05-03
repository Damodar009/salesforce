import 'package:flutter/material.dart';
import '../widgets/visitedOutletWidget.dart';

class TotalOrderCompletedPage extends StatelessWidget {
  const TotalOrderCompletedPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const VisitedOutletWidget(
      navTitle: 'TOTAL',
      imageUrl: 'assets/images/total_order_complete.png',
      bodyTitle: 'Order Confirmed!',
      bodySubTitle:
          'Your order has been confirmed, Order will send to distributor.',
      buttonText: 'Go to Home',
    );
  }
}
