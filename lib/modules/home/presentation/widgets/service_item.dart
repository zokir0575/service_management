import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:service_app/assets/color/colors.dart';
import 'package:service_app/assets/constants/app_icons.dart';
import 'package:service_app/globals/widgets/w_scale.dart';
import 'package:service_app/modules/home/data/model/service_model.dart';
import 'package:service_app/utils/text_styles.dart';
import 'package:url_launcher/url_launcher.dart';
_launchURL(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    print('Could not launch $url');
  }
}

class ServiceItem extends StatelessWidget {
  final ServiceModel model;

  const ServiceItem({required this.model, super.key});

  bool isLocalFile(String path) {
    return path.startsWith('/data/');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: whiteSmoke,
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius:
                const BorderRadius.vertical(top: Radius.circular(12)),
                child: isLocalFile(model.image)
                    ? Image.file(
                  File(model.image),
                  height: 170,
                  width: double.infinity,
                  fit: BoxFit.cover,
                )
                    : CachedNetworkImage(
                  height: 170,
                  width: double.infinity,
                  imageUrl: model.image,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => const CircularProgressIndicator(),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
              Container(
                height: 170,
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.black.withOpacity(0),
                      Colors.black.withOpacity(.54),
                    ],
                    begin: Alignment.bottomLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
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
                    '${model.price} monthly • Family + plan',
                    style: greyStyle(context).copyWith(
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                        color: const Color(0xffcbcbcb)),
                  ),
                ),
              ),
              Positioned(
                top: 8,
                right: 8,
                child: WScaleAnimation(
                  onTap: () {
                     _launchURL(model.url);
                  },
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
                              color: const Color(0xffcbcbcb)),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 8,
                left: 8,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(model.name, style: whiteStyle(context).copyWith(fontSize: 16, fontWeight: FontWeight.w600),),
                    const SizedBox(height: 4,),
                    Text('${model.start} - ${model.end}', style: greyStyle(context).copyWith(fontWeight: FontWeight.w400, fontSize: 12),),
                  ],
                ),
              ),
              const Positioned(
                  bottom: 8,
                  right: 8,
                  child: Icon(Icons.arrow_forward_ios, color: white,)
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 8, 12, 12),
            child: Text(
              model.note,
              style: greyStyle(context)
                  .copyWith(fontWeight: FontWeight.w400, fontSize: 14),
            ),
          )
        ],
      ),
    );
  }
}
