import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i_like_a_math/presentation/bloc/home_page_digit_cubit.dart';
import 'package:i_like_a_math/presentation/bloc/home_page_digit_state.dart';
import 'package:i_like_a_math/presentation/widgets/home_page/sect_number_one_digit_button.dart';


class OneDigitNumber extends StatelessWidget {
  final Color color;
  final DigitPosition digitPosition;

  const OneDigitNumber({Key? key, required this.digitPosition, required this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Stack(
        children: [
          OneDigitNumberButton(digitPosition: digitPosition, isUp: true,),
          Align(
            alignment: Alignment.center,
            child: BlocBuilder<DigitAndNumberCubit, DigitAndNumberState>(
              builder: (context, state) {
                return Text(
                    state.getNumberDigit(digitPosition).toString(),
                    style: const TextStyle(fontFamily: 'Roboto', fontSize: 110)
                ); //, backgroundColor: Colors.green)
              }
            ),
          ),
          OneDigitNumberButton(digitPosition: digitPosition, isUp: false,)
        ],
      ),
    );
  }
}
