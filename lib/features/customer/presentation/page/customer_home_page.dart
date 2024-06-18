import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:royal_orchid_hotel/core/commen/widget/home_card.dart';
import 'package:royal_orchid_hotel/core/theme/app_pallete.dart';
import 'package:royal_orchid_hotel/features/customer/presentation/page/request_service_page.dart';

import '../../../../core/commen/cubit/app_user/app_user_cubit.dart';
import '../../../../core/commen/cubit/app_user/app_user_state.dart';
import '../../../../core/commen/widget/plan.dart';
import '../../../../core/entites/user.dart';
import 'change_room_page.dart';
import 'my_Invoice_page.dart';
import 'my_request_service_page.dart';

class CustomerHomePage extends StatefulWidget {
  const CustomerHomePage({super.key});

  @override
  State<CustomerHomePage> createState() => _CustomerHomePageState();
}

class _CustomerHomePageState extends State<CustomerHomePage> {
  late User user;

  @override
  void initState() {
    user = (context.read<AppUserCubit>().state as AppCustomerLoggin).user;
    print(user.sector);
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
                HSVColor.fromColor(AppPallete.color4).withValue(0.5).toColor(),
                HSVColor.fromColor(AppPallete.color4).withValue(0.6).toColor(),
                HSVColor.fromColor(AppPallete.color4).withValue(0.7).toColor(),
                HSVColor.fromColor(AppPallete.color4).withValue(0.7).toColor(),
              ],
              stops: const [
              0.3,
              0.4,
              0.5,
              1.0])
              ),
              padding: const EdgeInsets.all(30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Hello!",
                        style: GoogleFonts.satisfy().copyWith(
                            fontWeight: FontWeight.w900,
                            color: AppPallete.backgroundColor,
                            fontSize: 30),
                      ),
                      Text(
                        user.name,
                        style: GoogleFonts.poppins().copyWith(
                            fontWeight: FontWeight.w900,
                            color: AppPallete.backgroundColor,
                            fontSize: 20),
                      ),
                      Text(
                        user.email,
                        style: GoogleFonts.poppins().copyWith(
                            fontWeight: FontWeight.w400,
                            color: AppPallete.backgroundColor.withOpacity(0.8),
                            fontSize: 14),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        "Room: ${user.room} | Sector: ${user.sector}",
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8),
                  Text(
                    "Services: ",
                    style: GoogleFonts.poppins().copyWith(
                        fontWeight: FontWeight.w700,
                        color: AppPallete.text,
                        fontSize: 16),
                    textAlign: TextAlign.start,
                  ),
                  const SizedBox(
                    height: 16,
                  ),


                ],
              ),
            ),
            Expanded(
              child: Container(
                child: GridView(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 8.0,
                    crossAxisSpacing: 8.0

                  ),
                  children: [
                    HomeCard(       onTap: () {
                      Navigator.push(context, RequestServicePage.route());
                    },
                      color1: AppPallete.color4,
                      color2: AppPallete.backgroundColor,
                      iconData: Icons.room_service,
                      title: 'Request\nService ',),
                    HomeCard(
                      onTap: () {
                        Navigator.push(context, MyRequestServicePage.route());
                      },
                      color1: AppPallete.color3,
                      color2: AppPallete.backgroundColor,
                      iconData: Icons.list_alt,
                      title: 'Your\nRequest ',
                    ),
                    HomeCard(
                      onTap: () {
                        Navigator.push(context, Plan.route(user.room));
                      },
                      color1: AppPallete.gold,
                      color2: AppPallete.backgroundColor,
                      iconData: Icons.bedroom_parent_outlined,
                      title: 'Your\nRoom ',
                    ),
                    HomeCard(
                      onTap: () {
                        Navigator.push(context, MyInvoicePage.route());
                      },
                      color1: AppPallete.color4,
                      color2: AppPallete.backgroundColor,
                      iconData: Icons.receipt,
                      title: 'Your\nInvoice ',
                    ),
                    HomeCard(
                      onTap: () {
                        Navigator.push(context, ChangeRoomPage.route());
                      },
                      color1: AppPallete.color3,
                      color2: AppPallete.backgroundColor,
                      iconData: Icons.key,
                      title: 'Change\nRoom ',
                    ),
                    HomeCard(
                      onTap: () {
                        context.read<AppUserCubit>().logout();
                      },
                      color1: AppPallete.reject,
                      color2: AppPallete.backgroundColor,
                      iconData: Icons.logout,
                      title: 'Log Out ',
                    )

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
