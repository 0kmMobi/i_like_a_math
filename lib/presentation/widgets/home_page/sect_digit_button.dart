import 'dart:math' as math;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i_like_a_math/presentation/bloc/home_page_digit_cubit.dart';
import 'package:i_like_a_math/presentation/widgets/custom_widgets/tint_image.dart';

class DigitButton extends StatelessWidget {
  final bool isLeft;
  const DigitButton({Key? key, required this.isLeft}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final numberAndDigitCubit = BlocProvider.of<DigitAndNumberCubit>(context);
    return Align(
      alignment: Alignment.center,
      child: LayoutBuilder(
        builder: (context, constraints) =>
            SizedBox(
              width: constraints.maxWidth,
              child: IconButton(
                padding: const EdgeInsets.all(0.0),
                icon: Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.rotationZ(isLeft?-math.pi/2:math.pi/2),
                  child: const TintImage(imgPath: 'assets/buttons/arrow.png', imgColor: 0xFFFFE000),
                ),
                onPressed: () {
                  debugPrint(isLeft? "left" : "right");
                  isLeft ? numberAndDigitCubit.decrementDigit() : numberAndDigitCubit.incrementDigit();
                },
              ),
            ),
      ),
    );
  }
}
