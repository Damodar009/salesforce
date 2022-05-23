import 'package:flutter/material.dart';
import 'package:salesforce/utils/app_colors.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class DoughnutChart extends StatefulWidget {
  const DoughnutChart({Key? key}) : super(key: key);

  @override
  _DoughnutChartState createState() => _DoughnutChartState();
}

class _DoughnutChartState extends State<DoughnutChart> {
  late List<GDPdata> _chartDAta;

  @override
  void initState() {
    _chartDAta = getChartData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SfCircularChart(
          annotations: <CircularChartAnnotation>[
            CircularChartAnnotation(
                widget: Container(
              child: PhysicalModel(
                color: const Color.fromRGBO(230, 20, 230, 1),
                child: Container(),
                shape: BoxShape.circle,
                elevation: 1,
                shadowColor: Colors.black,
              ),
            )),
            CircularChartAnnotation(
                widget: const Text(
              "71% \n attendence",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black, fontSize: 20),
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
            indicater("Present", true),
            const SizedBox(
              width: 17,
            ),
            indicater("Absence", false),
          ],
        )
      ],
    );
  }

  Widget indicater(String title, isPresence) {
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

  List<GDPdata> getChartData() {
    final List<GDPdata> chartdata = [
      GDPdata("sura", 12, AppColors.buttonColor),
      GDPdata("prince", 18, AppColors.primaryColor),
    ];
    return chartdata;
  }
}

class GDPdata {
  final String continent;
  final int gdp;
  final Color? color;
  GDPdata(this.continent, this.gdp, this.color);
}
