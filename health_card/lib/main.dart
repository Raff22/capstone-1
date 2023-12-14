import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:health_card/bloc/auth/auth_bloc.dart';
import 'package:health_card/bloc/patient_bloc/patient_bloc.dart';
import 'package:health_card/consts/colors.dart';
import 'package:health_card/database/supa_get_delete/supa_get_delete.dart';
import 'package:health_card/views/intro_views/splash_screen.dart';
import 'package:health_card/views/mus3ef_screens/mus3ef_blocs/front_digram_blocs/bloc/front_digram_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await dotenv.load(fileName: ".env");
  supaInitializer();
  runApp(EasyLocalization(
      supportedLocales: const [Locale('ar', 'SA'), Locale('en', 'US')],
      path:
          'assets/translations', // <-- change the path of the translation files
      fallbackLocale: const Locale('ar', 'SA'),
      child: const MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) => AuthBloc(),
        ),
        BlocProvider<PatientBloc>(
          create: (context) => PatientBloc(),
        ),
        BlocProvider<FrontBodyBloc>(
          // Add your FrontBodyDiagramBloc
          create: (context) => FrontBodyBloc(SupaGetAndDelete()),
        ),
      ],
      child: MaterialApp(
          theme: ThemeData(
              fontFamily: 'Tajawal',
              iconTheme: const IconThemeData(color: red2),
              iconButtonTheme: const IconButtonThemeData(
                  style:
                      ButtonStyle(iconColor: MaterialStatePropertyAll(red2)))),
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          debugShowCheckedModeBanner: false,
          home: const SplashScreen()),
    );
  }
}
