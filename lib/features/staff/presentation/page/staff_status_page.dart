import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:royal_orchid_hotel/core/theme/app_pallete.dart';
import 'package:royal_orchid_hotel/core/utils/show_snack_bar.dart';
import 'package:royal_orchid_hotel/core/widget/loader.dart';

import '../../../../core/commen/cubit/app_user/app_user_cubit.dart';
import '../../../../core/commen/cubit/app_user/app_user_state.dart';
import '../../../../core/commen/widget/answered_requests_pie_chart.dart';
import '../../../../int_dep.dart';
import '../bloc/staff_request/staff_request_bloc.dart';
import '../../../../core/commen/widget/accepted_requests_pie_chart.dart';
import '../../../../core/commen/widget/monthly_status_widget.dart';

class StaffStatusPage2 extends StatefulWidget {
  static route() =>
      MaterialPageRoute(builder: (context) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (_) => serviceLocator<StaffRequestBloc>()),
          ],
          child: const StaffStatusPage2(),
        );
      });

  const StaffStatusPage2({super.key});

  @override
  State<StaffStatusPage2> createState() => _StaffStatusPage2State();
}

class _StaffStatusPage2State extends State<StaffStatusPage2> {
  @override
  void initState() {
    var user = (context
        .read<AppUserCubit>()
        .state as AppStaffLoggin).user;

    context.read<StaffRequestBloc>().add(GetStaffStatusEvent(user.id));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<StaffRequestBloc, StaffRequestState>(
          listener: (context, state) {
            if (state is StaffRequestFail) {
              ErrorShowSnackBar(context, state.massage);
            }
          },
          builder: (context, state) {
            if (state is StaffRequestLoading) {
              return const Loader(color: AppPallete.color4);
            }
            if (state is StaffStatusSuccess) {
              print(state.staffStatus.monthlyStatus?[0].month);
              return Padding(
                padding: const EdgeInsets.all(24.0),
                child: ListView(
                  children: [
                    SizedBox(
                      height: MediaQuery
                          .of(context)
                          .size
                          .height / 80,
                    ),
                    Text(
                      "Requests Status :",
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: AppPallete.color5,
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery
                          .of(context)
                          .size
                          .height / 15,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                            child: Container(
                                child: Column(
                                  children: [
                                    AnsweredRequestsPieChart(
                                      totalRequests: state.staffStatus
                                          .total_requests,
                                      answeredRequests:
                                      state.staffStatus.answered_requests,
                                    ),
                                    SizedBox(
                                      height: MediaQuery
                                          .of(context)
                                          .size
                                          .height / 20.2,
                                    ),
                                    Text(
                                      "Answered Requests",
                                      style: GoogleFonts.poppins(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        color: AppPallete.color5,
                                      ),
                                    )
                                  ],
                                ))),
                        Expanded(
                            child: Container(
                                child: Column(
                                  children: [
                                    AcceptedRequestsPieChart(
                                        answeredRequests:
                                        state.staffStatus.answered_requests,
                                        acceptedRequests:
                                        state.staffStatus.accepted_requests,
                                        rejectedRequests:
                                        state.staffStatus.rejected_requests),
                                    SizedBox(
                                      height: MediaQuery
                                          .of(context)
                                          .size
                                          .height / 20.2,
                                    ),
                                    Text(
                                      "Accepted Requests",
                                      style: GoogleFonts.poppins(
                                        fontSize: 12,
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
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: AppPallete.color5,
                      ),
                    ),
                    const SizedBox(height: 16,),
                    Container(
                      padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10), color:AppPallete.color3),

                        height: 200,
                        width: double.infinity,
                        child: MonthlyStatusWidget(state.staffStatus.monthlyStatus!))
                  ],
                ),
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}
