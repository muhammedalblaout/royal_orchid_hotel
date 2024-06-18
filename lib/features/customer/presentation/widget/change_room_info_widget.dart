import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:royal_orchid_hotel/core/utils/format_date.dart';
import 'package:royal_orchid_hotel/core/utils/show_snack_bar.dart';
import 'package:royal_orchid_hotel/core/widget/loader.dart';

import '../../../../core/entites/user.dart';
import '../../../../core/theme/app_pallete.dart';
import '../bloc/request/request_bloc.dart';

class ChangeRoomInfoWidget extends StatefulWidget {
  final User user;

  const ChangeRoomInfoWidget({super.key, required this.user});

  @override
  State<ChangeRoomInfoWidget> createState() => _ChangeRoomInfoWidgetState();
}

class _ChangeRoomInfoWidgetState extends State<ChangeRoomInfoWidget> {
  @override
  void initState() {
    context
        .read<RequestBloc>()
        .add(GetMyChangeRoomRequestEvent(user_id: widget.user.id));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RequestBloc, RequestState>(
      listener: (context, state) {
        if (state is RequestFail) {
          ErrorShowSnackBar(context, state.massage);
        }
      },
      builder: (context, state) {
        if (state is DisplayChangeRoomsSuccess) {
          if (state.request == null) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 64),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: AppPallete.color4,width: 2),
                  borderRadius: BorderRadius.circular(42),
                ),
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.error_outline_sharp,
                        color: AppPallete.color4.withOpacity(0.8),
                        size: 50,
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        "There is no Request",
                        style: GoogleFonts.poppins().copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: AppPallete.color4.withOpacity(0.8)),
                      )
                    ],
                  ),
                ),
              ),
            );
          } else {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 64),
              child: Container(
                width: double.infinity,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  color: AppPallete.backgroundColor,
                  borderRadius: BorderRadius.circular(42),
                  boxShadow: [
                    BoxShadow(
                      color: state.request!.is_accepted == null
                          ? AppPallete.color4.withOpacity(0.8)
                          : state.request!.is_accepted == true
                              ? AppPallete.accept.withOpacity(0.8)
                              : AppPallete.reject.withOpacity(0.8),
                      blurRadius: 10,
                      spreadRadius: -5,
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Container(
                      color: state.request!.is_accepted == null
                          ? AppPallete.color4
                          : state.request!.is_accepted == true
                              ? AppPallete.accept
                              : AppPallete.reject,
                      width: 30,
                    ),
                    Expanded(
                      child: Container(
                        padding:
                            const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Your Request :  ",
                              style: GoogleFonts.poppins().copyWith(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: AppPallete.text),
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            Text(
                              "Date: ${FormateDate(state.request!.created_at!)} ",
                              style: GoogleFonts.poppins().copyWith(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                  color: AppPallete.text.withOpacity(0.9)),
                            ),
                            const SizedBox(
                              height: 24,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Change To Room:",
                                  style: GoogleFonts.poppins().copyWith(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                      color: AppPallete.text.withOpacity(0.8)),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 4),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: state.request!.is_accepted == null
                                        ? AppPallete.color4
                                        : state.request!.is_accepted == true
                                            ? AppPallete.accept
                                            : AppPallete.reject,
                                  ),
                                  child: Text(
                                    state.request!.to_room_id,
                                    style: GoogleFonts.poppins().copyWith(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14,
                                        color: AppPallete.backgroundColor),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "status:",
                                  style: GoogleFonts.poppins().copyWith(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                      color: AppPallete.text.withOpacity(0.8)),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 4),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: state.request!.is_accepted == null
                                        ? AppPallete.color4
                                        : state.request!.is_accepted == true
                                            ? AppPallete.accept
                                            : AppPallete.reject,
                                  ),
                                  child: Text(
                                    state.request!.is_accepted == null
                                        ? "in queue"
                                        : state.request!.is_accepted == true
                                            ? "Accepted"
                                            : "Not Accepted",
                                    style: GoogleFonts.poppins().copyWith(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14,
                                        color: AppPallete.backgroundColor),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          }
        }
        if (state is RequestLoading) {
          return const Center(
            child: Loader(
              color: AppPallete.color4,
            ),
          );
        }
        return Container();
      },
    );
  }
}
