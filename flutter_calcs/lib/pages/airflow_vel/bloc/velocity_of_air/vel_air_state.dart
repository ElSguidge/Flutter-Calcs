part of 'vel_air_bloc.dart';

@immutable
abstract class VelocityState {}

// ignore: must_be_immutable
class VelocityDataState extends VelocityState {
  double answer1;
  double answer2;
  VelocityDataState({required this.answer1, required this.answer2});
}
