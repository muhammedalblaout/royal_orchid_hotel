import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:royal_orchid_hotel/core/theme/app_pallete.dart';
import 'package:royal_orchid_hotel/core/utils/show_snack_bar.dart';
import 'package:royal_orchid_hotel/features/customer/presentation/bloc/request/request_bloc.dart';
import 'package:royal_orchid_hotel/features/customer/presentation/widget/invoice_list_item.dart';

import '../../../../core/commen/cubit/app_user/app_user_cubit.dart';
import '../../../../core/commen/cubit/app_user/app_user_state.dart';
import '../../../../core/widget/loader.dart';
import '../../../../int_dep.dart';

class MyInvoicePage extends StatefulWidget {
  const MyInvoicePage({super.key});

  static route() => MaterialPageRoute(builder: (context) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (_) => serviceLocator<RequestBloc>()),
          ],
          child: const MyInvoicePage(),
        );
      });

  @override
  State<MyInvoicePage> createState() => _MyInvoicePageState();
}

class _MyInvoicePageState extends State<MyInvoicePage> {
  @override
  void initState() {
    var user = (context.read<AppUserCubit>().state as AppCustomerLoggin).user;
    context.read<RequestBloc>().add(GetMyInvoiceEvent(user_id: user.id));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "My Invoice:",
          style: GoogleFonts.poppins().copyWith(
              fontWeight: FontWeight.w700,
              fontSize: 20,
              color: AppPallete.color4),
        ),
      ),
      body: BlocConsumer<RequestBloc, RequestState>(
        listener: (context, state) {
          if (state is RequestFail) {
            ErrorShowSnackBar(context, state.massage);
          }
        },
        builder: (context, state) {
          if (state is RequestLoading) {
            return const Loader(color: AppPallete.color4);
          }
          if (state is DisplayInvoiceSuccess) {
            var total = state.list.fold(0, (sum, item) => sum + item.price);

            return Column(
              children: [
                Expanded(
                  child: Container(
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        return InvoiceListItem(
                          invoice: state.list[index],
                        );
                      },
                      itemCount: state.list.length,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 32,vertical: 20),
                  decoration: BoxDecoration(
                    color: AppPallete.backgroundColor,
                      boxShadow: [
                        BoxShadow(
                            color: AppPallete.color4.withOpacity(0.2),
                            spreadRadius: 2,
                            blurRadius: 4)
                      ],
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(40),
                          topRight: Radius.circular(40))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "\$ $total",
                        style: GoogleFonts.poppins().copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 32,
                            color: AppPallete.color4),
                      ),
                      Container(
                        padding:
                            const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: AppPallete.color4,
                            boxShadow: [
                              BoxShadow(
                                  color: AppPallete.color4.withOpacity(0.4),
                                  spreadRadius: 2,
                                  blurRadius: 4)
                            ]),
                        child: Text(
                          "Total Amount",
                          style: GoogleFonts.poppins().copyWith(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: AppPallete.backgroundColor),
                        ),
                      )
                    ],
                  ),
                )
              ],
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
