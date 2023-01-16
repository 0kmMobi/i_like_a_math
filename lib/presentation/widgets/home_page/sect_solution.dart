import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i_like_a_math/presentation/bloc/home_page_digit_cubit.dart';
import 'package:i_like_a_math/presentation/bloc/home_page_digit_state.dart';
import 'package:i_like_a_math/presentation/widgets/custom_widgets/widget_rotator.dart';
import 'package:i_like_a_math/presentation/widgets/custom_widgets/tint_image.dart';
import 'package:i_like_a_math/presentation/widgets/home_page/sect_solution_solution.dart';
import 'package:share_files_and_screenshot_widgets/share_files_and_screenshot_widgets.dart';

class SectionSolution extends StatelessWidget {
  late final GlobalKey _previewContainer = GlobalKey();

  SectionSolution({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
          alignment: Alignment.bottomCenter,
          child: LayoutBuilder(
            builder: (context, constrains) {
              return BlocBuilder<DigitAndNumberCubit, DigitAndNumberState>(
                builder: (BuildContext context, DigitAndNumberState state) {
                  return RepaintBoundary(
                    key: _previewContainer,
                    child: SizedBox(
                      width: constrains.biggest.width,
                      height: constrains.biggest.height,
                      child: Solution(
                        key: UniqueKey(),
                        hasSolution: state.hasSolution,
                        solutionElems: state.solutionEntity.solutionElems,
                        parentSize: constrains.biggest,
                      ),
                    ),
                  );
                },
              );
            }
          ),
        ),
        Row(
          children: [
            Expanded(
                flex: 13,
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8, top: 32),
                    child: Text(
                      "titleSectSolution".tr().toUpperCase(),
                      textAlign: TextAlign.center,
                      style: const TextStyle( fontFamily: 'Roboto', fontSize: 26, color: Colors.black54,
                      ),
                    ),
                  ),
                ),
            ),
            Expanded(
                flex: 2,
                child: Container(
                  padding: const EdgeInsets.only(bottom: 30),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Text("3", style: TextStyle(fontFamily: 'Roboto', fontSize: 28, color: Color(0xFF00B0B0)),),

                      BlocBuilder<DigitAndNumberCubit, DigitAndNumberState>(
                        builder: (BuildContext context, DigitAndNumberState state) {
                          return IconButton(
                            padding: const EdgeInsets.all(0),
                            icon: WidgetRotator(
                              key: UniqueKey(),
                              startDelayMSec: 2000,
                              durationMSec: 3000,
                              child: TintImage(
                                  imgPath: 'assets/buttons/share-it.png',
                                  imgColor: state.hasSolution?0xFF00B0B0:0x4000B0B0 ),
                            ),
                            onPressed: !state.hasSolution ? null: () {
                                ShareFilesAndScreenshotWidgets()
                                    .shareScreenshot(
                                    _previewContainer, 800, "Title", "Name.png",
                                    "image/png",
                                    text: "shareSectSolution".tr(args: [
                                      "${state.solutionEntity.number}",
                                      "${state.solutionEntity.digit}"
                                    ]));
                            },
                          );
                        }
                      )
                    ],
                  ),
                )
            ),
          ],
        ),
      ],
    );
  }
}
