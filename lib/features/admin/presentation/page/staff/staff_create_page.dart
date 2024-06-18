import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:royal_orchid_hotel/core/commen/widget/custom_text_field.dart';
import 'package:royal_orchid_hotel/features/admin/presentation/bloc/sector/sector_bloc.dart';
import 'package:royal_orchid_hotel/features/admin/presentation/widgets/sector_drop_list.dart';

import '../../../../../core/commen/widget/custom_button.dart';
import '../../../../../core/entites/user.dart';
import '../../../../../core/theme/app_pallete.dart';
import '../../../../../core/utils/show_snack_bar.dart';
import '../../../../../core/widget/loader.dart';
import '../../../../../int_dep.dart';
import '../../bloc/user/user_bloc.dart';
import '../../widgets/role_drop_list.dart';

class StaffCreatePage extends StatefulWidget {
  static route() =>
      MaterialPageRoute(builder: (context) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (_) => serviceLocator<SectorBloc>()),
            BlocProvider(create: (_) => serviceLocator<UserBloc>()),

          ],

          child:
          const StaffCreatePage(),

        );
      });

  const StaffCreatePage({super.key});

  @override
  State<StaffCreatePage> createState() => _StaffCreatePageState();
}

class _StaffCreatePageState extends State<StaffCreatePage> {
  final TextEditingController NameTextController = TextEditingController();
  final TextEditingController EmailTextController = TextEditingController();
  final TextEditingController PasswordTextController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  int role_id=2;
  String Sector="";


  @override
  void initState() {
    context.read<SectorBloc>().add(GetAllSectorEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Staff Account",
          style: GoogleFonts.poppins().copyWith(
              fontWeight: FontWeight.w700,
              fontSize: 20,
              color: AppPallete.color4),
        ),
      ),
      body: BlocConsumer<SectorBloc, SectorState>(
        listener: (context, state) {
          if (state is SectorFaill) {
            ErrorShowSnackBar(context, state.massage);
          }
        },
        builder: (context, state) {
          if (state is SectorLoading) {
            return const Loader(color: AppPallete.color4);
          }
          if (state is SectorSuccess) {
            List<String>sectors=state.sectors;
            Sector=state.sectors[0];
            return BlocConsumer<UserBloc, UserState>(
              listener: (context, state) {
                if (state is UserFail) {
                  ErrorShowSnackBar(context, state.massage);
                }
                if (state is UserSuccess) {
                  Navigator.pop(context);
                }
              },
              builder: (context, state) {
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
                          ), const SizedBox(
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
                          RoleDropList(
                              icon: Icons.work_outline,
                              items: const ["Staff", "Admin"],onChanged: (int value){
                                role_id=value;
                          },),
                          const SizedBox(
                            height: 12,
                          ),
                          SectorDropList(
                              icon: Icons.apartment, items: sectors,onChanged: (String value){
                                Sector=value;
                          },),
                          const SizedBox(
                            height: 24,
                          ),
                          CustomButton("Upload", onPressed: () {
                            if (formKey.currentState!.validate()) {
                              User user = User(
                                  id: "0",
                                  name: NameTextController.text.trim(),
                                  email: EmailTextController.text.trim(),
                                  sector: Sector,
                                  room: " ",
                                  password: PasswordTextController.text.trim(),
                                  role: role_id);
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
