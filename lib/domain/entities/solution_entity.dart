import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';

class SolutionEntity extends Equatable {
  final int digit;
  final int number;
  final List<ExpressionElem> solutionElems;

  const SolutionEntity({required this.digit, required this.number, required this.solutionElems});

  factory SolutionEntity.empty() {
    return SolutionEntity(digit: 0, number: 123, solutionElems: [ExpressionElem(1, "noSolution".tr())]);
  }

  factory SolutionEntity.error({required digit, required number, required errorMsg}) {
    return SolutionEntity(digit: digit, number: number, solutionElems: [ExpressionElem(1, errorMsg)]);
  }

  @override
  List<Object?> get props => [digit, number];
}

class ExpressionElem {
  final int level;
  final String expression;

  const ExpressionElem(this.level, this.expression);

  @override
  String toString() {
    return "[$level, $expression]";
  }
}