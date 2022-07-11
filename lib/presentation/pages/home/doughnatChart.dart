import 'package:flutter/material.dart';
import 'package:salesforce/domain/entities/AttendendenceDashbard.dart';
import 'package:salesforce/utils/app_colors.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class DoughnutChart extends StatefulWidget {
  final double percentile;
  final double presentDays;
  final double absentDays;
  DoughnutChart(
      {required this.percentile,
      required this.presentDays,
      required this.absentDays})
      : super();

  @override
  _DoughnutChartState createState() => _DoughnutChartState();
}

class _DoughnutChartState extends State<DoughnutChart> {
  late List<GDPdata> _chartDAta;

  AttendanceDashboard? attendanceDashboard;

  @override
  void initState() {
    _chartDAta = [
      GDPdata("sura", widget.absentDays.toInt(), AppColors.buttonColor),
      GDPdata("prince", widget.presentDays.toInt(), AppColors.primaryColor),
    ];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SfCircularChart(
          annotations: <CircularChartAnnotation>[
            CircularChartAnnotation(
                widget: Text(
              "${(widget.percentile.toStringAsFixed(2))}\n Attendance",
              // "${widget.percentile} \n Attendance",
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.black, fontSize: 20),
            ))
          ],
          // legend:
          //     Legend(isVisible: true, overflowMode: LegendItemOverflowMode.wrap),
          series: <CircularSeries>[
            DoughnutSeries<GDPdata, String>(
                innerRadius: "70%",
                dataSource: _chartDAta,
                pointColorMapper: (GDPdata data, _) => data.color,
                xValueMapper: (GDPdata data, _) => data.continent,
                yValueMapper: (GDPdata data, _) => data.gdp,
                radius: "90%"),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            indicator("Present", true),
            const SizedBox(
              width: 17,
            ),
            indicator("Absent", false),
          ],
        )
      ],
    );
  }

  Widget indicator(String title, isPresence) {
    return Row(
      children: [
        Container(
          height: 20,
          width: 20,
          decoration: BoxDecoration(
              color:
                  isPresence ? AppColors.buttonColor : AppColors.primaryColor,
              borderRadius: BorderRadius.circular(2.5)),
        ),
        const SizedBox(
          width: 5,
        ),
        Text(
          title,
          style: const TextStyle(fontSize: 18),
        )
      ],
    );
  }
}

class GDPdata {
  final String continent;
  final int gdp;
  final Color? color;
  GDPdata(this.continent, this.gdp, this.color);
}
