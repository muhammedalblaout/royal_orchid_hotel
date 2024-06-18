
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:royal_orchid_hotel/core/utils/show_snack_bar.dart';
import 'package:royal_orchid_hotel/core/entites/service.dart';
import 'package:royal_orchid_hotel/features/customer/presentation/bloc/request/request_bloc.dart';

import '../../../../core/entites/request.dart';
import '../../../../core/entites/user.dart';
import '../../../../core/theme/app_pallete.dart';
import '../../../../core/widget/loader.dart';


class OrderDialog extends StatefulWidget {
  final Service service;
  final User user;

  const OrderDialog(
      {super.key, required this.service,required this.user});

  @override
  State<OrderDialog> createState() => _OrderDialogState();
}

class _OrderDialogState extends State<OrderDialog> {
  @override
  Widget build(BuildContext context) {

    return BlocConsumer<RequestBloc, RequestState>(
  listener: (context, state) {
    if(state is RequestFail){
      ErrorShowSnackBar(context, state.massage);
    }
  },
builder: (context, state) {
      if (state is InsertRequestSuccess) {
        return SimpleDialog(
          children: [
            Padding(
              padding: const EdgeInsets.all(50.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.account_balance_wallet_rounded,
                    color: AppPallete.color4,
                    size: 50,
                  ),
                  Text(
                    "Confirmed",
                    style: GoogleFonts.poppins().copyWith(
                        color: AppPallete.color4,
                        fontSize: 26,

                        fontWeight: FontWeight.w900),textAlign: TextAlign.center,
                  ),

                ],
              ),
            ),
          ],
        );
      }
      if (state is RequestLoading) {
        return const Center(child: Loader(color: AppPallete.color4,));
      }
      return  AlertDialog(
        backgroundColor: AppPallete.backgroundColor,
        title: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(
              Icons.shopping_cart,
              color: AppPallete.color4,
              size: 50,
            ),
            Text(
              "Are You Sure ?",
              style: GoogleFonts.poppins().copyWith(
                  color: AppPallete.color4,
                  fontSize: 26,
                  fontWeight: FontWeight.w900),
            ),
            const SizedBox(
              height: 8,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "you want to order this service?\n Service: ${widget.service.name} \n Price: ${widget.service.price}",
                  style: GoogleFonts.poppins().copyWith(
                    color: AppPallete.text,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            )
          ],
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
            },
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(AppPallete.backgroundColor),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                        side: const BorderSide(color: AppPallete.color4,width: 2)))),
            child:  Text("Cancel",style: GoogleFonts.poppins().copyWith(
              color: AppPallete.text,
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),),
          ),
          ElevatedButton(
            onPressed: () {
              Request request = Request(customer_id:widget.user.id,Service_id:widget.service.id!, room_id: widget.user.room,sector:widget.user.sector);
              context.read<RequestBloc>().add(InsertRequestEvent(request: request));

            },
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(AppPallete.color4),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                        side: const BorderSide(color: AppPallete.color4,width: 2)))),
            child:  Text("Confirm",style: GoogleFonts.poppins().copyWith(
              color: AppPallete.backgroundColor,
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),),
          ),
        ],
      );
    }
    );
  }
  }
