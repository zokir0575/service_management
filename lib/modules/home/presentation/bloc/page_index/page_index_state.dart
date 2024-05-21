part of 'page_index_bloc.dart';

  class PageIndexState extends Equatable {
    final int pageIndex;
  const PageIndexState({required this.pageIndex});
    PageIndexState copyWith({
      int? pageIndex,
     }) => PageIndexState(
      pageIndex: pageIndex ?? this.pageIndex,
     );
  @override
   List<Object?> get props => [pageIndex];
}

