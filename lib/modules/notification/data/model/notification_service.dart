import 'package:json_annotation/json_annotation.dart';


 class NotificationServiceModel {
  final int id;
  final String image;
  final String date;
  final String price;
  bool isSwitched;

  NotificationServiceModel(
      {this.image = '',
      this.price = '',
      this.id = 0,
      this.isSwitched = true,
      this.date = ''});

  factory NotificationServiceModel.fromJson(Map<String, dynamic> json) {
    return NotificationServiceModel(
      id: json['id'] as int,
      image: json['image'] as String,
      date: json['date'] as String,
      price: json['price'] as String,
      isSwitched: (json['isSwitched'] as int) == 1,
    );
  }

  // Custom toJson method to handle boolean conversion
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'image': image,
      'date': date,
      'price': price,
      'isSwitched': isSwitched ? 1 : 0,
    };
  }
}
