import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i_like_a_math/data/data_sources/solution_data_source.dart';
import 'package:i_like_a_math/presentation/bloc/home_page_digit_cubit.dart';
import 'package:i_like_a_math/presentation/widgets/home_page/sect_digit.dart';
import 'package:i_like_a_math/presentation/widgets/home_page/sect_number.dart';
import 'package:i_like_a_math/presentation/widgets/home_page/sect_solution.dart';
import 'package:i_like_a_math/presentation/widgets/home_page/sect_title.dart';

import '../../locator_service.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        (sl<SolutionDataSource>() as SolutionDataSourceImpl).setContext(context: context);
        return sl<DigitAndNumberCubit>();
      },
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Expanded(flex: 28,
              child: SectionTitle(),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Divider(height: 10, thickness: 4, color: Color(0xFFCCCC66)),
            ),
            const Expanded(flex: 38,
              child: SectionDigit(),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Divider(height: 10, thickness: 4, color: Color(0xFFCCCC66)),
            ),
            const Expanded(flex: 52,
              child: SectionNumber(),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Divider(height: 10, thickness: 4, color: Color(0xFFCCCC66)),
            ),
            Expanded(flex: 58,
              child: SectionSolution(),
            ),
          ],
        ),
      ),
    );
  }
}
