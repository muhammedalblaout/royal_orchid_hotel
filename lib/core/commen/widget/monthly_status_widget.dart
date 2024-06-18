import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:royal_orchid_hotel/core/theme/app_pallete.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../entites/staff_status.dart';

Widget MonthlyStatusWidget(List<MonthlyStatus> list) {
  return Container(
      child: SfCartesianChart(
          plotAreaBorderWidth: 0,
          primaryXAxis: CategoryAxis(
            majorGridLines: const MajorGridLines(width: 0),
            labelStyle: GoogleFonts.poppins()
                .copyWith(fontSize: 8, color: AppPallete.backgroundColor),
            axisLine: const AxisLine(width: 0),
          ),
          primaryYAxis: NumericAxis(
            majorGridLines: const MajorGridLines(width: 0),
            labelStyle: GoogleFonts.poppins()
                .copyWith(fontSize: 8, color: AppPallete.backgroundColor),
            axisLine: const AxisLine(width: 0),
          ),
          legend: const Legend(isVisible: false),
          tooltipBehavior: TooltipBehavior(enable: true),
          series: <SplineSeries<MonthlyStatus, String>>[
        SplineSeries<MonthlyStatus, String>(
          width: 4,
            dataLabelSettings:DataLabelSettings(isVisible: true,textStyle: GoogleFonts.poppins().copyWith(fontSize: 10,color: AppPallete.backgroundColor)),
            dataSource: list,
            xValueMapper: (MonthlyStatus monthlyStatus, _) =>
                monthlyStatus.month,
            yValueMapper: (MonthlyStatus monthlyStatus, _) =>
                monthlyStatus.count,
            pointColorMapper: (MonthlyStatus monthlyStatus, _) =>
                AppPallete.color4,)
      ]));
}
