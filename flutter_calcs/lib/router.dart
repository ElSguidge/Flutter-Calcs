import 'package:flutter/material.dart';
import 'package:flutter_calcs/constants/constants.dart' as routes;
import 'package:flutter_calcs/pages/air_temp/mix_air_enth.dart';
import 'package:flutter_calcs/pages/air_temp/oa_percent.dart';
import 'package:flutter_calcs/pages/airflow_vel/ach_ph.dart';
import 'package:flutter_calcs/pages/menus/air_home.dart';
import 'package:flutter_calcs/pages/air_temp/air_temp_convert.dart';
import 'package:flutter_calcs/pages/menus/air_temp.dart';
import 'package:flutter_calcs/pages/menus/airflow_vel.dart';
import 'package:flutter_calcs/pages/menus/calculators.dart';
import 'package:flutter_calcs/pages/commissioning_home.dart';
import 'package:flutter_calcs/pages/conversions.dart';
import 'package:flutter_calcs/pages/airflow_vel/duct_area.dart';
import 'package:flutter_calcs/pages/electrical_home.dart';
import 'package:flutter_calcs/pages/fan_eq.dart';
import 'package:flutter_calcs/pages/favorites_page.dart';
import 'package:flutter_calcs/pages/heat_transfer.dart';
import 'package:flutter_calcs/pages/homepage.dart';
import 'package:flutter_calcs/pages/hydronic_home.dart';
import 'package:flutter_calcs/pages/install_home.dart';
import 'package:flutter_calcs/pages/log_in.dart';
import 'package:flutter_calcs/pages/air_temp/mixed_air.dart';
import 'package:flutter_calcs/pages/opening_screen.dart';
import 'package:flutter_calcs/pages/register_page.dart';
import 'package:flutter_calcs/pages/sheave_eq.dart';
import 'package:flutter_calcs/pages/airflow_vel/total_pressure.dart';
import 'package:flutter_calcs/pages/airflow_vel/vel_air.dart';
import 'package:flutter_calcs/pages/airflow_vel/vol_flow_rate.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case routes.homeRoute:
      return MaterialPageRoute(builder: (_) => const HomePage());
    case routes.commissioningHome:
      return MaterialPageRoute(builder: (_) => CommissioningPage());
    case routes.calculators:
      return MaterialPageRoute(builder: (_) => CalculatorsHome());
    case routes.installHome:
      return MaterialPageRoute(builder: (_) => const InstallPage());
    case routes.conversions:
      return MaterialPageRoute(builder: (_) => const Conversions());
    case routes.air:
      return MaterialPageRoute(builder: (_) => const Air());
    case routes.hydronic:
      return MaterialPageRoute(builder: (_) => const HydronicHome());
    case routes.electrical:
      return MaterialPageRoute(builder: (_) => const ElectricalHome());
    case routes.airflowVel:
      return MaterialPageRoute(builder: (_) => const AirFlowVelMenu());
    case routes.airTemp:
      return MaterialPageRoute(builder: (_) => const AirTemp());
    case routes.heatTransfer:
      return MaterialPageRoute(builder: (_) => const HeatTransfer());
    case routes.fanEquations:
      return MaterialPageRoute(builder: (_) => const FanEquations());
    case routes.sheaveEquations:
      return MaterialPageRoute(builder: (_) => const SheaveEquations());
    case routes.totalPressure:
      return MaterialPageRoute(builder: (_) => const TotalPressure());
    case routes.ductArea:
      return MaterialPageRoute(builder: (_) => const DuctArea());
    case routes.openingView:
      return MaterialPageRoute(builder: (_) => const OpeningView());
    case routes.registerPage:
      return MaterialPageRoute(builder: (_) => const RegisterPage());
    case routes.logIn:
      return MaterialPageRoute(builder: (_) => const LoginPage());
    case routes.favoritePage:
      return MaterialPageRoute(builder: (_) => const FavoritePage());
    case routes.volFlowRate:
      return MaterialPageRoute(builder: (_) => const VolFlowRate());
    case routes.velOfAir:
      return MaterialPageRoute(builder: (_) => const VelocityAir());
    case routes.airChange:
      return MaterialPageRoute(builder: (_) => const AirChangesPh());
    case routes.airTempConvert:
      return MaterialPageRoute(builder: (_) => const AirTempConvert());
    case routes.mixedAirTemp:
      return MaterialPageRoute(builder: (_) => const MixedAir());
    case routes.mixedAirTempEnthalpy:
      return MaterialPageRoute(builder: (_) => const MixedAirEnthalpy());
    case routes.outsideAirPer:
      return MaterialPageRoute(builder: (_) => const OutsideAirPercentage());

    default:
      return MaterialPageRoute(
        builder: (_) => Scaffold(
          body: Center(child: Text('No route defined for ${settings.name}')),
        ),
      );
  }
}
