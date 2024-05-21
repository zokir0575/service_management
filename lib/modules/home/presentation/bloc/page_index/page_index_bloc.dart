import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'page_index_event.dart';
part 'page_index_state.dart';

class PageIndexBloc extends Bloc<PageIndexEvent, PageIndexState> {
  PageIndexBloc() : super(const PageIndexState(pageIndex: 0)) {
    on<PageChanged>((event, emit) {
      emit(state.copyWith(pageIndex: event.index));
    });
  }
}
