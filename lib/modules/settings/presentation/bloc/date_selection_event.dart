part of 'date_selection_bloc.dart';

@immutable
abstract class DateSelectionEvent extends Equatable{}


class SelectedDate extends DateSelectionEvent {
  final DateTime date;

   SelectedDate({required this.date});

  @override
  List<Object?> get props => [date];
}

