part of 'total_p_bloc.dart';

@immutable
abstract class TotalPressureEvent {}

class InitialTotalPressureEvent extends TotalPressureEvent {}

// ignore: must_be_immutable
class AddPressureEvent extends TotalPressureEvent {
  double velocityPressure;
  double staticPressure;
  AddPressureEvent(
      {required this.velocityPressure, required this.staticPressure});
}
