import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_card/bloc/auth/auth_bloc.dart';
import 'package:health_card/bloc/auth/auth_event.dart';
import 'package:health_card/bloc/auth/auth_statee.dart';
import 'package:health_card/consts/colors.dart';
import 'package:health_card/consts/layout.dart';
import 'package:health_card/utilities/extentions/navigation_extentions.dart';
import 'package:health_card/utilities/functions/loading_func.dart';
import 'package:health_card/views/auth_views/auth_widgets/auth_button_widget.dart';
import 'package:health_card/views/auth_views/patient_login_screen.dart';
import 'package:pinput/pinput.dart';

class OTPScreen extends StatelessWidget {
  const OTPScreen({super.key, required this.email, required this.isPatient});
  final String email;
  final bool isPatient;
  @override
  Widget build(BuildContext context) {
    String otp = "";
    return Scaffold(
      backgroundColor: white,
      body: Container(
        margin: const EdgeInsets.only(left: 25, right: 25),
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "OTP",
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
              ),
              height10,
              Text(
                "${'otpscreen.message'.tr()} $email",
                style: const TextStyle(
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
              height30,
              Pinput(
                length: 6,
                showCursor: true,
                onCompleted: (pin) => otp = pin,
              ),
              height22,
              BlocListener<AuthBloc, AuthStatee>(
                listener: (context, state) {
                  if (state is VerficationSuccessState) {
                    context.removeUnitl(PatientLoginScreen());
                  } else if (state is ErrorState) {
                    context.popScreen();
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text(state.message)));
                  } else if (state is LoadingState) {
                    showLoadingDialog(context);
                  }
                },
                child: AuthButton(
                    buttonText: 'otpscreen.buttonText'.tr(),
                    onPressed: () {
                      context.read<AuthBloc>().add(VerficationEvent(pin: otp));
                    },
                    buttonColor: red2),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
