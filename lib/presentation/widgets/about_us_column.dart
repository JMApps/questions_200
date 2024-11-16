import 'dart:io';

import 'package:flutter/material.dart';

import '../../core/strings/app_strings.dart';
import '../../core/styles/app_styles.dart';
import 'about_us_list_tile.dart';

class AboutUsColumn extends StatelessWidget {
  const AboutUsColumn({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: AppStyles.paddingWithoutTop,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            AppStrings.ourApps,
            style: AppStyles.mainTextStyle17,
            textAlign: TextAlign.start,
          ),
          const SizedBox(height: 8),
          AboutUsListTile(
            title: Platform.isAndroid ? AppStrings.googlePlay : AppStrings.appStore,
            subTitle: AppStrings.moreOurApps,
            iconName: Platform.isAndroid ? 'google-play' : 'appstore',
            link: Platform.isAndroid ? AppStrings.linkGooglePlay : AppStrings.linkAppStore,
          ),
          const SizedBox(height: 8),
          const Text(
            AppStrings.ourSocials,
            style: AppStyles.mainTextStyle17,
            textAlign: TextAlign.start,
          ),
          const SizedBox(height: 8),
          const AboutUsListTile(
            title: AppStrings.telegram,
            subTitle: AppStrings.jmapps,
            iconName: 'telegram',
            link: AppStrings.linkTelegram,
          ),
          const SizedBox(height: 8),
          const AboutUsListTile(
            title: AppStrings.instagram,
            subTitle: AppStrings.devMuslim,
            iconName: 'instagram',
            link: AppStrings.linkInstagram,
          ),
          const SizedBox(height: 8),
          const AboutUsListTile(
            title: AppStrings.ummaLife,
            subTitle: AppStrings.jmapps,
            iconName: 'ummalife',
            link: AppStrings.linkUmmaLife,
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}
