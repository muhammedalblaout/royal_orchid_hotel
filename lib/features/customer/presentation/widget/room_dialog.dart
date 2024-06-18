import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:royal_orchid_hotel/core/utils/show_snack_bar.dart';
import 'package:royal_orchid_hotel/features/customer/presentation/bloc/request/request_bloc.dart';
import '../../../../core/theme/app_pallete.dart';
import '../../../../core/widget/loader.dart';

class RoomDialog extends StatefulWidget {
  final ValueChanged<String> onChanged;

  const RoomDialog({super.key, required this.onChanged});

  @override
  State<RoomDialog> createState() => _RoomDialogState();
}

class _RoomDialogState extends State<RoomDialog> {
  @override
  void initState() {
    context.read<RequestBloc>().add(GetRoomsEvent());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RequestBloc, RequestState>(listener: (context, state) {
      if (state is RequestFail) {
        ErrorShowSnackBar(context, state.massage);
      }
    }, builder: (context, state) {
      if (state is DisplayRoomsSuccess) {
        return SimpleDialog(
          backgroundColor: AppPallete.backgroundColor,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              height: 300,
              width: 300,
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return GestureDetector(
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 4),
                      padding:
                          const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                          color: AppPallete.color4,
                          borderRadius: BorderRadius.circular(4),
                          boxShadow: const [
                            BoxShadow(
                              color: AppPallete.color4,
                              offset: Offset(0, 10),
                              blurRadius: 5,
                              spreadRadius: -8,
                            ),
                          ],
                          gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomCenter,
                              colors: [
                                HSVColor.fromColor(AppPallete.color4)
                                    .withValue(0.8)
                                    .toColor(),
                                HSVColor.fromColor(AppPallete.color4)
                                    .withValue(0.8)
                                    .toColor(),
                                AppPallete.color4,
                                AppPallete.color4
                              ],
                              stops: const [
                                0.2,
                                0.3,
                                0.9,
                                1.0
                              ])),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.bedroom_parent_outlined,
                            color: AppPallete.backgroundColor,
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Text(
                            state.list[index].room_id,
                            style: GoogleFonts.poppins().copyWith(
                                color: AppPallete.backgroundColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w500),
                          )
                        ],
                      ),
                    ),
                    onTap: () {
                      widget.onChanged(state.list[index].room_id);
                      Navigator.pop(context);
                    },
                  );
                },
                itemCount: state.list.length,
              ),
            )
          ],
        );
      }
      if (state is RequestLoading) {
        return Center(
            child: Container(
          height: 100,
          width: 100,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: AppPallete.backgroundColor),
          child: const Loader(
            color: AppPallete.color4,
          ),
        ));
      }
      return const SizedBox();
    });
  }
}
