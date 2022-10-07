part of 'ach_bloc.dart';

@immutable
abstract class AchEvent {}

class InitialAchEvent extends AchEvent {}

// ignore: must_be_immutable
class VolumeKnown extends AchEvent {
  double roomVolume;
  double airflow;
  VolumeKnown({required this.roomVolume, required this.airflow});
}

// ignore: must_be_immutable
class CalculateVolume extends AchEvent {
  double height;
  double length;
  double width;
  double airflow;

  CalculateVolume(
      {required this.height,
      required this.width,
      required this.length,
      required this.airflow});
}
