import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:royal_orchid_hotel/core/commen/widget/monthly_status_widget.dart';
import 'package:royal_orchid_hotel/core/entites/user.dart';
import 'package:royal_orchid_hotel/features/admin/presentation/bloc/user/user_bloc.dart';

import '../../../../../core/commen/widget/accepted_requests_pie_chart.dart';
import '../../../../../core/commen/widget/answered_requests_pie_chart.dart';
import '../../../../../core/theme/app_pallete.dart';
import '../../../../../core/utils/show_snack_bar.dart';
import '../../../../../core/widget/loader.dart';
import '../../../../../int_dep.dart';

class StaffDetailsPage extends StatefulWidget {
  static route(User user) => MaterialPageRoute(builder: (context) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (_) => serviceLocator<UserBloc>()),
          ],
          child: StaffDetailsPage(
            user: user,
          ),
        );
      });
  final User user;

  const StaffDetailsPage({super.key, required this.user});

  @override
  State<StaffDetailsPage> createState() => _StaffDetailsPageState();
}

class _StaffDetailsPageState extends State<StaffDetailsPage> {
  @override
  void initState() {
    context.read<UserBloc>().add(GetStatusEvent(widget.user.id));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(20.0),
                    bottomRight: Radius.circular(20.0),
                  ),
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        HSVColor.fromColor(AppPallete.color4)
                            .withValue(0.5)
                            .toColor(),
                        HSVColor.fromColor(AppPallete.color4)
                            .withValue(0.6)
                            .toColor(),
                        HSVColor.fromColor(AppPallete.color4)
                            .withValue(0.7)
                            .toColor(),
                        HSVColor.fromColor(AppPallete.color4)
                            .withValue(0.7)
                            .toColor(),
                      ],
                      stops: const [
                        0.3,
                        0.4,
                        0.5,
                        1.0
                      ])),
              padding: const EdgeInsets.all(30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.user.name,
                        style: GoogleFonts.poppins().copyWith(
                            fontWeight: FontWeight.w900,
                            color: AppPallete.backgroundColor,
                            fontSize: 20),
                      ),
                      Text(
                        widget.user.email,
                        style: GoogleFonts.poppins().copyWith(
                            fontWeight: FontWeight.w400,
                            color: AppPallete.backgroundColor.withOpacity(0.8),
                            fontSize: 14),
                      ),
                      Text(
                        "Role: ${widget.user.role == 1 ? "Admin" : "Staff"} | Sector : ${widget.user.sector}",
                        style: GoogleFonts.poppins().copyWith(
                            fontWeight: FontWeight.w200,
                            fontSize: 14,
                            color: AppPallete.backgroundColor.withOpacity(0.8)),
                      ),
                    ],
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: AppPallete.backgroundColor,
                        borderRadius: BorderRadius.circular(10)),
                    child: const Icon(
                      Icons.person,
                      color: AppPallete.color4,
                      size: 120,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: BlocConsumer<UserBloc, UserState>(
                listener: (context, state) {
                  if (state is UserFail) {
                    ErrorShowSnackBar(context, state.massage);
                  }
                },
                builder: (context, state) {
                  if (state is UserLoading) {
                    return const Loader(color: AppPallete.color4);
                  }
                  if (state is DisplayStatusSuccess) {
                    return Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: ListView(
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height / 80,
                          ),
                          Text(
                            "Requests Status :",
                            style: GoogleFonts.poppins(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w600,
                              color: AppPallete.color5,
                            ),
                          ),
                          SizedBox(
                            height: 30.sp,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Expanded(
                                  child: Column(
                                children: [
                                  AnsweredRequestsPieChart(
                                    totalRequests: state.status.total_requests,
                                    answeredRequests:
                                        state.status.answered_requests,
                                  ),
                                  SizedBox(
                                    height: 30.sp,
                                  ),
                                  Text(
                                    "Answered Requests",
                                    style: GoogleFonts.poppins(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w500,
                                      color: AppPallete.color5,
                                    ),
                                  )
                                ],
                              )),
                              Expanded(
                                  child: Container(
                                      child: Column(
                                children: [
                                  AcceptedRequestsPieChart(
                                      answeredRequests:
                                          state.status.answered_requests,
                                      acceptedRequests:
                                          state.status.accepted_requests,
                                      rejectedRequests:
                                          state.status.rejected_requests),
                                  SizedBox(
                                    height: 30.sp,

                                  ),
                                  Text(
                                    "Accepted Requests",
                                    style: GoogleFonts.poppins(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w500,
                                      color: AppPallete.color5,
                                    ),
                                  )
                                ],
                              ))),
                            ],
                          ),
                          const SizedBox(
                            height: 80,
                          ),
                          Text(
                            "Monthly Status :",
                            style: GoogleFonts.poppins(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w600,
                              color: AppPallete.color5,
                            ),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: AppPallete.color3),
                            height: 200,
                            width: double.infinity,
                            child: MonthlyStatusWidget(state.status.monthlyStatus!),
                          )
                        ],
                      ),
                    );
                  }
                  return const SizedBox();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
