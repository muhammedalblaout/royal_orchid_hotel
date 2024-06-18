import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:royal_orchid_hotel/core/theme/app_pallete.dart';
import 'package:royal_orchid_hotel/core/utils/show_snack_bar.dart';
import 'package:royal_orchid_hotel/features/auth/presentation/bloc/auth_bloc.dart';
import '../../../../core/commen/widget/custom_button.dart';
import '../../../../core/commen/widget/custom_text_field.dart';
import '../../../../core/widget/loader.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  static route() => MaterialPageRoute(builder: (context) => const LoginPage());

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: double.infinity,
          width: double.infinity,
          decoration: const BoxDecoration(
            color: AppPallete.backgroundColor,
            image: DecorationImage(
                image: AssetImage('assets/pbg.jpg'),
                repeat: ImageRepeat.repeat,
                fit: BoxFit.scaleDown),
          ),
        ),
        Scaffold(
            backgroundColor: AppPallete.transparent,
            body: Form(
              key: formKey,
              child: BlocConsumer<AuthBloc, AuthState>(
                listener: (context, state) {
                  if (state is AuthFaill) {
                    ErrorShowSnackBar(context, state.massage);
                  }
                },
                builder: (context, state) {
                  if (state is AuthLoading) {
                    return const Center(
                      child: Loader(
                        color: AppPallete.color4,
                      ),
                    );
                  }

                  return Container(
                    child: Column(
                      children: [
                        Container(
                          width: double.infinity,
                          height: 0.5.sh,
                          child: Stack(
                            children: [
                              Container(
                                width: double.infinity,
                                child: SvgPicture.asset(
                                  'assets/bg.svg',
                                  fit: BoxFit.fill,
                                ),
                              ),
                              SafeArea(
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Center(
                                        child: SvgPicture.asset(
                                          height: 100,
                                          width: 100,
                                          'assets/logo.svg',
                                          color: AppPallete.backgroundColor,
                                        ),
                                      ),
                                      Text(
                                        "Royal Orchid",
                                        style: GoogleFonts.poppins().copyWith(
                                            fontSize: 40,
                                            fontWeight: FontWeight.bold,
                                            color: AppPallete.backgroundColor),
                                      ),
                                    ]),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(32.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CustomTextField(
                                  hint: "Email",
                                  icon: Icons.email,
                                  isPassword: false,
                                  textEditingController: emailController),
                              const SizedBox(
                                height: 8,
                              ),
                              CustomTextField(
                                  hint: "Password",
                                  icon: Icons.lock,
                                  isPassword: true,
                                  textEditingController: passwordController),
                              const SizedBox(
                                height: 24,
                              ),
                              CustomButton("Sign In", onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  context.read<AuthBloc>().add(SignInEvent(
                                      emailController.text.trim(),
                                      passwordController.text.trim()));
                                }
                              }),
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                },
              ),
            )),
      ],
    );
  }
}
