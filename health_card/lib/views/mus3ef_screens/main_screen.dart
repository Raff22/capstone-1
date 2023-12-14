import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_card/bloc/patient_bloc/patient_bloc.dart';
import 'package:health_card/bloc/patient_bloc/patient_event.dart';
import 'package:health_card/database/supa_get_delete/supa_get_delete.dart';
import 'package:health_card/utilities/extentions/size_extentions.dart';
import 'package:health_card/views/mus3ef_screens/custom_wedgets/main_screen_coustom_wedget.dart';
import 'package:health_card/views/mus3ef_screens/custom_wedgets/table_wdget.dart';
import 'package:health_card/views/mus3ef_screens/main_screen/part_screens/doctor_view/doctor_view.dart';
import 'package:health_card/views/mus3ef_screens/main_screen/part_screens/medic_view/medic_view.dart';
import 'package:health_card/views/mus3ef_screens/main_screen/part_screens/medsin_view/medication_screen.dart';
import 'package:health_card/views/mus3ef_screens/main_screen/part_screens/sergury_view/sergury_view.dart';
import 'package:health_card/views/mus3ef_screens/mus3ef_blocs/main_screen_bloc/main_scrren_bloc.dart';
import 'package:health_card/views/mus3ef_screens/mus3ef_blocs/main_screen_bloc/main_scrren_event.dart';
import 'package:health_card/views/mus3ef_screens/mus3ef_blocs/main_screen_bloc/main_scrren_state%20copy.dart';
import 'package:url_launcher/url_launcher.dart';

class MainScreen extends StatelessWidget {
  final String idText;

  const MainScreen({Key? key, required this.idText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<SupaGetAndDelete>(
        create: (context) => SupaGetAndDelete(),
        child: BlocProvider(
          create: (context) => MainScreenBloc(
            RepositoryProvider.of<SupaGetAndDelete>(context),
          )..add(LoadPatientDataEvent(idText)),
          child: Scaffold(
            body: BlocBuilder<MainScreenBloc, MainScreenState>(
              builder: (context, state) {
                if (state is MainScreenLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is MainScreenLoaded) {
                  return buildLoadedScreen(state, context);
                } else if (state is MainScreenError) {
                  return const Center(child: Text('Error loading data'));
                } else {
                  return const Center(child: Text('Something went wrong'));
                }
              },
            ),
          ),
        ));
  }

  Widget buildLoadedScreen(MainScreenLoaded state, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Scaffold(
          extendBody: true,
          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  width: 440,
                  height: 1000,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 40,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          IconButton(
                            onPressed: () {
                              if (context.locale.toString() == "en_US") {
                                context.setLocale(const Locale('ar', 'SA'));
                              } else {
                                context.setLocale(const Locale('en', 'US'));
                              }
                            },
                            icon: const Icon(
                              Icons.g_translate_outlined,
                              color: Color.fromARGB(255, 160, 9, 9),
                            ),
                            color: Colors.black,
                            iconSize: 40,
                          ),
                          Text(
                            'main_screen.toptitle'.tr(),
                            style: const TextStyle(fontSize: 30),
                          ),
                          Container(
                              height: context.getHeight(
                                divide: 20,
                              ),
                              width: context.getWidth(divide: 9),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(70),
                                color: const Color.fromARGB(255, 160, 9, 9),
                              ),
                              child: IconButton(
                                onPressed: () async {
                                  const phoneNumber =
                                      '${0555924040}'; // replace with the actual phone number
                                  const uri = 'tel:$phoneNumber';
                                  if (await canLaunch(uri)) {
                                    await launch(uri);
                                  } else {
                                    // You can show an error or a message if the phone call can't be made
                                    print('Could not launch $uri');
                                  }
                                },
                                icon: const Icon(
                                  Icons.call,
                                  color: Colors.white,
                                ),
                                color: Colors.black,
                                iconSize: 30,
                              ))
                        ],
                      ),
                      const SizedBox(
                        height: 22,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          imageprofile(path: "${state.personalInfo.image}"),
                          Column(
                            children: [
                              Text(
                                'main_screen.nametext'.tr(),
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                state.patient.fullName.toString(),
                                style: const TextStyle(
                                    fontSize: 20, color: Colors.blue),
                              ),
                              const mySpacer(),
                              Text(
                                'main_screen.bloodtext'.tr(),
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                state.personalInfo.bloodType ?? "",
                                style: const TextStyle(
                                    fontSize: 20, color: Colors.red),
                              ),
                              const mySpacer(),
                              Text(
                                'main_screen.IDtext'.tr(),
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                state.personalInfo.nationalId ?? "",
                                style: const TextStyle(
                                    fontSize: 20, color: Colors.blue),
                              ),
                            ],
                          )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 40, right: 40, top: 20, bottom: 20),
                        child: TableCard(
                          birthday: state.personalInfo.birthday ?? "",
                          bloodType: state.personalInfo.bloodType ?? "",
                          height: "${state.personalInfo.height ?? ""}",
                          weight: "${state.personalInfo.weight ?? ""}",
                        ),
                      ),
                      pationtCard(
                          imgpath: "assets/images/my_doctor.png",
                          title: 'main_screen.doctortext'.tr(),
                          pathfunc: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DoctorView(
                                          patientId: idText,
                                        )));
                          }),
                      pationtCard(
                        imgpath: "assets/images/my_medications.png",
                        title: 'main_screen.medicinetext'.tr(),
                        pathfunc: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MedicationScreen(
                                        patientId: state.patient.id!,
                                      )));
                        },
                      ),
                      pationtCard(
                        imgpath: "assets/images/medical_information.png",
                        title: 'main_screen.medicrep'.tr(),
                        pathfunc: () {
                          context.read<PatientBloc>().add(GetdataEvent(
                                state.patient.id!,
                                state.patient,
                                "Medical Information",
                              ));

                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const MedicView()));
                        },
                      ),
                      pationtCard(
                        imgpath: "assets/images/surgical_record.png",
                        title: 'main_screen.title'.tr(),
                        pathfunc: () {
                          context.read<PatientBloc>().add(GetdataEvent(
                                state.patient.id!,
                                state.patient,
                                "Surgical Record",
                              ));
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SerguryView()));
                        },
                      )
                    ],
                  ),
                )
              ],
            ),
          )),
    );
  }
}
