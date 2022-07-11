import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../domain/entities/report.dart';

class ReportPage extends StatefulWidget {
  const ReportPage({Key? key}) : super(key: key);

  @override
  State<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  List<Report> reports = [];
  getChartData() {
    reports = [];
    return reports;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SfCartesianChart(
        enableAxisAnimation: true,
        zoomPanBehavior: ZoomPanBehavior(
            // Enables pinch zooming
            enablePinching: true),
        tooltipBehavior: TooltipBehavior(enable: true),
        title: ChartTitle(text: "Monthly Report"),
        primaryXAxis: CategoryAxis(
          edgeLabelPlacement: EdgeLabelPlacement.shift,
          interval: 4,
          visibleMinimum: 5,
          visibleMaximum: 10,
          title: AxisTitle(
            text: "Day",
          ),
        ),
        //primaryYAxis: NumericAxis(title: AxisTitle(text: "Quantity")),
        series: <ChartSeries>[
          ColumnSeries<Report, String>(
            dataSource: getChartData(),
            xValueMapper: (Report report, _) => report.date,
            yValueMapper: (Report report, _) => report.quantity,
            dataLabelSettings: const DataLabelSettings(
              isVisible: true,
            ),
          ),
        ],
      ),
    );
  }
}
