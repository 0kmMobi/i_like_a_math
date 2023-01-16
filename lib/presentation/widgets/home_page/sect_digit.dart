import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:i_like_a_math/presentation/bloc/home_page_digit_cubit.dart';
import 'package:i_like_a_math/presentation/bloc/home_page_digit_state.dart';
import 'package:i_like_a_math/presentation/widgets/custom_widgets/widget_rotator.dart';
import 'package:i_like_a_math/presentation/widgets/home_page/sect_digit_button.dart';
import 'package:i_like_a_math/presentation/widgets/home_page/sect_digit_digit.dart';
import 'package:i_like_a_math/presentation/widgets/custom_widgets/tint_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_plus/share_plus.dart';



class SectionDigit extends StatelessWidget {
  const SectionDigit({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(flex: 5,
          child: Text(
            "titleSectDigit".tr().toUpperCase(), // Any\ndigit\nfrom 1 to 9
            textAlign: TextAlign.center,
            style: const TextStyle(
                fontFamily: 'Roboto',
                fontSize: 18,
                color: Colors.black54
            ),
          ),
        ),
        Expanded(flex: 8,
          child: Row(
            children: [
              const Expanded(
                flex: 1,
                child: DigitButton(isLeft: true),
              ),
              Expanded(
                flex: 1,
                child: BlocBuilder<DigitAndNumberCubit, DigitAndNumberState>(
                  builder: (context, state) {
                      return Digit(currentDigit: state.solutionEntity.digit,);
                  },
                ),
              ),
              const Expanded(
                flex: 1,
                child: DigitButton(isLeft: false),
              ),
            ],
          ),
        ),
        Expanded(flex: 2,
          child: Container(
            padding: const EdgeInsets.only(bottom: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("1", style: TextStyle(fontFamily: 'Roboto',fontSize: 28, color: Color(0xFF00B0B0))),
                IconButton(
                  padding: const EdgeInsets.all(0),
                  icon: WidgetRotator(
                    key: UniqueKey(),
                    startDelayMSec: 1000,
                    durationMSec: 3000,
                    child: const TintImage(imgPath: 'assets/buttons/share-it.png', imgColor: 0xFF00B0B0),
                  ),
                  onPressed: () {
                    Share.share("shareSectDigit".tr()); // Select any digit
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
