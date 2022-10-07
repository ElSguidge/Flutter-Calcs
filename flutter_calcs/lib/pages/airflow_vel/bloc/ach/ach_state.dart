part of 'ach_bloc.dart';

@immutable
abstract class AchState {}

// ignore: must_be_immutable
class AchDataState extends AchState {
  double? answer1;
  double? answer2;
  AchDataState({
    this.answer1,
    this.answer2,
  });
}
