part of 'vol_flow_bloc.dart';

@immutable
abstract class VolumeState {}

// ignore: must_be_immutable
class VolumeDataState extends VolumeState {
  double? answer1;
  double? answer2;
  double? answer2A;
  double? answer3;
  double? answer3A;
  double? answer4;
  double? answer4A;
  VolumeDataState(
      {this.answer1,
      this.answer2,
      this.answer3,
      this.answer4,
      this.answer2A,
      this.answer3A,
      this.answer4A});
}
