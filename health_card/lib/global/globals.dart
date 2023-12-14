import 'package:health_card/models/doctor_model.dart';
import 'package:health_card/models/paramedic_model.dart';
import 'package:health_card/models/patient_model.dart';

bool userIsParamedic = false;
String scanBarcode = '';


Patient? globalCurrentPatient;
Paramedic? globalCurrentParamedic;
Doctor? globalCurrentDoctor;
String? profileImage;
