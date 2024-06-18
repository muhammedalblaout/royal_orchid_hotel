import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:royal_orchid_hotel/core/theme/app_pallete.dart';
import 'package:royal_orchid_hotel/features/staff/presentation/page/my_staff_requests_page.dart';
import 'package:royal_orchid_hotel/features/staff/presentation/page/staff_status_page.dart';

import '../../../../core/commen/cubit/app_user/app_user_cubit.dart';
import '../../../../core/commen/cubit/app_user/app_user_state.dart';
import '../../../../core/commen/widget/home_card.dart';
import '../../../../core/entites/user.dart';
import 'my_sector_request_page.dart';

class StaffHomePage extends StatefulWidget {
  const StaffHomePage({super.key});

  @override
  State<StaffHomePage> createState() => _StaffHomePageState();
}

class _StaffHomePageState extends State<StaffHomePage> {
  late User user;

  @override
  void initState() {
    user = (context.read<AppUserCubit>().state as AppStaffLoggin).user;
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
              decoration:  BoxDecoration(
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
                      const SizedBox(height: 8,),
                      Text(
                        "Role: Staff | Sector: ${user.sector}",
                        style: GoogleFonts.poppins().copyWith(
                            fontWeight: FontWeight.w200,
                            fontSize: 14,
                            color: AppPallete.backgroundColor.withOpacity(0.8)),
                      ),
                    ],
                  ),
                  Container(
                    decoration:
                    BoxDecoration(color: AppPallete.backgroundColor,borderRadius: BorderRadius.circular(10)),
                    child: const Icon(
                      Icons.person,
                      color: AppPallete.color4,
                      size: 120,
                    ),
                  )
                ],
              ),
            ),

            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                "Services: ",
                style: GoogleFonts.poppins().copyWith(
                    fontWeight: FontWeight.w700,
                    color: AppPallete.text,
                    fontSize: 16),
                textAlign: TextAlign.start,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Expanded(child:  GridView(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 8.0,
                crossAxisSpacing: 8.0

            ),
                    children: [
                      HomeCard(             onTap: () {
            Navigator.push(context, MySectorRequestsPage.route());
            },
                color1: AppPallete.color5,
                color2: AppPallete.backgroundColor,
                iconData: Icons.apartment,
                title: 'Sector\nRequests '),
                      HomeCard(
            onTap: () {
              Navigator.push(context, MyStaffRequestsPage.route());

            },
            color1: AppPallete.color3,
            color2: AppPallete.backgroundColor,
            iconData: Icons.list_alt_sharp,
            title: 'Your\nRequest ',
                      ),

                      HomeCard(
            onTap: () {
              Navigator.push(context, StaffStatusPage2.route());

            },
            color1: AppPallete.gold,
            color2: AppPallete.backgroundColor,
            iconData: Icons.bar_chart_outlined,
            title: 'Your\nStatus ',
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
          ],
        ),
      ),
    );
  }
}
