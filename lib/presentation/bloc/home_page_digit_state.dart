// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:equatable/equatable.dart';
import 'package:i_like_a_math/domain/entities/solution_entity.dart';

enum DigitPosition {
  hundreds,
  tens,
  units
}

class DigitAndNumberState extends Equatable {
  final SolutionEntity solutionEntity;
  final bool hasSolution;

  const DigitAndNumberState({
    required this.hasSolution,
    required this.solutionEntity,
  });

  int getNumberDigit(DigitPosition digitOrder) {
    switch(digitOrder) {
      case DigitPosition.hundreds:  return _getNumberHundreds();
      case DigitPosition.tens:      return _getNumberTens();
      case DigitPosition.units:     return _getNumberUnits();
    }
  }

  int getNumberWhenChangeDigitInNumber(int digit, DigitPosition digitPosition) {
    assert(digit >= 0 && digit <= 9, "A digit [$digit] of is out of range.");
    var numHundreds = _getNumberHundreds();
    var numTens     = _getNumberTens();
    var numUnits    = _getNumberUnits();

    switch(digitPosition) {
      case DigitPosition.hundreds:  numHundreds = digit; break;
      case DigitPosition.tens:      numTens     = digit; break;
      case DigitPosition.units:     numUnits    = digit; break;
    }
    return numHundreds*100 + numTens*10 + numUnits;
  }

  int _getNumberHundreds()  => solutionEntity.number ~/ 100;
  int _getNumberTens()      => (solutionEntity.number ~/ 10) %10;
  int _getNumberUnits()     => solutionEntity.number % 10;

  @override
  List<Object?> get props => [solutionEntity.digit, solutionEntity.number];
}