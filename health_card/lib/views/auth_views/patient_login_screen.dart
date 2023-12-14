import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_card/bloc/auth/auth_bloc.dart';
import 'package:health_card/bloc/auth/auth_event.dart';
import 'package:health_card/bloc/auth/auth_statee.dart';
import 'package:health_card/consts/colors.dart';
import 'package:health_card/global/global_widgets/text_widget.dart';
import 'package:health_card/global/globals.dart';
import 'package:health_card/models/patient_model.dart';
import 'package:health_card/utilities/extentions/navigation_extentions.dart';
import 'package:health_card/utilities/extentions/size_extentions.dart';
import 'package:health_card/utilities/functions/loading_func.dart';
import 'package:health_card/views/Patient%20Views/patient_home_view/patient_home_view.dart';
import 'package:health_card/views/auth_views/auth_widgets/auth_button_widget.dart';
import 'package:health_card/views/auth_views/auth_widgets/auth_richtext_widget.dart';
import 'package:health_card/views/auth_views/auth_widgets/auth_textfeild.dart';
import 'package:health_card/views/auth_views/patient_registration_screen.dart';

class PatientLoginScreen extends StatelessWidget {
  PatientLoginScreen({super.key});
  final emailKey2 = GlobalKey<FormState>();
  final passwordKey2 = GlobalKey<FormState>();
  final TextEditingController controllerEmail = TextEditingController();
  final TextEditingController controllerPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    controllerEmail.text = 'wegyse@tutuapp.bid';
    controllerPassword.text = "123456";
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
          backgroundColor: white,
          body: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextWidget(
                        text: 'Patient_login_screen.title'.tr(),
                        colorText: red2,
                        fontWeightText: FontWeight.bold,
                        fontSizeText: 40),
                    AuthFelid(
                      label: 'Patient_login_screen.email'.tr(),
                      hint: 'Patient_login_screen.emailHint'.tr(),
                      controller: controllerEmail,
                      sufixIcon: Icons.email,
                      key: emailKey2,
                      validator: (value) {
                        return null;
                      },
                    ),
                    AuthFelid(
                      controller: controllerPassword,
                      label: 'Patient_login_screen.password'.tr(),
                      hint: 'Patient_login_screen.passwordHint'.tr(),
                      key: passwordKey2,
                      validator: (value) {
                        return null;
                      },
                      isPass: true,
                    ),
                    AuthRichText(
                        text1: 'Patient_login_screen.text1'.tr(),
                        text2: 'Patient_login_screen.text2'.tr(),
                        screen: PatientRegestrationScreen()),
                    SizedBox(height: context.getHeight(divide: 15)),
                    BlocListener<AuthBloc, AuthStatee>(
                      listener: (context, state) {
                        if (state is PatientLoginSuccessState) {
                          final Patient currentPatient = state.currentPatient;
                          globalCurrentPatient = state.currentPatient;
                          context.removeUnitl(PatientHomeView(
                            patient: currentPatient,
                          ));
                        } else if (state is ErrorState) {
                          if (state.stopLoading) {
                            context.popScreen();
                          }
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(state.message)));
                        } else if (state is LoadingState) {
                          showLoadingDialog(context);
                        }
                      },
                      child: Center(
                        child: AuthButton(
                            buttonText: 'Patient_login_screen.buttonText'.tr(),
                            onPressed: () {
                              context.read<AuthBloc>().add(PatientLoginEvent(
                                  email: controllerEmail.text.trim(),
                                  password: controllerPassword.text.trim()));
                            },
                            buttonColor: theRed),
                      ),
                    )
                  ]),
            ),
          )),
    );
  }
}
