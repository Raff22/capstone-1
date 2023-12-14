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
import 'package:health_card/models/insurance_model.dart';
import 'package:health_card/models/patient_model.dart';
import 'package:health_card/utilities/extentions/navigation_extentions.dart';
import 'package:health_card/utilities/extentions/size_extentions.dart';
import 'package:health_card/views/Patient%20Views/drawer_views/drawer_view_widget/edit_insurance.dart';

class MyInsuranceView extends StatelessWidget {
  const MyInsuranceView({super.key, required this.patient});
  final Patient? patient;

  @override
  Widget build(BuildContext context) {
    InsuranceModel insurance = InsuranceModel();
    return Scaffold(
      appBar: AppBarWidget(
          context,
          'insurance_drawer.app_title'.tr(),
          IconButton(
              onPressed: () {
               

                context.pushScreen(
                  screen: EditInsurance(
                    patient: patient!,
                    insurance: insurance,
                  ),
                  then: (p0) {
                    if (p0 == "back") {
                      context
                          .read<PatientBloc>()
                          .add(GetdataEvent(patient!.id!, patient!, ''));
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
                  // if (state is LoadingPatientaState) {
                  //   return const Center(child: CircularProgressIndicator());
                  // }
                  if (state is GetInsuranceState) {
                    if (state.insuranceModel != null) {
                      insurance = state.insuranceModel!;
                    }
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(color: red2),
                    );
                  }
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextWidget(
                        text: 'insurance_drawer.hint_title'.tr(),
                        fontWeightText: FontWeight.w500,
                        fontSizeText: 20,
                      ),
                      height10,
                      TextWidget(
                        text: 'insurance_drawer.company_name'.tr(),
                        fontSizeText: 18,
                      ),
                      TextWidget(
                        text: insurance.companyName ?? "",
                        fontSizeText: 18,
                        colorText: gray,
                      ),
                      height10,
                      TextWidget(
                        text: 'insurance_drawer.patient_insurens_id'.tr(),
                        fontSizeText: 18,
                      ),
                      TextWidget(
                        text: insurance.patientInsuranceId ?? "",
                        fontSizeText: 18,
                        colorText: gray,
                      ),
                      height10,
                      TextWidget(
                        text: 'insurance_drawer.coverage'.tr(),
                        fontSizeText: 18,
                      ),
                      TextWidget(
                        text: insurance.coverage ?? "",
                        fontSizeText: 18,
                        colorText: gray,
                      ),
                      height10,
                      TextWidget(
                        text: 'insurance_drawer.contact'.tr(),
                        fontSizeText: 18,
                      ),
                      TextWidget(
                        text: insurance.contacts ?? "",
                        fontSizeText: 18,
                        colorText: gray,
                      ),
                      height10,
                      TextWidget(
                        text: 'insurance_drawer.status'.tr(),
                        fontSizeText: 18,
                      ),
                      TextWidget(
                        text: insurance.status ?? "",
                        fontSizeText: 18,
                        colorText: gray,
                      )
                    ],
                  );
                },
              )),
        ),
      ),
    );
  }
}
