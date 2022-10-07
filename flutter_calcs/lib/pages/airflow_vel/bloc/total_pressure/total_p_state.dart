part of 'total_p_bloc.dart';

@immutable
abstract class TotalPressureCalcState {}

// ignore: must_be_immutable
class TotalPressureDataState extends TotalPressureCalcState {
  double answer;
  TotalPressureDataState({required this.answer});
}
