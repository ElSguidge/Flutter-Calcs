part of 'mixed_air_bloc.dart';

@immutable
abstract class MixedAirState {}

// ignore: must_be_immutable
class MixedAirDataState extends MixedAirState {
  double answer1;
  MixedAirDataState({
    required this.answer1,
  });
}
