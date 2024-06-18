import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:royal_orchid_hotel/core/entites/request.dart';
import 'package:royal_orchid_hotel/core/theme/app_pallete.dart';
import 'package:royal_orchid_hotel/core/utils/show_snack_bar.dart';
import 'package:royal_orchid_hotel/features/customer/presentation/bloc/request/request_bloc.dart';
import 'package:royal_orchid_hotel/features/customer/presentation/widget/request_list_item.dart';

import '../../../../core/commen/cubit/app_user/app_user_cubit.dart';
import '../../../../core/commen/cubit/app_user/app_user_state.dart';
import '../../../../core/widget/loader.dart';
import '../../../../int_dep.dart';

class MyRequestServicePage extends StatefulWidget {
  const MyRequestServicePage({super.key});

  static route() => MaterialPageRoute(builder: (context) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (_) => serviceLocator<RequestBloc>()),
          ],
          child: const MyRequestServicePage(),
        );
      });

  @override
  State<MyRequestServicePage> createState() => _MyRequestServicePageState();
}

class _MyRequestServicePageState extends State<MyRequestServicePage> {
  @override
  void initState() {
    var user = (context.read<AppUserCubit>().state as AppCustomerLoggin).user;
    context.read<RequestBloc>().add(GetMyRequestEvent(user_id: user.id));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "My Request:",
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
            if (state is DisplayMyRequestSuccess) {
              return GroupedListView<Request, String>(
                elements: state.list,
                groupBy: (element) => element.IsAnswered(),
                groupSeparatorBuilder: (String groupByValue) => Padding(
                  padding:  const EdgeInsets.symmetric(horizontal: 18.0,vertical: 8),
                  child: Text(
                    groupByValue,
                    style: GoogleFonts.poppins().copyWith(
                        fontWeight: FontWeight.w800,
                        color: AppPallete.text,
                        fontSize: 15),
                  ),
                ),
                itemBuilder: (context, Request element) =>
                    RequestListItem(request: element),
              );

              /*
             ListView.builder(
                itemBuilder: (context, index) {
                  return RequestListItem( request: state.list[index]);
                },
                itemCount: state.list.length,
              );
               */
            }
            return const SizedBox();
          },
        ));
  }
}
