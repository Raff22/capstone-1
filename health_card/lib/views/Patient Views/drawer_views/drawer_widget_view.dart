import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_card/bloc/auth/auth_bloc.dart';
import 'package:health_card/bloc/auth/auth_event.dart';
import 'package:health_card/bloc/auth/auth_statee.dart';
import 'package:health_card/bloc/patient_bloc/patient_bloc.dart';
import 'package:health_card/bloc/patient_bloc/patient_event.dart';
import 'package:health_card/bloc/patient_bloc/patient_state.dart';
import 'package:health_card/consts/colors.dart';
import 'package:health_card/consts/layout.dart';
import 'package:health_card/global/global_widgets/text_widget.dart';
import 'package:health_card/global/globals.dart';
import 'package:health_card/models/patient_model.dart';
import 'package:health_card/utilities/extentions/navigation_extentions.dart';
import 'package:health_card/utilities/extentions/size_extentions.dart';
import 'package:health_card/utilities/functions/signout_dialog.dart';
import 'package:health_card/views/Patient%20Views/Drawer_views/drawer_view_widget/drawer_account_view.dart';
import 'package:health_card/views/Patient%20Views/Drawer_views/drawer_view_widget/drawer_content.dart';
import 'package:health_card/views/Patient%20Views/drawer_views/drawer_view_widget/drawer_emergency_contact_view.dart';
import 'package:health_card/views/Patient%20Views/drawer_views/drawer_view_widget/drawer_insurance.dart';
import 'package:health_card/views/intro_views/splash_screen.dart';
import 'package:image_picker/image_picker.dart';

class DrawerWidgetView extends StatelessWidget {
  const DrawerWidgetView({super.key, required this.patient});

  final Patient patient;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 100, horizontal: 20),
        child: Column(
          children: [
            InkWell(
              onTap: () async {
                File image;
                final ImagePicker picker = ImagePicker();
                final pickedFile =
                    await picker.pickImage(source: ImageSource.gallery);
                if (pickedFile != null) {
                  image = File(pickedFile.path);
                  //print(image.path);
                  context.read<PatientBloc>().add(UploadProfilePictureEvent(
                      imageFile: image, patient: patient));
                }
              },
              child: BlocBuilder<PatientBloc, PatientBlocSatet>(
                builder: (context, state) {
                  if (state is LoadingPatientaState) {
                    return const Center(
                        child: CircularProgressIndicator(color: red2));
                  }
                  return ClipOval(
                    child: (profileImage == null || profileImage!.isEmpty)
                        ? Image.asset(
                            'assets/images/profile_pic.png',
                            height: 100,
                            width: 100,
                          )
                        : CachedNetworkImage(
                            imageUrl: profileImage!,
                            // placeholder: (context, url) =>
                            //     const CircularProgressIndicator(color: white),
                            height: 100,
                            width: 100,
                          ),
                  );
                },
              ),
            ),
            height10,
            TextWidget(
              text: globalCurrentPatient!.fullName!,
              fontSizeText: 20,
            ),
            height10,
            const Divider(
              color: red2,
            ),
            SizedBox(
              height: context.getHeight(divide: 1.80),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      DrawerContent(
                        rowTitle: 'drawer_widget.account'.tr(),
                        icon: Icons.account_circle_outlined,
                        // swichWidget: Container(),
                        onPressd: () {
                          context.pushScreen(
                              screen: DrawerAccountView(
                            patient: patient,
                          ));
                        },
                      ),
                      BlocListener<PatientBloc, PatientBlocSatet>(
                        listener: (context, state) {
                          if (state is BringContactListState) {
                            context.pushScreen(
                                screen: DrawerEmergencyContactView(
                              patient: patient,
                              contactList: state.contacts,
                            ));
                          }
                        },
                        child: DrawerContent(
                          rowTitle: 'drawer_widget.emergency_contact'.tr(),
                          icon: Icons.emergency_outlined,
                          // swichWidget: Container(),
                          onPressd: () {
                            context.read<PatientBloc>().add(
                                GetEmergencyContactEvent(patient: patient));
                          },
                        ),
                      ),
                      DrawerContent(
                        rowTitle: 'insurance_drawer.title'.tr(),
                        icon: Icons.contact_emergency_outlined,
                        // swichWidget: Container(),
                        onPressd: () {
                          context.pushScreen(
                              screen: MyInsuranceView(patient: patient));

                          context
                              .read<PatientBloc>()
                              .add(GetInsuranceEvent(patient));
                        },
                      ),
                      DrawerContent(
                        rowTitle: 'drawer_widget.language'.tr(),
                        icon: Icons.g_translate_outlined,
                        convertIcon: Icons.change_circle_outlined,
                        onTap: () {
                          if (context.locale.toString() == "en_US") {
                            context.setLocale(const Locale('ar', 'SA'));
                          } else {
                            context.setLocale(const Locale('en', 'US'));
                          }
                        },
                      ),
                      height10,
                    ],
                  ),
                  Column(
                    children: [
                      BlocListener<AuthBloc, AuthStatee>(
                        listener: (context, state) {
                          if (state is SignOutState) {
                            context.removeUnitl(const SplashScreen());
                          }
                        },
                        child: DrawerContent(
                          rowTitle: 'drawer_widget.signout'.tr(),
                          icon: Icons.logout,
                          // swichWidget: Container(),
                          onPressd: () {
                            signOutAlert(
                                context: context,
                                content: '',
                                onPressed: () {
                                  context.read<AuthBloc>().add(SignOutEvent());
                                  context.popScreen();
                                });
                          },
                        ),
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
