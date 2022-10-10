part of 'area_bloc.dart';

@immutable
abstract class AreaEvent {}

class InitialAreaEvent extends AreaEvent {}

// ignore: must_be_immutable
class RectangleArea extends AreaEvent {
  double height;
  double width;

  RectangleArea({
    required this.height,
    required this.width,
  });
}

// ignore: must_be_immutable
class RoundArea extends AreaEvent {
  double diameter;

  RoundArea({required this.diameter});
}

// ignore: must_be_immutable
class FlatArea extends AreaEvent {
  double flatWidth;
  double flatHeight;

  FlatArea({
    required this.flatHeight,
    required this.flatWidth,
  });
}
