import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:royal_orchid_hotel/core/entites/user.dart';
import 'package:royal_orchid_hotel/features/admin/presentation/bloc/user/user_bloc.dart';

import '../../../../../core/theme/app_pallete.dart';
import '../../../../../core/utils/show_snack_bar.dart';
import '../../../../../core/widget/loader.dart';
import '../../../../../int_dep.dart';
import '../../widgets/customers/customer_invoice_list_item.dart';

class CustomerDetailsPage extends StatefulWidget {
  static route(User user) => MaterialPageRoute(builder: (context) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (_) => serviceLocator<UserBloc>()),
          ],
          child: CustomerDetailsPage(
            user: user,
          ),
        );
      });
  final User user;

  const CustomerDetailsPage({super.key, required this.user});

  @override
  State<CustomerDetailsPage> createState() => _CustomerDetailsPageState();
}

class _CustomerDetailsPageState extends State<CustomerDetailsPage> {
  @override
  void initState() {
    context.read<UserBloc>().add(GetCustomerInvoiceEvent(widget.user.id));
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
                        "Room: ${widget.user.room} | Sector: ${widget.user.sector}",
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
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                "Invoice:",
                style: GoogleFonts.poppins().copyWith(
                    fontWeight: FontWeight.w700,
                    color: AppPallete.gold,
                    fontSize: 20.sp),
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
                  if (state is DisplayCustomerInvoicesSuccess) {
                    var total = state.list.fold(0, (sum, item) => sum + item.price);

                    return Column(
                      children: [
                        Expanded(
                          child: Container(
                            child: ListView.builder(
                              itemBuilder: (context, index) {
                                return CustomerInvoiceListItem(
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
            ),

          ],
        ),
      ),
    );
  }
}
