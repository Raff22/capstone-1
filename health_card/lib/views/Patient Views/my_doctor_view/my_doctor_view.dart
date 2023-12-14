import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_card/bloc/patient_bloc/patient_bloc.dart';
import 'package:health_card/bloc/patient_bloc/patient_event.dart';
import 'package:health_card/bloc/patient_bloc/patient_state.dart';
import 'package:health_card/consts/colors.dart';
import 'package:health_card/consts/layout.dart';
import 'package:health_card/global/global_widgets/app_bar_widget.dart';
import 'package:health_card/global/global_widgets/text_widget.dart';
import 'package:health_card/models/doctor_model.dart';
import 'package:health_card/models/patient_model.dart';
import 'package:health_card/utilities/extentions/navigation_extentions.dart';
import 'package:health_card/utilities/extentions/size_extentions.dart';
import 'package:health_card/views/Patient%20Views/my_doctor_view/my_doctor_view_widget/doctor_picture.dart';
import 'package:health_card/views/Patient%20Views/my_doctor_view/my_doctor_view_widget/edit_my_doctor_info_view.dart';

class MyDoctorView extends StatelessWidget {
  const MyDoctorView({super.key, required this.patient});
  final Patient? patient;

  @override
  Widget build(BuildContext context) {
    Doctor doctor = Doctor();
    return Scaffold(
      appBar: AppBarWidget(
          context,
          'my_doctor_view.title_screen'.tr(),
          IconButton(
              onPressed: () {
                context.pushScreen(
                  screen: EditMyDoctorInfoView(
                    patient: patient!,
                    doctor: doctor,
                  ),
                  then: (p0) {
                    if (p0 == "back") {
                      context.read<PatientBloc>().add(
                          GetdataEvent(patient!.id!, patient!,'My Doctor', ));
                    }
                  },
                );
              },
              icon: const Icon(Icons.mode_edit_outlined))),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: SizedBox(
            height: context.getHeight(),
            width: context.getWidth(),
            child: BlocBuilder<PatientBloc, PatientBlocSatet>(
              builder: (context, state) {
                if (state is SucssessPatientDoctorState) {
                  if (state.doctor != null) {
                    doctor = state.doctor!;
                  }
                } else {
                  return const Center(
                    child: CircularProgressIndicator(color: red2),
                  );
                }
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DoctorPicture(
                      doctor: doctor,
                    ),
                    height10,
                    const Divider(),
                    height10,
                    TextWidget(
                      text: 'my_doctor_view.practice_specialty'.tr(),
                      fontSizeText: 18,
                    ),
                    TextWidget(
                      text: doctor.speciality ?? '',
                      fontSizeText: 18,
                      colorText: gray,
                    ),
                    height10,
                    TextWidget(
                      text: 'my_doctor_view.practice_address'.tr(),
                      fontSizeText: 18,
                    ),
                    TextWidget(
                      text: doctor.address ?? '',
                      fontSizeText: 18,
                      colorText: gray,
                    ),
                    height10,
                    TextWidget(
                      text: 'my_doctor_view.practice_contact'.tr(),
                      fontSizeText: 18,
                    ),
                    TextWidget(
                      text: doctor.phone ?? '',
                      fontSizeText: 18,
                      colorText: gray,
                    ),
                    TextWidget(
                      text: doctor.email ?? '',
                      fontSizeText: 18,
                      colorText: gray,
                    )
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
