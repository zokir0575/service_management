
import 'package:flutter/material.dart';
import 'package:service_app/assets/color/colors.dart';
import 'package:service_app/utils/text_styles.dart';

class PaymentItem extends StatelessWidget {
  final bool isUpcoming;
  const PaymentItem({this.isUpcoming = false, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
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
                  text: '31 Jan', style: darkStyle(context).copyWith(fontWeight: FontWeight.w500, fontSize: 12), children: [
                TextSpan( text: ' • ', style: greyStyle(context).copyWith(fontWeight: FontWeight.w500, fontSize: 12)),
                TextSpan( text: 'Spotify', style: blueStyle(context).copyWith(fontWeight: FontWeight.w500, fontSize: 12)),
              ]
              )),
              const SizedBox(height: 4,),
              Text('\$2,10', style: darkStyle(context).copyWith(fontSize: 22, fontWeight: FontWeight.w500),),
            ],
          ),
          if(!isUpcoming)... {
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
