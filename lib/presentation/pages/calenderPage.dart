import 'package:flutter/material.dart';
import 'package:salesforce/presentation/widgets/appBarWidget.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CalenderScreen extends StatelessWidget {
  const CalenderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: appBar(
      //     // icon: Icons.arrow_back,
      //     navTitle: "Attendence",
      //     //  backNavigate: () {},
      //     context: context),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SfCalendar(
          showDatePickerButton: true,
          headerHeight: 50,
          view: CalendarView.week,
          dataSource: MeetingDataSource(getAppointments()),
        ),
      ),
    );
  }
}

List<Appointment> getAppointments() {
  List<Appointment> meetings = <Appointment>[];
  final DateTime startdate = DateTime.now();
  final DateTime endDate = startdate.add(
    const Duration(hours: 1),
  );
  meetings.add(
    Appointment(
        startTime: startdate,
        endTime: endDate,
        subject: "here and there",
        color: Colors.brown),
  );
  return meetings;
}

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Appointment> source) {
    appointments = source;
  }
}
