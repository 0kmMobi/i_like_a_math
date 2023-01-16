// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i_like_a_math/domain/entities/solution_entity.dart';
import 'package:i_like_a_math/domain/usecases/get_solution.dart';
import 'home_page_digit_state.dart';

class DigitAndNumberCubit extends Cubit<DigitAndNumberState> {
  final GetSolution getSolution;

  DigitAndNumberCubit({required this.getSolution}):
        super(DigitAndNumberState(hasSolution: false, solutionEntity: SolutionEntity.empty()));

  Future<void> incrementDigit() async {
    var digit = state.solutionEntity.digit;
    if (digit < 9)    digit += 1;
    else              digit = 1;

    await _emitFailureOrSolution(digit: digit, number: state.solutionEntity.number);
  }

  Future<void> decrementDigit() async {
    var digit = state.solutionEntity.digit;
    if (digit > 1)  digit -= 1;
    else            digit = 9;

    await _emitFailureOrSolution(digit: digit, number: state.solutionEntity.number);
  }

  Future<void> incrementNumber(digitPosition) async {
    var numDig = state.getNumberDigit(digitPosition);
    if(digitPosition == DigitPosition.hundreds) {
      if(numDig < 9)  numDig ++;
      else            numDig = 1;
    } else {
      if(numDig < 9)  numDig ++;
      else            numDig = 0;
    }
    final newNumber = state.getNumberWhenChangeDigitInNumber(numDig, digitPosition);
    await _emitFailureOrSolution(digit: state.solutionEntity.digit, number: newNumber);
  }

  Future<void> decrementNumber(digitPosition) async {
    var numDig = state.getNumberDigit(digitPosition);
    if(digitPosition == DigitPosition.hundreds) {
      if(numDig > 1)  numDig --;
      else            numDig = 9;
    } else {
      if(numDig > 0)  numDig --;
      else            numDig = 9;
    }
    final newNumber = state.getNumberWhenChangeDigitInNumber(numDig, digitPosition);
    await _emitFailureOrSolution(digit: state.solutionEntity.digit, number: newNumber);
  }

  Future<void> _emitFailureOrSolution({required int digit, required int number}) async {
    final failureOrSolution = await getSolution(SolutionParams(digit: digit, number: number));

    failureOrSolution.fold(
      (error) {
        emit(
          DigitAndNumberState(hasSolution: false, solutionEntity: SolutionEntity.error(digit: digit, number: number, errorMsg: error.msg))
        );
      },
      (solution) {
        emit(
          DigitAndNumberState(hasSolution: true, solutionEntity: solution)
        );
      }
    );
  }
}
