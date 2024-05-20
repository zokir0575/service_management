import 'package:flutter/cupertino.dart';

class ButtonEntity{
  final String icon;
  final String title;
  final VoidCallback onTap;

  const ButtonEntity({required this.title,required this.onTap, required this.icon,});
}