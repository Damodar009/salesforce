import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salesforce/presentation/blocs/publish_notification/publish_notification_bloc.dart';
import 'package:salesforce/presentation/pages/notice_board_page.dart';
import 'package:salesforce/presentation/widgets/appBarWidget.dart';
import 'package:salesforce/utils/app_colors.dart';

class NoticeBoardTableScreen extends StatefulWidget {
  const NoticeBoardTableScreen({Key? key}) : super(key: key);

  @override
  State<NoticeBoardTableScreen> createState() => _NoticeBoardTableScreenState();
}

class _NoticeBoardTableScreenState extends State<NoticeBoardTableScreen> {
  final List<String>? listOfPublicNotiication = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(navTitle: "Notice", context: context),
      body: BlocBuilder<PublishNotificationBloc, PublishNotificationState>(
        builder: (context, state) {
          if (state is PublishNotificationLoadedState) {
            return ListView.builder(
                shrinkWrap: true,
                itemCount: state.publishNotificationState.length,
                itemBuilder: ((context, index) {
                  if (state.publishNotificationState[index]
                          .notification_status ==
                      true) {
                        print(state.publishNotificationState[index]);
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
                                                state.publishNotificationState[
                                                    index])));
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
                                        Text(state
                                            .publishNotificationState[index]
                                            .notification_status
                                            .toString()),
                                        const Text(
                                          "Title",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        const SizedBox(
                                          width: 20,
                                        ),
                                        Text(state
                                                .publishNotificationState[index]
                                                .title ??
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
                                          state.publishNotificationState[index]
                                                  .created_date ??
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
          } else if (state is PublishNotificationLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return Text("No data Found");
          }
        },
      ),
    );
  }
}
