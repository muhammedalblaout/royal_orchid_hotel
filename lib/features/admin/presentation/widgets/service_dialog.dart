import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:royal_orchid_hotel/core/utils/show_snack_bar.dart';
import 'package:royal_orchid_hotel/core/entites/service.dart';
import 'package:royal_orchid_hotel/features/admin/presentation/bloc/service/service_bloc.dart';
import 'package:royal_orchid_hotel/features/customer/presentation/bloc/request/request_bloc.dart';
import '../../../../core/commen/widget/custom_text_field.dart';
import '../../../../core/theme/app_pallete.dart';
import '../../../../core/widget/loader.dart';

class ServiceDialog extends StatefulWidget {
  final Service? service;
  final ValueChanged<void> onChanged;


  const ServiceDialog({super.key, this.service, required this.onChanged});

  @override
  State<ServiceDialog> createState() => _ServiceDialogState(service);
}

class _ServiceDialogState extends State<ServiceDialog> {


  late TextEditingController nameTextController = TextEditingController();
  late TextEditingController priceController = TextEditingController();

  final formKey = GlobalKey<FormState>();
  bool isAvailable = true;
  _ServiceDialogState(Service? service ){
    nameTextController = TextEditingController(text: service?.name);
    priceController = TextEditingController(text: service?.price.toString());
    isAvailable = service==null?true:service.available!;


  }




  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AdminServiceBloc, AdminServiceState>(
        listener: (context, state) {
          if (state is AdminServiceFail) {
            ErrorShowSnackBar(context, state.massage);
          }
        }, builder: (context, state) {
      if (state is AdminUpdateServiceSuccess) {
        widget.onChanged(());

        return SimpleDialog(
          children: [
            Padding(
              padding: const EdgeInsets.all(50.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.check_circle,
                    color: AppPallete.color4,
                    size: 50,
                  ),
                  Text(
                    "Confirmed",
                    style: GoogleFonts.poppins().copyWith(
                        color: AppPallete.color4,
                        fontSize: 26,
                        fontWeight: FontWeight.w900),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ],
        );
      }
      if (state is RequestLoading) {
        return const Center(
            child: Loader(
              color: AppPallete.color4,
            ));
      }
      return Form(
        key: formKey,
        child: AlertDialog(
          actionsAlignment: MainAxisAlignment.center,
          backgroundColor: AppPallete.backgroundColor,
          title: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Service",
                style: GoogleFonts.poppins().copyWith(
                    color: AppPallete.color4,
                    fontSize: 26,
                    fontWeight: FontWeight.w900),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 16,
              ),
              CustomTextField(
                  hint: "Service Name",
                  icon: Icons.room_service,
                  isPassword: false,
                  textEditingController: nameTextController),
              const SizedBox(
                height: 8,
              ),
              CustomTextField(
                hint: "Service Price",
                icon: Icons.monetization_on,
                isPassword: false,
                textEditingController: priceController,
                textInputType: TextInputType.number,
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Availability ',
                    style: GoogleFonts.poppins()
                        .copyWith(color: AppPallete.color5, fontSize: 12.0),
                  ),
                  Switch(
                    // thumb color (round icon)
                    activeColor: AppPallete.color5,
                    activeTrackColor: AppPallete.color5.withOpacity(0.2),
                    inactiveThumbColor: Colors.grey.shade500,
                    inactiveTrackColor: Colors.grey.shade400,
                    splashRadius: 50.0,
                    // boolean variable value
                    value: isAvailable,
                    // changes the state of the switch
                    onChanged: (value) => setState(() => isAvailable = value),
                  )
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
                  backgroundColor:
                  MaterialStateProperty.all(AppPallete.backgroundColor),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                          side:
                          const BorderSide(color: AppPallete.color4, width: 2)))),
              child: Text(
                "Cancel",
                style: GoogleFonts.poppins().copyWith(
                  color: AppPallete.text,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  Service service = Service(id:widget.service?.id,
                      name: nameTextController.text.trim(), price: int.parse(priceController.text.trim()),available: isAvailable);
                  if(widget.service==null){
                    context.read<AdminServiceBloc>().add(AdminInsertServiceEvent(service));

                  }
                  else{
                    context.read<AdminServiceBloc>().add(AdminUpdateServiceEvent(service));

                  }

                }
              },
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(AppPallete.color4),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                          side:
                          const BorderSide(color: AppPallete.color4, width: 2)))),
              child: Text(
                widget.service==null? "Confirm":"Update",
                style: GoogleFonts.poppins().copyWith(
                  color: AppPallete.backgroundColor,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      );
    });
  }

  @override
  void dispose() {
    nameTextController.dispose();
    priceController.dispose();
    super.dispose();
  }

}
