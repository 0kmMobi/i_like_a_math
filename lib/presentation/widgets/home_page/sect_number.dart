import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:i_like_a_math/presentation/bloc/home_page_digit_state.dart';
import 'package:i_like_a_math/presentation/widgets/custom_widgets/widget_rotator.dart';
import 'package:i_like_a_math/presentation/widgets/home_page/sect_number_one_digit.dart';
import 'package:i_like_a_math/presentation/widgets/custom_widgets/tint_image.dart';
import 'package:share_plus/share_plus.dart';

class SectionNumber extends StatelessWidget {
  const SectionNumber({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(flex: 5,
          child: Text("titleSectNumber".tr().toUpperCase(),
            textAlign: TextAlign.center,
            style: const TextStyle( fontFamily: 'Roboto', fontSize: 18, color: Colors.black54),
          ),
        ),
        Expanded(flex: 8,
          child: Padding(
            padding: const EdgeInsets.only(top: 8, bottom: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: const [
                OneDigitNumber(digitPosition: DigitPosition.hundreds, color: Colors.deepPurpleAccent),
                OneDigitNumber(digitPosition: DigitPosition.tens, color: Colors.deepOrangeAccent),
                OneDigitNumber(digitPosition: DigitPosition.units, color: Colors.lightBlue),
              ],
            ),
          ),
        ),
        Expanded(flex: 2,
          child: Container(
            padding: const EdgeInsets.only(bottom: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("2", style: TextStyle(fontFamily: 'Roboto', fontSize: 28, color: Color(0xFF00B0B0)),),
                IconButton(
                  padding: const EdgeInsets.all(0),
                  icon: WidgetRotator(
                    key: UniqueKey(),
                    startDelayMSec: 1500,
                    durationMSec: 3000,
                    child: const TintImage(imgPath: 'assets/buttons/share-it.png', imgColor: 0xFF00B0B0),
                  ),
                  onPressed: () {
                    Share.share("shareSectNumber".tr());
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
