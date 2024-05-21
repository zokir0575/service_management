
import 'package:flutter/material.dart';
import 'package:service_app/assets/color/colors.dart';
import 'package:service_app/modules/home/data/model/service_model.dart';
import 'package:service_app/utils/functions.dart';
import 'package:service_app/utils/text_styles.dart';

class PaymentItem extends StatelessWidget {
  final ServiceModel model;
  final bool isToday;
  const PaymentItem({this.isToday = false, required this.model, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: isToday ? MediaQuery.sizeOf(context).width : null,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: whiteSmoke,
      ),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(text: TextSpan(
                  text: yearToMonthFormatter(model.end), style: darkStyle(context).copyWith(fontWeight: FontWeight.w500, fontSize: 12), children: [
                TextSpan( text: ' • ', style: greyStyle(context).copyWith(fontWeight: FontWeight.w500, fontSize: 12)),
                TextSpan( text: model.name, style: blueStyle(context).copyWith(fontWeight: FontWeight.w500, fontSize: 12)),
              ]
              )),
              const SizedBox(height: 4,),
              Text('\$${model.price}', style: darkStyle(context).copyWith(fontSize: 22, fontWeight: FontWeight.w500),),
            ],
          ),
          if(dateComparison(model.end))... {
            const Spacer(),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(color: lightPrimaryColor, borderRadius: BorderRadius.circular(8),),
              child: Text('Paid', style: blueStyle(context).copyWith(fontWeight: FontWeight.w600, fontSize: 16),),
            )
          }
        ],
      ),
    );
  }
}
