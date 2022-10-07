import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_calcs/pages/airflow_vel/bloc/total_pressure/total_p_bloc.dart';
import 'package:flutter_calcs/pages/airflow_vel/bloc/velocity_of_air/vel_air_bloc.dart';
import 'package:flutter_calcs/pages/airflow_vel/bloc/vol_flow/vol_flow_bloc.dart';
import 'package:flutter_calcs/providers/button_state.dart';
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
      ],
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider<AirButtonProvider>(
              create: (context) => AirButtonProvider())
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
