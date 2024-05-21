import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'date_selection_event.dart';
part 'date_selection_state.dart';

class DateSelectionBloc extends Bloc<DateSelectionEvent, DateSelectionState> {
  DateSelectionBloc() : super(const DateSelectionState(selectedDay: null)) {
    on<SelectedDate>((event, emit) {
      emit(state.copyWith(selectedDay: event.date));
    });
  }
}
