import 'package:flutter/material.dart';
import 'package:salesforce/presentation/widgets/appBarWidget.dart';
import 'package:salesforce/utils/app_colors.dart';

class NoticeBoardScreen extends StatelessWidget {
  const NoticeBoardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double mediaQueryHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: appBar(
        icon: Icons.arrow_back_ios_new_outlined,
        navTitle: 'NOTICE BOARD',
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Card(
            elevation: 2,
            child: Container(
              decoration: BoxDecoration(
                // color: Colors.grey,
                borderRadius: BorderRadius.circular(15),
              ),
              // height: 520,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image(
                    width: MediaQuery.of(context).size.width,
                    color: AppColors.buttonColor,
                    image: const AssetImage(
                      "assets/images/total_order_complete.png",
                    ),
                  ),
                  SizedBox(
                    height: mediaQueryHeight * 0.01,
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      'INNOVATION',
                    ),
                  ),
                  SizedBox(
                    height: mediaQueryHeight * 0.01,
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      '3 WAYS TO BOOST BEVERAGE BRAND INNOVATION ',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                  ),
                  SizedBox(
                    height: mediaQueryHeight * 0.03,
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s",
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      'READ MORE',
                    ),
                  ),
                  SizedBox(
                    height: mediaQueryHeight * 0.01,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: const [
                        Text(
                          'RC Cola Int Team',
                        ),
                        SizedBox(
                          height: 10,
                          width: 10,
                        ),
                        Text('April 5, 2022'),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}