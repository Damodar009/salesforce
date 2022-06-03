// import 'dart:ui';

// import 'package:flutter/material.dart';
// import 'package:salesforce/domain/entities/publish_notification.dart';
// import 'package:salesforce/presentation/pages/notice_board_page.dart';

// class NoticeListViewWidget extends StatefulWidget {
//   NoticeListViewWidget({Key? key, required this.data}) : super(key: key);

//   List<PublishNotification> data;

//   @override
//   State<NoticeListViewWidget> createState() => _NoticeListViewWidgetState();
// }

// class _NoticeListViewWidgetState extends State<NoticeListViewWidget> {
//   @override
//   Widget build(BuildContext context) {
//     return BackdropFilter(
//       filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
//       child: ListView.builder(
//           scrollDirection: Axis.horizontal,
//           shrinkWrap: true,
//           itemCount: widget.data.length,
//           itemBuilder: (BuildContext context, int index) {
//             return Visibility(
//               visible: widget.data[index].notification_status!,
//               child: Stack(
//                 children: [
//                   Container(
//                     width: MediaQuery.of(context).size.width - 10,
//                     child: Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 20),
//                       child: Center(
//                         child: Container(
//                           height: MediaQuery.of(context).size.height * 0.6,
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(10),
//                             color: Colors.blue[900],
//                           ),
//                           child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.center,
//                               children: [
//                                 const SizedBox(
//                                   height: 10,
//                                 ),
//                                 Padding(
//                                   padding: const EdgeInsets.symmetric(
//                                       vertical: 10, horizontal: 10),
//                                   child: Container(
//                                     height: MediaQuery.of(context).size.height *
//                                         0.2,
//                                     width: MediaQuery.of(context).size.width,
//                                     decoration: BoxDecoration(
//                                         borderRadius: BorderRadius.circular(12),
//                                         image: DecorationImage(
//                                             image: widget.data[index].path !=
//                                                     null
//                                                 ? NetworkImage(
//                                                     widget.data[index].path!)
//                                                 : const AssetImage(
//                                                         'assets/images/total_order_complete.png')
//                                                     as ImageProvider,
//                                             fit: BoxFit.cover)),
//                                   ),
//                                 ),
//                                 const SizedBox(
//                                   height: 10,
//                                 ),
//                                 Padding(
//                                   padding: const EdgeInsets.symmetric(
//                                       horizontal: 40),
//                                   child: Container(
//                                     width: MediaQuery.of(context).size.width,
//                                     decoration: BoxDecoration(
//                                         border: Border.all(
//                                             width: 1,
//                                             color: const Color.fromARGB(
//                                                 255, 74, 92, 148)),
//                                         borderRadius: BorderRadius.circular(15),
//                                         color: const Color.fromARGB(
//                                             255, 74, 92, 148)),
//                                     child: const Padding(
//                                         padding: EdgeInsets.symmetric(
//                                             horizontal: 18, vertical: 15),
//                                         child: Center(
//                                           child: Text(
//                                             'Notice',
//                                             style: TextStyle(
//                                                 color: Colors.white,
//                                                 fontSize: 20),
//                                           ),
//                                         )),
//                                   ),
//                                 ),
//                                 const SizedBox(
//                                   height: 10,
//                                 ),
//                                 Padding(
//                                   padding: const EdgeInsets.symmetric(
//                                       horizontal: 40),
//                                   child: Container(
//                                     width: MediaQuery.of(context).size.width,
//                                     decoration: BoxDecoration(
//                                         border: Border.all(
//                                             width: 1,
//                                             color: const Color.fromARGB(
//                                                 255, 74, 92, 148)),
//                                         borderRadius: BorderRadius.circular(12),
//                                         color: const Color.fromARGB(
//                                             255, 74, 92, 148)),
//                                     child: Padding(
//                                       padding: const EdgeInsets.symmetric(
//                                           horizontal: 7, vertical: 10),
//                                       child: Center(
//                                         child: Text(
//                                           widget.data[index].title ?? "",
//                                           style: const TextStyle(
//                                               color: Colors.white,
//                                               decoration:
//                                                   TextDecoration.underline),
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                                 const SizedBox(
//                                   height: 30,
//                                 ),
//                                 Padding(
//                                   padding: const EdgeInsets.symmetric(
//                                       horizontal: 40),
//                                   child: Container(
//                                     width: MediaQuery.of(context).size.width,
//                                     decoration: BoxDecoration(
//                                         border: Border.all(
//                                             width: 1,
//                                             color: const Color.fromARGB(
//                                                 255, 142, 124, 34)),
//                                         borderRadius: BorderRadius.circular(15),
//                                         color: const Color.fromARGB(
//                                             255, 142, 124, 34)),
//                                     child: Padding(
//                                         padding: const EdgeInsets.symmetric(
//                                             horizontal: 18, vertical: 5),
//                                         child: Text(
//                                           widget.data[index].body ?? "",
//                                           overflow: TextOverflow.ellipsis,
//                                           maxLines: 1,
//                                           style: const TextStyle(
//                                               color: Colors.white),
//                                         )),
//                                   ),
//                                 ),
//                                 const SizedBox(
//                                   height: 5,
//                                 ),
//                                 const SizedBox(
//                                   height: 20,
//                                 ),
//                                 InkWell(
//                                   onTap: () {
//                                     Navigator.push(
//                                         context,
//                                         MaterialPageRoute(
//                                             builder: (BuildContext context) =>
//                                                 NoticeBoardScreen(
//                                                   publishNotificationlist:
//                                                       widget.data[index],
//                                                 )));
//                                   },
//                                   child: Container(
//                                     height: 50,
//                                     width: 100,
//                                     decoration: BoxDecoration(
//                                         border: Border.all(
//                                             width: 1,
//                                             color: const Color.fromARGB(
//                                                 255, 10, 3, 59)),
//                                         borderRadius: BorderRadius.circular(15),
//                                         color: const Color.fromARGB(
//                                             255, 10, 3, 59)),
//                                     child: const Padding(
//                                         padding: EdgeInsets.symmetric(
//                                             horizontal: 18, vertical: 10),
//                                         child: Center(
//                                             child: Text(
//                                           'View all',
//                                           style: TextStyle(color: Colors.white),
//                                         ))),
//                                   ),
//                                 ),
//                                 // const SizedBox(
//                                 //   height: 20,
//                                 // ),
//                                 // Row(
//                                 //   mainAxisAlignment: MainAxisAlignment.center,
//                                 //   children: [
//                                 //     Container(
//                                 //       height: 5,
//                                 //       width: 70,
//                                 //       decoration: BoxDecoration(
//                                 //         borderRadius: BorderRadius.circular(10),
//                                 //         color: Colors.white,
//                                 //       ),
//                                 //     ),
//                                 //     const SizedBox(
//                                 //       width: 40,
//                                 //     ),
//                                 //     Container(
//                                 //       height: 5,
//                                 //       width: 70,
//                                 //       decoration: BoxDecoration(
//                                 //         borderRadius: BorderRadius.circular(10),
//                                 //         color: Colors.white,
//                                 //       ),
//                                 //     ),
//                                 //   ],
//                                 // )
//                               ]),
//                         ),
//                       ),
//                     ),
//                   ),
//                   Positioned(
//                     top: 115,
//                     right: 30,
//                     // bottom: 0,
//                     child: Container(
//                       color: Colors.black,
//                       child: const InkWell(
//                         // onTap: noticeCheck,
//                         child: Icon(
//                           Icons.close,
//                           size: 40,
//                           color: Colors.white,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             );
//           }),
//     );
//   }
// }
