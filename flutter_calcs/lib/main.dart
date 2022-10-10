import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_calcs/pages/air_temp/bloc/air_temp/air_temp_bloc.dart';
import 'package:flutter_calcs/pages/air_temp/bloc/mixed_air/mixed_air_bloc.dart';
import 'package:flutter_calcs/pages/airflow_vel/bloc/ach/ach_bloc.dart';
import 'package:flutter_calcs/pages/airflow_vel/bloc/area/area_bloc.dart';
import 'package:flutter_calcs/pages/airflow_vel/bloc/total_pressure/total_p_bloc.dart';
import 'package:flutter_calcs/pages/airflow_vel/bloc/velocity_of_air/vel_air_bloc.dart';
import 'package:flutter_calcs/pages/airflow_vel/bloc/vol_flow/vol_flow_bloc.dart';
import 'package:flutter_calcs/providers/air_temp_buttons.dart';
import 'package:flutter_calcs/providers/airflow_button_state.dart';
import 'package:flutter_calcs/providers/area_button_state.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:flutter_calcs/constants/constants.dart';
import 'package:flutter_calcs/router.dart' as router;
import 'package:provider/provider.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => VelBloc(),
        ),
        BlocProvider(
          create: (context) => TotalPressureBloc(),
        ),
        BlocProvider(
          create: (context) => VolumeBloc(),
        ),
        BlocProvider(
          create: (context) => AchBloc(),
        ),
        BlocProvider(
          create: (context) => AreaBloc(),
        ),
        BlocProvider(
          create: (context) => AirTempBloc(),
        ),
        BlocProvider(
          create: (context) => MixedAirTempBloc(),
        ),
      ],
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider<AirFlowButtonProvider>(
              create: (context) => AirFlowButtonProvider()),
          ChangeNotifierProvider<AreaButtonProvider>(
              create: (context) => AreaButtonProvider()),
          ChangeNotifierProvider<AirTempButtons>(
              create: (context) => AirTempButtons())
        ],
        child: const MaterialApp(
          debugShowCheckedModeBanner: false,
          onGenerateRoute: router.generateRoute,
          initialRoute: openingView,
          // theme: ThemeData(
          //   primarySwatch: Colors.blue,
          //   scaffoldBackgroundColor: Colors.black,
          // ),
        ),
      ),
    );
  }
}
