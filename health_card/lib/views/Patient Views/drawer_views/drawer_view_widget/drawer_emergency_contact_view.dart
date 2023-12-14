// ignore_for_file: must_be_immutable

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_card/app_data/data.dart';
import 'package:health_card/bloc/patient_bloc/patient_bloc.dart';
import 'package:health_card/bloc/patient_bloc/patient_event.dart';
import 'package:health_card/bloc/patient_bloc/patient_state.dart';
import 'package:health_card/consts/colors.dart';
import 'package:health_card/consts/layout.dart';
import 'package:health_card/global/global_widgets/app_bar_widget.dart';
import 'package:health_card/global/global_widgets/drop_down_widget.dart';
import 'package:health_card/global/global_widgets/text_field_widget.dart';
import 'package:health_card/global/global_widgets/text_widget.dart';
import 'package:health_card/global/globals.dart';
import 'package:health_card/models/EmergencyContact_model.dart';
import 'package:health_card/models/patient_model.dart';
import 'package:health_card/utilities/extentions/navigation_extentions.dart';
import 'package:health_card/utilities/extentions/size_extentions.dart';
import 'package:health_card/utilities/functions/delete_dialoge.dart';
import 'package:health_card/utilities/functions/loading_func.dart';
import 'package:url_launcher/url_launcher.dart';

final dropdownBloodTypeFormKey2 = GlobalKey<FormState>();
final dropdownRelationshipToPatientFormKey2 = GlobalKey<FormState>();

class DrawerEmergencyContactView extends StatelessWidget {
  DrawerEmergencyContactView(
      {super.key, required this.patient, required this.contactList});
  final Patient patient;
  List<EmergencyContact> contactList;

  TextEditingController emergencyNameController = TextEditingController();
  TextEditingController emergencyPhoneController = TextEditingController();
  String? relationship;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarWidget(
          context,
          'drawer_emergency_contact.title_screen'.tr(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: BlocListener<PatientBloc, PatientBlocSatet>(
              listener: (context, state) {
                if (state is ErrorPatientaState) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text(state.message)));
                }
              },
              child: InkWell(
                onTap: () {
                  final EmergencyContact emergencyContact = EmergencyContact(
                      name: emergencyNameController.text,
                      phoneNumber: emergencyPhoneController.text,
                      relationshipType: relationship);

                  context
                      .read<PatientBloc>()
                      .add(AddEmergencyContactEvent(emergencyContact, patient));

                  emergencyNameController.clear();
                  emergencyPhoneController.clear();
                },
                child: TextWidget(
                  text: 'drawer_emergency_contact.save'.tr(),
                  colorText: red2,
                  fontSizeText: 18,
                  fontWeightText: FontWeight.w500,
                ),
              ),
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextWidget(
                  text: 'drawer_emergency_contact.title_screen'.tr(),
                  fontWeightText: FontWeight.w500,
                  fontSizeText: 20,
                ),
                height8,
                TextWidget(
                    text:
                        'drawer_emergency_contact.hint_title_emergency_contact'
                            .tr()),
                height18,
                TextFieldWidget(
                    controller: emergencyNameController,
                    labelText: 'drawer_emergency_contact.emergency_name'.tr()),
                height18,
                TextFieldWidget(
                    controller: emergencyPhoneController,
                    labelText: 'drawer_emergency_contact.emergency_phone'.tr()),
                height18,
                DropDownWidget(
                  dropdownFormKey: dropdownRelationshipToPatientFormKey2,
                  hintTextDropDownMenu:
                      'drawer_emergency_contact.relation'.tr(),
                  dropdownItems: relationshipToPatient,
                  onSelect: (newValue) {
                    relationship = newValue!;
                  },
                ),
                height26,
                BlocBuilder<PatientBloc, PatientBlocSatet>(
                  builder: (context, state) {
                    if (state is UpdateContactListState) {
                      contactList = state.contacts;
                    }
                    if (state is LoadingPatientaState) {
                      return const Center(
                          child: CircularProgressIndicator(color: theRed));
                    }
                    return SizedBox(
                      height: context.getWidth(),
                      width: context.getWidth(),
                      child: ListView.builder(
                        itemCount: contactList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Dismissible(
                              key: const Key("index"),
                              confirmDismiss: (direction) async {
                                final x = await deleteAlert(
                                    context: context,
                                    content: contactList[index].name!,
                                    onPressed: () {
                                      context.read<PatientBloc>().add(
                                          DeleteEmergenceyContact(
                                              contactID: contactList[index].id!,
                                              patientId: patient.id!));
                                      context.popScreen();
                                    });
                                return Future.value(x == 'cancel');
                              },
                              child:
                                  ContactWidget(contact: contactList[index]));
                        },
                      ),
                    );
                  },
                )
              ],
            ),
          ),
        ));
  }
}

class ContactWidget extends StatelessWidget {
  const ContactWidget({
    super.key,
    required this.contact,
  });

  final EmergencyContact contact;

  @override
  Widget build(BuildContext context) {
    return Card(
        color: white,
        child: ListTile(
          title: TextWidget(
            text: contact.name!,
            fontSizeText: 25,
            fontWeightText: FontWeight.bold,
          ),
          subtitle: TextWidget(text: contact.phoneNumber!, fontSizeText: 20),
          trailing: IconButton(
              onPressed: () async {
                // replace with the actual phone number
                Uri uri = Uri.parse('tel:${contact.phoneNumber!}');
                if (!await launchUrl(uri)) {
                  debugPrint('Could not launch $uri');
                }
              },
              icon: const Icon(size: 30, Icons.phone, color: theRed)),
        ));
  }
}
