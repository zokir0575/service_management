
import 'package:equatable/equatable.dart';

class ChipEntity extends Equatable{
  final String image;
  final String title;
  bool isClicked;

    ChipEntity({  this.image= '', this.isClicked = false,   this.title = ''});
  @override
  List<Object?> get props => [image,isClicked, title];

}