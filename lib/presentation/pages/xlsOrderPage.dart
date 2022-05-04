import 'package:flutter/material.dart';
import 'package:salesforce/presentation/widgets/appBarWidget.dart';

class XlsOrderScreen extends StatelessWidget {
  const XlsOrderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(
          icon: Icons.arrow_back, navTitle: "order", backNavigate: () {}),
          body: Column(
            children: [
              
            ],
          ),
    );
  }
}
