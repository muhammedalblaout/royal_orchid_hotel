import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:royal_orchid_hotel/core/theme/app_pallete.dart';
import 'package:royal_orchid_hotel/core/utils/show_snack_bar.dart';
import 'package:royal_orchid_hotel/core/widget/loader.dart';
import 'package:royal_orchid_hotel/features/admin/presentation/widgets/customers/customers_list_items.dart';

import '../../../../../int_dep.dart';
import '../../bloc/user/user_bloc.dart';
import 'customer_details_page.dart';

class CustomersPage extends StatefulWidget {
  static route() => MaterialPageRoute(builder: (context) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (_) => serviceLocator<UserBloc>()),
          ],
          child: const CustomersPage(),
        );
      });

  const CustomersPage({super.key});

  @override
  State<CustomersPage> createState() => _CustomersPageState();
}

class _CustomersPageState extends State<CustomersPage> {
  @override
  void initState() {
    context.read<UserBloc>().add(GetAllCustomerEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
        "Customers",
        style: GoogleFonts.poppins().copyWith(
            fontWeight: FontWeight.w700,
            fontSize: 20,
            color: AppPallete.color4),
      )),
      body: BlocConsumer<UserBloc, UserState>(
        listener: (context, state) {
          if (state is UserFail) {
            ErrorShowSnackBar(context, state.massage);
          }
        },
        builder: (context, state) {
          if (state is UserLoading) {
            return const Loader(color: AppPallete.color4);
          }
          if (state is DisplayUsersSuccess) {
            return ListView.builder(
              itemBuilder: (context, index) {
                return GestureDetector(
                  child: CustomersListItems(user: state.users[index]),
                  onTap: () {
                    Navigator.push(context, CustomerDetailsPage.route( state.users[index]));
                  },
                );
              },
              itemCount: state.users.length,
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
