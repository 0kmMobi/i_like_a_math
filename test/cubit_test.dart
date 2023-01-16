import 'package:flutter_test/flutter_test.dart';
import 'package:i_like_a_math/core/error/exception.dart';
import 'package:i_like_a_math/data/data_sources/solution_data_source.dart';
import 'package:i_like_a_math/data/models/solution_model.dart';
import 'package:i_like_a_math/data/repositories/solution_repository_impl.dart';
import 'package:i_like_a_math/domain/usecases/get_solution.dart';
import 'package:i_like_a_math/presentation/bloc/home_page_digit_cubit.dart';
import 'package:i_like_a_math/presentation/bloc/home_page_digit_state.dart';
import 'package:mocktail/mocktail.dart';

class SolutionDataSourceMockSolutions extends Mock implements SolutionDataSourceImpl {}
class SolutionDataSourceMockRawData extends SolutionDataSourceImpl{
  SolutionDataSourceMockRawData(): super();

  final sSolutionPrefix = "solution for";
  final List<List<dynamic>> lTestData = [
    [1, 123, "11[(1+1)]+1+1", 3/*Number sections of solution*/], // digit +1
    [2, 123, "(22/2)[2]+2", 3],         // digit +1
    [2, 133, "22+222/2", 1],            // number +10
    [2, 933, "2*(2*222+22)+2/2", 1],    // number -100
    [null, ], ///[2, 934,],             // number + 1 <- is absent in source
    [2, 935, "2*(22[2]-22)+22/2", 3],   // number +1
  ];

