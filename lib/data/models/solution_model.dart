import 'package:i_like_a_math/domain/entities/solution_entity.dart';

class SolutionModel extends SolutionEntity {
  const SolutionModel({
    required digit,
    required number,
    required solutionElems
  }) : super(digit: digit, number: number, solutionElems: solutionElems);

  factory SolutionModel.fromDataRaw(Map<String, dynamic> raw) {
    return SolutionModel(digit: raw['digit'], number: raw['number'], solutionElems: raw['solution']);
  }

  Map<String, dynamic> toRawData() {
    return {
      'digit':digit,
      'number':number,
      'solutionElems':solutionElems
    };
  }
}

class ExpressionElemModel extends ExpressionElem {
  ExpressionElemModel(super.level, super.expression);
}