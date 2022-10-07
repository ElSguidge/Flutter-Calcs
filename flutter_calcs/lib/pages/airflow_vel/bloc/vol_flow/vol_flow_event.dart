part of 'vol_flow_bloc.dart';

@immutable
abstract class VolumeEvent {}

class InitialVolumeEvent extends VolumeEvent {}

// ignore: must_be_immutable
class AreaKnown extends VolumeEvent {
  double area;
  double velocity;
  AreaKnown({required this.area, required this.velocity});
}

// ignore: must_be_immutable
class RectangleArea extends VolumeEvent {
  double height;
  double width;
  double velocity;

  RectangleArea(
      {required this.height, required this.width, required this.velocity});
}

// ignore: must_be_immutable
class RoundArea extends VolumeEvent {
  double diameter;
  double velocity;

  RoundArea({required this.diameter, required this.velocity});
}

// ignore: must_be_immutable
class FlatArea extends VolumeEvent {
  double flatWidth;
  double flatHeight;
  double velocity;

  FlatArea(
      {required this.flatHeight,
      required this.flatWidth,
      required this.velocity});
}