  @override
  Future<String> loadAsset() async {
    var sTestDataSource = "";
    for(List<dynamic> oneLine in lTestData) {
      if(oneLine[0] != null) { // Skip the missing test-element
        final digit = oneLine[0] as int;
        final number = oneLine[1] as int;
        final expression = oneLine[2] as String;
        sTestDataSource += "$digit\t$number\t$expression\n";
      }
    }
    sTestDataSource = sTestDataSource.substring(0, sTestDataSource.length-1);
    return sTestDataSource;
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  
  group('1. When to increase or decrease then a digit and a number digits must be in valid range.', () {
    test('1.1. During calling increment/decrement of a digit multiple times then a digit cannot become out of range.', () async {
      final dataSource = SolutionDataSourceImpl();
      final repository = SolutionRepositoryImpl(dataSource: dataSource);
      final getSolution = GetSolution(repository);
      final DigitAndNumberCubit cubit = DigitAndNumberCubit(getSolution: getSolution);

      const numRangeLoops = 11;
      cubit.stream.listen(
          expectAsync1((state) {
            final digit = state.solutionEntity.digit;
            print("The digit has been set to $digit");
            expect(digit, inInclusiveRange(1, 9));
          }, max: numRangeLoops*2)
      );

      for(int i = 0; i < numRangeLoops; i ++) {
        await cubit.incrementDigit();
      }
      for(int i = 0; i < numRangeLoops; i ++) {
        await cubit.decrementDigit();
      }
      // await Future.delayed(const Duration(seconds: 5));
    });

    test('1.2. During calling increment/decrement of a digits of number multiple times then its cannot become out of range.', () async {
      final dataSource = SolutionDataSourceImpl();
      final repository = SolutionRepositoryImpl(dataSource: dataSource);
      final getSolution = GetSolution(repository);
      final DigitAndNumberCubit cubit = DigitAndNumberCubit(getSolution: getSolution);
      const numRangeLoops = 11;
      cubit.stream.listen(
          expectAsync1((state) {
            final number = state.solutionEntity.number;
            print("The number has been set to $number");
            return expect(number, inInclusiveRange(100, 999));
          }, max: numRangeLoops*3*2)
      );

      for(int i = 0; i < numRangeLoops; i ++) {
        await cubit.incrementNumber(DigitPosition.hundreds);
        await cubit.incrementNumber(DigitPosition.tens);
        await cubit.incrementNumber(DigitPosition.units);
      }
      for(int i = 0; i < numRangeLoops; i ++) {
        await cubit.decrementNumber(DigitPosition.hundreds);
        await cubit.decrementNumber(DigitPosition.tens);
        await cubit.decrementNumber(DigitPosition.units);
      }
    });

  });

  group("2. When mocking a data", () {
    test("2.1. When mocking a solutions", () async {
      final SolutionDataSourceImpl dataSource = SolutionDataSourceMockSolutions();
      final repository = SolutionRepositoryImpl(dataSource: dataSource);
      final getSolution = GetSolution(repository);
      final DigitAndNumberCubit cubit = DigitAndNumberCubit(getSolution: getSolution);

      const sSolutionPrefix = "solution for";

      final List<List<dynamic>> lTestData = [
        [1, 123,true],  // digit +1
        [2, 123,true],  // digit +1
        [2, 133,true],  // number +10
        [2, 933,true],  // number -100
        [2, 934,false], // number + 1 <- is absent in source
        [2, 935,true],  // number +1
      ];

      for(List<dynamic> oneLine in lTestData) {
          final digit = oneLine[0] as int;
          final number = oneLine[1] as int;
          if(oneLine[2] as bool) {
            var oneSolution = SolutionModel(
                digit: digit,
                number: number,
                solutionElems: [ExpressionElemModel(1, "$sSolutionPrefix $digit/$number")]
            );
            when(()=>dataSource.getSolution(digit, number)).thenAnswer((_) => Future(() => oneSolution));
          } else {
            when(()=>dataSource.getSolution(digit, number)).thenThrow(DataSourceException("solutionNotAvailableInDemo"));
          }
      }

      var iTest = 0;
      cubit.stream.listen(
          expectAsync1((state) {
            final solutionEntity = state.solutionEntity;
            final digit = solutionEntity.digit;
            final number = solutionEntity.number;
            final expression = solutionEntity.solutionElems[0].expression;
            print("Digit: $digit");
            print("Number: $number");
            print("Solution[0]: $expression");

            expect(digit, lTestData[iTest][0]);
            expect(number, lTestData[iTest][1]);
            if(state.hasSolution) {
              expect(expression, "$sSolutionPrefix $digit/$number");
            } else {
              expect(expression, "solutionNotAvailableInDemo");
            }
            iTest++;
          }, max: lTestData.length+1)
      );

      await cubit.incrementDigit();                         // digit +1
      await cubit.incrementDigit();                         // digit +1
      await cubit.incrementNumber(DigitPosition.tens);      // number +10
      await cubit.decrementNumber(DigitPosition.hundreds);  // number -100
      await cubit.incrementNumber(DigitPosition.units);     // number + 1 <- is absent in source
      await cubit.incrementNumber(DigitPosition.units);     // number + 1
    });



    test("2.2. When mocking a raw data", () async {
      final SolutionDataSourceMockRawData dataSource = SolutionDataSourceMockRawData();
      final repository = SolutionRepositoryImpl(dataSource: dataSource);
      final getSolution = GetSolution(repository);
      final DigitAndNumberCubit cubit = DigitAndNumberCubit(getSolution: getSolution);

      var iTest = 0;
      cubit.stream.listen(
          expectAsync1((state) {
            final solutionEntity = state.solutionEntity;
            final digit = solutionEntity.digit;
            final number = solutionEntity.number;
            final numExpressions = solutionEntity.solutionElems.length;
            final expression0 = solutionEntity.solutionElems[0].expression;
            print("Digit: $digit");
            print("Number: $number");
            print("Solution[0]: $expression0");
            print("numExpressions: $numExpressions");

            if(dataSource.lTestData[iTest][0] == null) {
              expect(solutionEntity.solutionElems[0].expression, "solutionNotAvailableInDemo");
            } else {
              expect(digit, dataSource.lTestData[iTest][0]);
              expect(number, dataSource.lTestData[iTest][1]);
              expect(numExpressions, dataSource.lTestData[iTest][3]);
            }
            iTest++;
          }, max: dataSource.lTestData.length+1)
      );

      await cubit.incrementDigit();                         // digit +1
      await cubit.incrementDigit();                         // digit +1
      await cubit.incrementNumber(DigitPosition.tens);      // number +10
      await cubit.decrementNumber(DigitPosition.hundreds);  // number -100
      await cubit.incrementNumber(DigitPosition.units);     // number + 1 <- is absent in source
      await cubit.incrementNumber(DigitPosition.units);     // number + 1
    });
  });
}