import 'package:equatable/equatable.dart';

class ChipEntity extends Equatable {
  final String image;
  final String title;
  final String date;

  const ChipEntity({this.date = '', this.image = '', this.title = ''});

  @override
  List<Object?> get props => [image, date, title];
}
