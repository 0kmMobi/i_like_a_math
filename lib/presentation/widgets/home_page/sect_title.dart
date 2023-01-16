import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:i_like_a_math/presentation/widgets/custom_widgets/widget_rotator.dart';
import 'package:i_like_a_math/presentation/widgets/custom_widgets/tint_image.dart';
import 'package:share_plus/share_plus.dart';

class SectionTitle extends StatelessWidget {
  const SectionTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: MediaQuery.of(context).viewPadding.top),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(flex: 2,
            child: IconButton(
              padding: const EdgeInsets.all(0),
              icon: WidgetRotator(
                key: UniqueKey(),
                startDelayMSec: 0,
                durationMSec: 3000,
                reversed: true,
                child: const TintImage(imgPath: 'assets/buttons/rate-it.png', imgColor: 0xFF00F000),
              ),
              onPressed: () {},
            ),),
          Expanded(flex: 11,
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: FittedBox(
                child: Text(
                    "appTitle".tr().toUpperCase(),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontFamily: 'Roboto',
                  ),
                ),
              ),
            ),),
          Expanded(flex: 2,
            child: IconButton(
              padding: const EdgeInsets.all(0),
              icon: WidgetRotator(
                key: UniqueKey(),
                startDelayMSec: 500,
                durationMSec: 3000,
                child: const TintImage(imgPath: 'assets/buttons/share-it.png', imgColor: 0xFF00F000)
              ),
              onPressed: () {
                final String appTitle = "appTitle".tr();
                Share.share("shareSectTitle".tr(args:[appTitle, "https://0km.mobi/appDM"])); // Select any digit
              },
            ),
          ),
        ],
      ),
    );
  }
}
