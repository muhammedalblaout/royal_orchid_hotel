import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:royal_orchid_hotel/core/theme/app_pallete.dart';

class AcceptedRequestsPieChart extends StatefulWidget {
  final int acceptedRequests;
  final int rejectedRequests;
  final int answeredRequests;

  const AcceptedRequestsPieChart(
      {super.key, required this.acceptedRequests, required this.answeredRequests, required this.rejectedRequests});

  @override
  State<StatefulWidget> createState() =>
      AcceptedRequestsPieChartState(
          acceptedRequests, rejectedRequests, answeredRequests);
}

class AcceptedRequestsPieChartState extends State {
  int acceptedRequests;
  int rejectedRequests;
  int answeredRequests;

  AcceptedRequestsPieChartState(this.acceptedRequests, this.rejectedRequests,
      this.answeredRequests);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: MediaQuery
            .of(context)
            .size
            .width,
        height: 100,
        child: PieChart(PieChartData(
            borderData: FlBorderData(
              show: false,
            ),
            sectionsSpace: 5,
            centerSpaceRadius: 25,
            sections: showingSections())));
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(2, (i) {
      final fontSize = 15.sp;
      final radius = 30.sp;
      const shadows = [Shadow(color: Colors.black, blurRadius: 1)];

      switch (i) {
        case 0:
          return PieChartSectionData(
            color: AppPallete.accept,
            value: (acceptedRequests / answeredRequests) * 100,
            title: "% ${((acceptedRequests / answeredRequests) * 100).toInt()}",

            radius: radius,
            titleStyle: GoogleFonts.poppins(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: AppPallete.backgroundColor,
                shadows: shadows
            ),
          );
        case 1:
          return PieChartSectionData(
            color: AppPallete.reject,
            value: (rejectedRequests / answeredRequests) * 100,
            title: "",
            radius: radius,
            titleStyle: GoogleFonts.poppins(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: AppPallete.backgroundColor,
                shadows: shadows

            ),
          );


        default:
          throw Error();
      }
    });
  }
}
