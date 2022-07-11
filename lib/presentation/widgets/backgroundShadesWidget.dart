import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';

class BackgroundShades extends StatefulWidget {
  const BackgroundShades({Key? key}) : super(key: key);

  @override
  _BackgroundShadesState createState() => _BackgroundShadesState();
}

class _BackgroundShadesState extends State<BackgroundShades> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
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
        ],
      ),
    );
  }
}
