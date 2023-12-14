import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_card/bloc/auth/auth_bloc.dart';
import 'package:health_card/bloc/auth/auth_event.dart';
import 'package:health_card/bloc/auth/auth_statee.dart';
import 'package:health_card/consts/colors.dart';
import 'package:health_card/global/global_widgets/text_widget.dart';
import 'package:health_card/global/globals.dart';
import 'package:health_card/utilities/extentions/navigation_extentions.dart';
import 'package:health_card/utilities/extentions/size_extentions.dart';
import 'package:health_card/utilities/functions/loading_func.dart';
import 'package:health_card/views/auth_views/auth_widgets/auth_button_widget.dart';
import 'package:health_card/views/mus3ef_screens/main_screen/part_screens/qr_code_screen.dart';

class ParamedicRegistrationScreen extends StatelessWidget {
  ParamedicRegistrationScreen({super.key});
  final moseefyPin = GlobalKey<FormState>();
  final TextEditingController pinController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: white,
          body: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/images/moseefy_logo.png',
                        width: 200, height: 200),
                    TextWidget(
                        text: 'ParamedicRegistrationScreen.title'.tr(),
                        colorText: black,
                        fontWeightText: FontWeight.bold,
                        fontSizeText: 30),
                    SizedBox(height: context.getHeight(divide: 20)),
                    MosseefyIdWidget(
                        myKey: moseefyPin, controller: pinController),
                    SizedBox(height: context.getHeight(divide: 10)),
                    BlocListener<AuthBloc, AuthStatee>(
                      listener: (context, state) {
                        if (state is ParamedicRegisterationSuccessState) {
                          globalCurrentParamedic = state.currUser;
                          context.removeUnitl(const BarCodeScanner());
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
                                'ParamedicRegistrationScreen.buttonText'.tr(),
                            onPressed: () {
                              context.read<AuthBloc>().add(
                                  ParamedicRegisterationEvent(
                                      moseefyID: pinController.text.trim()));
                            },
                            textColor: white,
                            buttonColor: theRed),
                      ),
                    ),
                    SizedBox(height: context.getHeight(divide: 30)),
                    TextWidget(
                      text: 'ParamedicRegistrationScreen.note'.tr(),
                      fontSizeText: 16,
                      fontWeightText: FontWeight.bold,
                    ),
                  ]),
            ),
          )),
    );
  }
}

class MosseefyIdWidget extends StatelessWidget {
  const MosseefyIdWidget(
      {super.key, required this.myKey, required this.controller});

  final GlobalKey myKey;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      child: Form(
        key: myKey,
        child: TextFormField(
          controller: controller,
          decoration: const InputDecoration(
              filled: true,
              fillColor: white,
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 2, color: Colors.grey),

                //<-- SEE HERE
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 2, color: Colors.grey),

                //<-- SEE HERE
              )),
          validator: (value) {
            return null;
          },
        ),
      ),
    );
  }
}
