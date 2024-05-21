part of 'page_index_bloc.dart';

abstract class PageIndexEvent extends Equatable {
  const PageIndexEvent();
}
class PageChanged extends PageIndexEvent {
  final int index;
  const PageChanged({required this.index});

  @override
  // TODO: implement props
  List<Object?> get props => [index];
}


