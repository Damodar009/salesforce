import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:salesforce/domain/entities/publish_notification.dart';
import 'package:salesforce/domain/usecases/hiveUseCases/hiveUseCases.dart';
import 'package:salesforce/injectable.dart';
import 'package:salesforce/presentation/pages/notice_board_page.dart';
import 'package:salesforce/presentation/widgets/appBarWidget.dart';
import 'package:salesforce/utils/app_colors.dart';
import 'package:salesforce/utils/hiveConstant.dart';

class NoticeBoardTableScreen extends StatefulWidget {
  NoticeBoardTableScreen({Key? key}) : super(key: key);

  @override
  State<NoticeBoardTableScreen> createState() => _NoticeBoardTableScreenState();
}

class _NoticeBoardTableScreenState extends State<NoticeBoardTableScreen> {
  var useCaseForHiveImpl = getIt<UseCaseForHiveImpl>();
  final List<String>? listOfPublicNotiication = [];

  List<PublishNotification>? noticeList;
  Future getHiveValue() async {
    Box box = await Hive.openBox(HiveConstants.publishNotice);
    print("hive opening the box of publish notice");

    var successOrFailed = useCaseForHiveImpl.getPublishNoticeFromHive(
        box, HiveConstants.publishNotice);

    print(successOrFailed);

    return successOrFailed.fold(
        (l) => {print("failed")},
        ((r) => {
              print(r),
              print("what is this heepno heeenoi"),

              noticeList = r,

              print(noticeList)
              // r.length

              // emit(PublishNotificationLoadedState(
              //     publishNotificationState: r))
            }));
  }

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBar(navTitle: "Notices", context: context),
        body: FutureBuilder(
          future: getHiveValue(),
          builder: ((context, snapshot) {
            if (noticeList != null) {
              return ListView.builder(
                  shrinkWrap: true,
                  itemCount: noticeList!.length,
                  itemBuilder: ((context, index) {
                    if (noticeList![index].notification_status == true) {
                      print(noticeList![index]);
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 20),
                        child: InkWell(
                            onTap: (() {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          NoticeBoardScreen(
                                              publishNotificationlist:
                                                  noticeList![index])));
                            }),
                            child: Container(
                                decoration: const BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(18.0)),
                                  color: AppColors.checkIn,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          // Text(noticeList![index]
                                          //     .notification_status
                                          //     .toString()),
                                          const Text(
                                            "Title",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          const SizedBox(
                                            width: 20,
                                          ),
                                          Text(noticeList![index].title ??
                                              "hello")
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        children: [
                                          const Text(
                                            "Date: ",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            noticeList![index].created_date ??
                                                "",
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ))),
                      );
                    } else {
                      return SizedBox();
                    }
                  }));
            }
            // else if (state is PublishNotificationLoadingState) {
            //   return const Center(
            //     child: CircularProgressIndicator(),
            //   );
            // }
            else if (snapshot.hasError) {
              print("soorrry man");
              return Center(child: Text("Error!!"));
            } else {
              return Center(
                child: Text("No data Found"),
              );
            }
          }),
        )
        // body: BlocBuilder<PublishNotificationBloc, PublishNotificationState>(
        //   builder: (context, state) {
        // print(noticeList != null ? 1000000 : 5000000);

        //   },
        // ),
        );
  }
}
