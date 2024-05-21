import 'package:equatable/equatable.dart';

class DatePickerState extends Equatable {
  final String startDate;
  final String endDate;

  const DatePickerState({required this.startDate, required this.endDate});

  DatePickerState copyWith({
    String? startDate,
    String? endDate,
  }) => DatePickerState(
    startDate: startDate ?? this.startDate,
    endDate: endDate ?? this.endDate,
  );

  @override
  List<Object?> get props => [startDate, endDate];
}

