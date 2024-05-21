import 'package:equatable/equatable.dart';

abstract class DatePickerEvent extends Equatable {
  const DatePickerEvent();

  @override
  List<Object?> get props => [];
}

class PickedStartDate extends DatePickerEvent {
  final String date;

  const PickedStartDate({required this.date});

  @override
  List<Object?> get props => [date];
}

class PickedEndDate extends DatePickerEvent {
  final String date;

  const PickedEndDate({required this.date});

  @override
  List<Object?> get props => [date];
}
