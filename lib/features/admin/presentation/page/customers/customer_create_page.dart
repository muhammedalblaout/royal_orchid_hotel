import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:royal_orchid_hotel/core/commen/widget/custom_button.dart';
import 'package:royal_orchid_hotel/core/commen/widget/custom_text_field.dart';
import 'package:royal_orchid_hotel/core/entites/user.dart';
import 'package:royal_orchid_hotel/core/utils/show_snack_bar.dart';
import 'package:royal_orchid_hotel/core/widget/loader.dart';
import 'package:royal_orchid_hotel/features/admin/presentation/bloc/room/room_bloc.dart';
import 'package:royal_orchid_hotel/features/admin/presentation/bloc/user/user_bloc.dart';

import '../../../../../core/theme/app_pallete.dart';
import '../../../../../int_dep.dart';
import '../../../../../core/entites/room.dart';
import '../../widgets/room_drop_list.dart';

class CustomerCreatePage extends StatefulWidget {
  static route() =>
      MaterialPageRoute(builder: (context) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (_) => serviceLocator<RoomBloc>()),
            BlocProvider(create: (_) => serviceLocator<UserBloc>()),
          ],
          child: const CustomerCreatePage(),
        );
      });

  const CustomerCreatePage({super.key});

  @override
  State<CustomerCreatePage> createState() => _CustomerCreatePageState();
}

class _CustomerCreatePageState extends State<CustomerCreatePage> {
  final TextEditingController NameTextController = TextEditingController();
  final TextEditingController EmailTextController = TextEditingController();
  final TextEditingController PasswordTextController = TextEditingController();
  String Room_id = "";
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    context.read<RoomBloc>().add(GetAllRoomsEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Customer Account",
          style: GoogleFonts.poppins().copyWith(
              fontWeight: FontWeight.w700,
              fontSize: 20,
              color: AppPallete.color4),
        ),
      ),
      body: BlocConsumer<RoomBloc, RoomState>(
        listener: (context, state) {
          if (state is RoomFaill) {
            ErrorShowSnackBar(context, state.massage);
          }
        },
        builder: (context, state) {
          if (state is RoomLoading) {
            return const Loader(color: AppPallete.color4);
          }
          if (state is RoomSuccess) {
            Room_id = state.rooms.first.room_id;
            List<Room> rooms=state.rooms;
            return BlocConsumer<UserBloc, UserState>(
              listener: (context, state) {
                if (state is UserFail) {
                  ErrorShowSnackBar(context, state.massage);
                }
                if(state is UserSuccess){
                  Navigator.pop(context);
                }
              },
              builder: (context, state) {
                if(state is UserLoading){
                  return const Loader(color: AppPallete.color4);
                }

                return Form(
                  key: formKey,
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 30,
                          ),
                          Text(
                            "Details:",
                            style: GoogleFonts.poppins().copyWith(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                                color: AppPallete.color4),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          CustomTextField(
                              hint: "Name",
                              icon: Icons.person_outline,
                              isPassword: false,
                              textEditingController: NameTextController),
                          const SizedBox(
                            height: 12,
                          ),
                          CustomTextField(
                              hint: "E-Mail",
                              icon: Icons.mail_outline_outlined,
                              isPassword: false,
                              textEditingController: EmailTextController),
                          const SizedBox(
                            height: 12,
                          ),
                          CustomTextField(
                              hint: "Password",
                              icon: Icons.lock_outline,
                              isPassword: true,
                              textEditingController: PasswordTextController),
                          const SizedBox(
                            height: 12,
                          ),
                          RoomDropList(
                            icon: Icons.bedroom_parent_outlined,
                            items: rooms,
                            onChanged: (String value) {
                              Room_id = value;
                            },
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          CustomButton("Upload", onPressed: () {
                            if (formKey.currentState!.validate()) {
                              User user = User(
                                  id: "0",
                                  name: NameTextController.text.trim(),
                                  email: EmailTextController.text.trim(),
                                  sector: " ",
                                  room: Room_id,
                                  password: PasswordTextController.text.trim(),
                                  role: 3);
                              context.read<UserBloc>().add(
                                  InsertUserEvent(user));
                              print(EmailTextController.text.trim());
                            }
                          })
                        ],
                      ),
                    ),
                  ),
                );

              },
            );
          }

          return const SizedBox();
        },
      ),
    );
  }
}
