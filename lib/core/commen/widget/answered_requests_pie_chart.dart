
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:royal_orchid_hotel/core/theme/app_pallete.dart';

class AnsweredRequestsPieChart extends StatefulWidget {
  final int totalRequests;
  final int answeredRequests;

  const AnsweredRequestsPieChart({super.key, required this.totalRequests, required this.answeredRequests});

  @override
  State<StatefulWidget> createState() => AnsweredRequestsPieChartState(totalRequests, answeredRequests);
}

class AnsweredRequestsPieChartState extends State {
  int totalRequests;
  int answeredRequests;

  AnsweredRequestsPieChartState(this.totalRequests, this.answeredRequests);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: MediaQuery.of(context).size.width ,
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
      final fontSize =  15.sp;
      final radius = 30.sp;
      const shadows = [Shadow(color: Colors.black, blurRadius: 1)];

      switch (i) {
        case 0:
          return PieChartSectionData(
            color: AppPallete.color4,
            value: (answeredRequests/totalRequests)*100,
            title:"% ${((answeredRequests/totalRequests)*100).toInt()}" ,

            radius: radius,
            titleStyle: GoogleFonts.poppins(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: AppPallete.backgroundColor,
              shadows:shadows
            ),
          );
        case 1:
          return PieChartSectionData(
            color: AppPallete.color3,
            value: 100-(answeredRequests/totalRequests)*100,
            title:"" ,
            radius: radius,
            titleStyle: GoogleFonts.poppins(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: AppPallete.backgroundColor,
                shadows:shadows

            ),
          );

        default:
          throw Error();
      }
    });
  }
}
