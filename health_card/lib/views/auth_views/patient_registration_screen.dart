import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_card/bloc/auth/auth_bloc.dart';
import 'package:health_card/bloc/auth/auth_event.dart';
import 'package:health_card/bloc/auth/auth_statee.dart';
import 'package:health_card/consts/colors.dart';
import 'package:health_card/global/global_widgets/text_widget.dart';
import 'package:health_card/utilities/extentions/navigation_extentions.dart';
import 'package:health_card/utilities/extentions/size_extentions.dart';
import 'package:health_card/utilities/functions/loading_func.dart';
import 'package:health_card/views/auth_views/auth_widgets/auth_button_widget.dart';
import 'package:health_card/views/auth_views/auth_widgets/auth_richtext_widget.dart';
import 'package:health_card/views/auth_views/auth_widgets/auth_textfeild.dart';
import 'package:health_card/views/auth_views/otp_screen.dart';
import 'package:health_card/views/auth_views/patient_login_screen.dart';

class PatientRegestrationScreen extends StatelessWidget {
  PatientRegestrationScreen({super.key});
  final nameKey = GlobalKey<FormState>();
  final phoneKey = GlobalKey<FormState>();
  final emailKey = GlobalKey<FormState>();
  final passwordKey = GlobalKey<FormState>();
  final TextEditingController controllerName = TextEditingController();
  final TextEditingController controllerPhone = TextEditingController();
  final TextEditingController controllerEmail = TextEditingController();
  final TextEditingController controllerPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
                        text: 'Patient_regestraion_screen.title'.tr(),
                        colorText: red2,
                        fontWeightText: FontWeight.bold,
                        fontSizeText: 40),
                    AuthFelid(
                      controller: controllerName,
                      label: 'Patient_regestraion_screen.name'.tr(),
                      hint: 'Patient_regestraion_screen.nameHint'.tr(),
                      key: nameKey,
                    ),
                    AuthFelid(
                      controller: controllerPhone,
                      key: phoneKey,
                      label: 'Patient_regestraion_screen.phone'.tr(),
                      hint: 'Patient_regestraion_screen.phoneHint'.tr(),
                      sufixIcon: Icons.phone,
                      validator: (value) {
                        return null;
                      },
                    ),
                    AuthFelid(
                      label: 'Patient_regestraion_screen.email'.tr(),
                      hint: 'Patient_regestraion_screen.emailHint'.tr(),
                      controller: controllerEmail,
                      sufixIcon: Icons.email,
                      key: emailKey,
                    ),
                    AuthFelid(
                      controller: controllerPassword,
                      label: 'Patient_regestraion_screen.password'.tr(),
                      hint: 'Patient_regestraion_screen.passwordHint'.tr(),
                      key: passwordKey,
                      isPass: true,
                    ),
                    AuthRichText(
                        text1: 'Patient_regestraion_screen.text1'.tr(),
                        text2: 'Patient_regestraion_screen.text2'.tr(),
                        screen: PatientLoginScreen()),
                    SizedBox(height: context.getHeight(divide: 15)),
                    BlocListener<AuthBloc, AuthStatee>(
                      listener: (context, state) {
                        if (state is PatientRegisterationSuccessState) {
                          context.removeUnitl(OTPScreen(
                              email: controllerEmail.text.trim(),
                              isPatient: true));
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
                        buttonText:
                            'Patient_regestraion_screen.buttonText'.tr(),
                        onPressed: () {
                          context.read<AuthBloc>().add(
                              PatientRegisterationEvent(
                                  name: controllerName.text.trim(),
                                  email: controllerEmail.text.trim(),
                                  password: controllerPassword.text.trim(),
                                  phone: controllerPhone.text.trim()));
                        },
                        buttonColor: theRed,
                      )),
                    )
                  ]),
            ),
          )),
    );
  }
}

// validation({required GlobalKey<FormState> keyForm}) {
//   if (!keyForm.currentState!.validate()) {
//     return false;
//   }
//   return true;
// }
