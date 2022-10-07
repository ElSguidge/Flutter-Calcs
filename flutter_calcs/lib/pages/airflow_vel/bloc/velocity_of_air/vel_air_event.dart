part of 'vel_air_bloc.dart';

@immutable
abstract class VelocityEvent {}

class InitialVelocityEvent extends VelocityEvent {}

// ignore: must_be_immutable
class StandardAirEvent extends VelocityEvent {
  double velocity;
  StandardAirEvent({required this.velocity});
}

// ignore: must_be_immutable
class AirDensityEvent extends VelocityEvent {
  double velocity;
  double airDensity;
  AirDensityEvent({required this.velocity, required this.airDensity});
}
