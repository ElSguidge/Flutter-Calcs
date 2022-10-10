part of 'area_bloc.dart';

@immutable
abstract class AreaState {}

// ignore: must_be_immutable
class AreaDataState extends AreaState {
  double? answer1;
  double? answer2;
  double? answer3;
  AreaDataState({
    this.answer1,
    this.answer2,
    this.answer3,
  });
}
