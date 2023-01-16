import 'dart:math' as math;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i_like_a_math/presentation/bloc/home_page_digit_cubit.dart';
import 'package:i_like_a_math/presentation/bloc/home_page_digit_state.dart';
import 'package:i_like_a_math/presentation/widgets/custom_widgets/tint_image.dart';

class OneDigitNumberButton extends StatelessWidget {
  final bool isUp;
  final DigitPosition digitPosition;
  const OneDigitNumberButton({Key? key, required this.digitPosition, required this.isUp}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final numberAndDigitCubit = BlocProvider.of<DigitAndNumberCubit>(context);
    return Align(
      alignment: isUp?Alignment.topCenter:Alignment.bottomCenter,
      child: LayoutBuilder(
        builder: (context, constraints) =>
          SizedBox(
            width: constraints.maxWidth,
            height: constraints.maxWidth/2,
            child: IconButton(
              padding: const EdgeInsets.all(0.0),
              icon: Transform(
                alignment: Alignment.center,
                transform: Matrix4.rotationX(isUp?0:math.pi),
                child: const TintImage(imgPath: 'assets/buttons/arrow.png', imgColor: 0xFFFFC000),
              ),
              onPressed: () {
                debugPrint(isUp ? "Up $digitPosition" : "Down $digitPosition");
                isUp ? numberAndDigitCubit.incrementNumber(digitPosition): numberAndDigitCubit.decrementNumber(digitPosition);
              },
            ),
          ),
      ),
    );
  }
}
