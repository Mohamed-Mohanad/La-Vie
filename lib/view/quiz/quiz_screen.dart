import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:la_vie_app/core/components/default_button.dart';
import 'package:la_vie_app/core/style/colors/app_colors.dart';
import 'package:la_vie_app/core/style/texts/app_text_styles.dart';
import 'package:la_vie_app/core/utils/navigation.dart';
import 'package:la_vie_app/cubit/quiz/quiz_cubit.dart';
import 'package:la_vie_app/view/quiz/quiz_result_screen.dart';

class QuizScreen extends StatelessWidget {
  const QuizScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
        "Course Exam",
        style: AppTextStyle.appBarText(),
      )),
      body: BlocConsumer<QuizCubit, QuizState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          var cubit = QuizCubit.get(context);
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      "Question ",
                      style: AppTextStyle.headLine(),
                    ),
                    Text(
                      (cubit.currentQuestion + 1).toString(),
                      style: AppTextStyle.headLine()
                          .copyWith(color: AppColors.primaryColor),
                    ),
                    Text(
                      "/ ${cubit.questions.length}",
                      style: AppTextStyle.bodyText(),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20.h,
                ),
                Text(
                  cubit.questions[cubit.currentQuestion].question,
                  style: AppTextStyle.bodyText(),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Expanded(
                  child: ListView.separated(
                      itemBuilder: (context, index) => GestureDetector(
                            onTap: () {
                              cubit.chooseAnswer(index);
                            },
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.r),
                                border: Border.all(
                                    color: AppColors.primaryColor, width: 1.w),
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(cubit
                                        .questions[cubit.currentQuestion]
                                        .answers[index]),
                                  ),
                                  Icon(
                                    (cubit.questions[cubit.currentQuestion]
                                                .userAnswerIndex ==
                                            index)
                                        ? Icons.radio_button_checked
                                        : Icons.radio_button_unchecked,
                                    color: AppColors.primaryColor,
                                  ),
                                ],
                              ),
                            ),
                          ),
                      separatorBuilder: (context, index) => SizedBox(
                            height: 10.h,
                          ),
                      itemCount: cubit
                          .questions[cubit.currentQuestion].answers.length),
                ),
                Row(
                  children: [
                    if (!cubit.isFirst)
                      Expanded(
                        child: DefaultButton(
                          onPress: () {
                            cubit.backToPreviousQuestion();
                          },
                          hasBorder: true,
                          textColor: AppColors.primaryColor,
                          backgroundColor: AppColors.lightBackGroundColor,
                          text: "Back",
                        ),
                      )
                    else
                      const Expanded(child: SizedBox()),
                    SizedBox(
                      width: 10.w,
                    ),
                    if (!cubit.isLast) ...[
                      Expanded(
                        child: DefaultButton(
                          onPress: () {
                            cubit.moveToNextQuestion();
                          },
                          text: "Next",
                        ),
                      )
                    ] else ...[
                      Expanded(
                        child: DefaultButton(
                          onPress: () {
                            cubit.calculateResult();
                            debugPrint(cubit.correctAnswers.toString());
                            NavigationUtils.navigateTo(
                                context: context,
                                destinationScreen: QuizResultScreen(
                                    result: cubit.correctAnswers));
                          },
                          text: "Finish",
                        ),
                      )
                    ]
                  ],
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
