import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:service_app/assets/color/colors.dart';
import 'package:service_app/assets/constants/app_icons.dart';
import 'package:service_app/globals/widgets/w_scale.dart';
import 'package:service_app/utils/text_styles.dart';

class ServiceItem extends StatelessWidget {
  const ServiceItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: whiteSmoke,
      ),
      child: Column(
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(12)),
                child: CachedNetworkImage(
                  height: 170,
                  width: double.infinity,
                  imageUrl:
                      'https://s3-alpha-sig.figma.com/img/167b/3fb2/8e934fe6fbdfbe692e074f28a2f388f5?Expires=1717372800&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=JUsqlBjzdwJAP5dtcJNroqTR-ZPAQBoU27uRM3zNjh86CE2UaTNF4TS2aFM0-I-YVJYi0hhEfud9H3hio3CM7GT3ENDojhaSxkk1BtIiS3eO0ECHu1BLj5pCtp8YMWEZQ84ABj0tN2dhISW92rAvfFqz9ludeC9bWN4INiE9-OHy9E1pOr3UAmaaoR5~VuiyND8Amc-8LL~1qthDPmn9geUpA2~nFCuKwiuByB2uBs4I1WRIhB52XOLs~p78RSefEgJjuQBJ4D2pj0wHtObpWXzwi0z8WB9qPF~86PmJ-0VA8UCRtdlKKm0qaAeISKibb-A8uANCNDzG5NpKb~MEpw__',
                  fit: BoxFit.fitWidth,
                ),
              ),
              Container(
                height: 170,
                width: double.infinity,
                decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                  Colors.black.withOpacity(0),
                  Colors.black.withOpacity(.54),
                ], begin: Alignment.bottomLeft, end: Alignment.bottomRight)),
              ),
              Positioned(
                top: 8,
                left: 8,
                child: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(.4),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    '\$5 monthly • Family + plan',
                    style: greyStyle(context).copyWith(
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                      color: const Color(0xffcbcbcb)
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 8,
                right: 8,
                child: WScaleAnimation(
                  onTap: () {},
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(.4),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Row(
                      children: [
                        SvgPicture.asset(AppIcons.link),
                        const SizedBox(
                          width: 2,
                        ),
                        Text(
                          'URL',
                          style: greyStyle(context).copyWith(
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                            color: const Color(0xffcbcbcb)
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 8, 12, 12),
            child: Text(
              'Lorem ipsum dolor sit amet consectetur.Lorem ipsum dolor sit amet consectetur.Lorem ipsum dolor sit amet consectetur.Lorem ipsum dolor sit amet consectetur.',
              style: greyStyle(context)
                  .copyWith(fontWeight: FontWeight.w400, fontSize: 14),
            ),
          )
        ],
      ),
    );
  }
}
