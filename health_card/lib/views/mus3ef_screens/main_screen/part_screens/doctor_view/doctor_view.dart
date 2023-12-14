import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:health_card/consts/colors.dart';
import 'package:health_card/consts/layout.dart';
import 'package:health_card/database/supa_get_delete/supa_get_delete.dart';
import 'package:health_card/global/global_widgets/app_bar_widget.dart';
import 'package:health_card/global/global_widgets/container_widget.dart';
import 'package:health_card/global/global_widgets/text_widget.dart';
import 'package:health_card/global/globals.dart';
import 'package:health_card/models/patient_model.dart';
import 'package:health_card/models/doctor_model.dart';
import 'package:health_card/utilities/extentions/size_extentions.dart';
import 'package:health_card/views/mus3ef_screens/main_screen/part_screens/doctor_view/doctor_widgets.dart';

class DoctorView extends StatefulWidget {
  const DoctorView({Key? key, required this.patientId}) : super(key: key);
  final String patientId;

  @override
  _DoctorViewState createState() => _DoctorViewState();
}

class _DoctorViewState extends State<DoctorView> {
  Patient? currentPatient;
  Doctor? currentDoctor;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadPatientAndDoctorData();
  }

  Future<void> loadPatientAndDoctorData() async {
    try {
      // Load patient data
      var patient = await SupaGetAndDelete()
          .getPatientById(widget.patientId); // Replace with actual patient ID
      Doctor? doctor;
      if (patient != null && patient.doctorId != null) {
        // Load doctor data
        doctor = await SupaGetAndDelete().getDoctorById(patient.doctorId!);
      }
      // Call setState to update the UI
      setState(() {
        currentPatient = patient;
        currentDoctor = doctor;
        isLoading = false;
      });
    } catch (error) {
      setState(() => isLoading = false);
      // Handle any errors here, such as showing a dialog or a snackbar
      print('Error loading data: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      appBar: AppBarWidget(
          context, 'my_doctor_view.title_screen'.tr(), Container()),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: SizedBox(
            height: context.getHeight(),
            width: context.getWidth(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (currentPatient != null)
                  // TextWidget(text: 'Patient Name: ${currentPatient!.fullName}'),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.asset(
                          "assets/images/doctor.png",
                          height: 100,
                          width: 100,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const TextWidget(
                              text: 'Practice Name : ',
                              fontSizeText: 20,
                            ),
                            TextWidget(
                              text: '${currentDoctor!.name}',
                              fontSizeText: 18,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                height10,
                const Divider(),
                height10,
                TextWidget(
                  text: 'my_doctor_view.practice_id'.tr(),
                  fontSizeText: 18,
                ),
                const TextWidget(
                  text: '1808318',
                  fontSizeText: 18,
                  colorText: gray,
                ),
                height10,
                TextWidget(
                  text: 'my_doctor_view.practice_specialty'.tr(),
                  fontSizeText: 18,
                ),
                TextWidget(
                  text: '${currentDoctor!.speciality}',
                  fontSizeText: 18,
                  colorText: gray,
                ),
                height10,
                TextWidget(
                  text: 'my_doctor_view.practice_address'.tr(),
                  fontSizeText: 18,
                ),
                TextWidget(
                  text: '${currentDoctor!.address}',
                  fontSizeText: 18,
                  colorText: gray,
                ),
                height10,
                TextWidget(
                  text: 'my_doctor_view.practice_contact'.tr(),
                  fontSizeText: 18,
                ),
                TextWidget(
                  text: '${currentDoctor!.phone}',
                  fontSizeText: 18,
                  colorText: gray,
                ),
                TextWidget(
                  text: '${currentDoctor!.email}',
                  fontSizeText: 18,
                  colorText: gray,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
