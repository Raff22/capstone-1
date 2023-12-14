import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_card/bloc/auth/auth_bloc.dart';
import 'package:health_card/bloc/auth/auth_event.dart';
import 'package:health_card/bloc/auth/auth_statee.dart';
import 'package:health_card/consts/colors.dart';
import 'package:health_card/consts/layout.dart';
import 'package:health_card/global/global_widgets/text_widget.dart';
import 'package:health_card/utilities/extentions/navigation_extentions.dart';
import 'package:health_card/utilities/extentions/size_extentions.dart';
import 'package:health_card/views/auth_views/auth_widgets/auth_button_widget.dart';
import 'package:health_card/views/auth_views/paramedic_regestraion_screen.dart';
import 'package:health_card/views/auth_views/patient_login_screen.dart';
import 'package:health_card/views/intro_views/intro_widgets/user_type_widget.dart';

class SelectUserScreen extends StatelessWidget {
  const SelectUserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: white,
        body: SafeArea(
          child: Center(
            child: Column(
              children: [
                SizedBox(height: context.getHeight(divide: 13)),
                const UserType(isPatient: false),
                height10,
                TextWidget(
                    text: 'user_type_screen.userSelection1'.tr(),
                    fontSizeText: 20),
                SizedBox(height: context.getHeight(divide: 20)),
                const UserType(isPatient: true),
                height10,
                TextWidget(
                    text: 'user_type_screen.userSelection2'.tr(),
                    fontSizeText: 20),
                SizedBox(height: context.getHeight(divide: 10)),
                BlocListener<AuthBloc, AuthStatee>(
                  listener: (context, state) {
                    if (state is UserIsParamedicState) {
                      context.pushScreen(screen: ParamedicRegistrationScreen());
                    } else if (state is UserIsPatientState) {
                      context.pushScreen(screen: PatientLoginScreen());
                    }
                  },
                  child: AuthButton(
                    buttonText: 'user_type_screen.buttonText'.tr(),
                    onPressed: () {
                      context
                          .read<AuthBloc>()
                          .add(GetResultsOfSelectionEvent());
                    },
                    buttonColor: theRed,
                  ),
                ),
                AuthButton(
                  textColor: black,
                  buttonText: 'user_type_screen.buttonText2'.tr(),
                  onPressed: () {
                    if (context.locale.toString() == "en_US") {
                      context.setLocale(const Locale('ar', 'SA'));
                    } else {
                      context.setLocale(const Locale('en', 'US'));
                    }
                  },
                  buttonColor: const Color.fromARGB(255, 201, 200, 200),
                ),
              ],
            ),
          ),
        ));
  }
}
