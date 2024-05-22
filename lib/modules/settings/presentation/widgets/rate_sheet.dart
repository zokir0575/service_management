import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:service_app/assets/color/colors.dart';
import 'package:service_app/assets/constants/app_images.dart';
import 'package:service_app/globals/widgets/snackbar.dart';
import 'package:service_app/globals/widgets/w_button.dart';
import 'package:service_app/utils/text_styles.dart';

class RateSheet extends StatefulWidget {
  const RateSheet({Key? key}) : super(key: key);

  @override
  State<RateSheet> createState() => _RateSheetState();
}

class _RateSheetState extends State<RateSheet> {
  double ratingScore = 0;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
          20, 20, 20, 16 + MediaQuery.of(context).padding.bottom),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 64,
            width: 64,
            decoration: BoxDecoration(
              color: white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Center(
              child: Image.asset(
                AppImages.logo,
                height: 24,
                width: 24,
              ),
            ),
          ),
          const SizedBox(
            height: 24,
          ),
          Text(
            'Can you rate our app?',
            style: darkStyle(context)
                .copyWith(fontSize: 20, fontWeight: FontWeight.w600),
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            'To provide best services rate our app',
            style: greyStyle(context)
                .copyWith(fontWeight: FontWeight.w500, fontSize: 14),
          ),
          SizedBox(
            height: 16,
          ),
          RatingBar.builder(
            initialRating: 3,
            itemSize: 40,
            direction: Axis.horizontal,
            itemCount: 5,
            maxRating: 0,
            allowHalfRating: false,
            unratedColor: grey,
            itemBuilder: (context, _) => const Icon(
              Icons.star,
              color: Colors.orange,
            ),
            onRatingUpdate: (rating) {
              setState(() {
                ratingScore = rating;
              });            },
          ),
          const SizedBox(
            height: 28,
          ),
          WButton(
            isDisabled: ratingScore == 0,
            onTap: () {
              Navigator.pop(context);
              showInfoSnackBar(context);
            },
            text: 'Rate',
          )
        ],
      ),
    );
  }
}
