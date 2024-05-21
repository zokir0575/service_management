import 'package:bloc/bloc.dart';

import 'date_picker_event.dart';
import 'date_picker_state.dart';


class DatePickerBloc extends Bloc<DatePickerEvent, DatePickerState> {
  DatePickerBloc() : super(const DatePickerState(startDate: '', endDate: '')) {
    on<PickedStartDate>((event, emit) {
      emit(state.copyWith(startDate: event.date));
    });

    on<PickedEndDate>((event, emit) {
      emit(state.copyWith(endDate: event.date));
    });
  }
}
