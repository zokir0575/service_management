part of 'date_selection_bloc.dart';

  class DateSelectionState extends Equatable {
    final DateTime? selectedDay;

    const DateSelectionState({required this.selectedDay,  });

    DateSelectionState copyWith({
      DateTime? selectedDay,
     }) => DateSelectionState(
      selectedDay: selectedDay ?? this.selectedDay,
     );

    @override
    List<Object?> get props => [selectedDay,  ];
  }

