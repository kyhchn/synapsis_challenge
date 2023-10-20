import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';
import 'package:synapsis_challenge/config/colors.dart';
import 'package:synapsis_challenge/features/survei-detail/domain/entity/survei_detail.dart';
import 'package:synapsis_challenge/features/survei-detail/presentation/bloc/survei_detail_bloc.dart';
import 'package:synapsis_challenge/features/survei-detail/presentation/widgets/question_popup.dart';
import 'package:synapsis_challenge/features/survei/domain/entity/survei.dart';
import 'package:synapsis_challenge/widgets/button.dart';

class SurveiDetailView extends StatefulWidget {
  final SurveiEntity survei;
  const SurveiDetailView({super.key, required this.survei});

  @override
  State<SurveiDetailView> createState() => _SurveiDetailViewState();
}

class _SurveiDetailViewState extends State<SurveiDetailView> {
  DateTime? targetTime;
  Duration countdownDuration = const Duration();
  Timer? countdownTimer;

  @override
  void dispose() {
    countdownTimer?.cancel();
    super.dispose();
  }

  void startCountdown() {
    targetTime = DateTime.now().add(const Duration(seconds: 60));
    countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      final now = DateTime.now();
      if (targetTime!.isAfter(now)) {
        setState(() {
          countdownDuration = targetTime!.difference(now);
        });
      } else {
        timer.cancel();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Time is up!'),
            duration: Duration(seconds: 2),
          ),
        );
        //do remove until home

        while ((context.canPop()) &&
            (ModalRoute.of(context)!.settings.name != '/')) {
          context.pop();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<SurveiDetailBloc, SurveiDetailState>(
          listener: (context, state) {
            if (state is SurveiDetailError) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ));
            }
          },
          builder: (context, state) {
            if (state is SurveiDetailLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (state is SurveiDetailError) {
              return Text(state.message);
            }

            if (state is SurveiDetailLoaded) {
              if (targetTime == null) {
                startCountdown();
              }
              final seconds = countdownDuration.inSeconds % 60;

              Question question = state.surveiDetail.questions[state.index];
              int? groupValue =
                  state.userAnswerEntity.answers[state.index].answer;
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    padding:
                        EdgeInsets.symmetric(vertical: 1.5.h, horizontal: 3.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                            vertical: 1.h,
                            horizontal: 3.h,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              color: SynapsisColor.primaryColor,
                            ),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            '$seconds Second left',
                            style: const TextStyle(
                              color: SynapsisColor.primaryColor,
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            final sliderItemCount =
                                (state.totalQuestion / 20).ceil();
                            showGeneralDialog(
                              context: context,
                              barrierDismissible: true,
                              transitionDuration:
                                  const Duration(milliseconds: 300),
                              barrierLabel:
                                  MaterialLocalizations.of(context).dialogLabel,
                              barrierColor: Colors.black.withOpacity(0.5),
                              pageBuilder: (context, _, __) {
                                return QuestionPopUp(
                                    sliderItemCount: sliderItemCount,
                                    state: state);
                              },
                              transitionBuilder: (context, animation,
                                  secondaryAnimation, child) {
                                return SlideTransition(
                                  position: CurvedAnimation(
                                    parent: animation,
                                    curve: Curves.easeOut,
                                  ).drive(Tween<Offset>(
                                    begin: const Offset(0, -1.0),
                                    end: Offset.zero,
                                  )),
                                  child: child,
                                );
                              },
                            );
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 1.h, horizontal: 2.h),
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.list_alt_outlined,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  width: 0.5.h,
                                ),
                                Text(
                                  '${state.totalQuestionAnswered}/${state.totalQuestion}',
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.only(
                        top: 1.h, bottom: 2.h, left: 3.h, right: 3.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          state.surveiDetail.surveyName,
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        Text(
                          '${question.questionNumber}. ${question.questionName}',
                          style: const TextStyle(
                            color: Color(0xFF6D6D6D),
                            fontSize: 16,
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: 1.5.h,
                    color: const Color(0xFFEEF6F9),
                  ),
                  Container(
                    width: double.infinity,
                    padding:
                        EdgeInsets.symmetric(vertical: 1.5.h, horizontal: 3.h),
                    child: Row(
                      children: [
                        const Text(
                          'Answer',
                          style: TextStyle(
                              color: SynapsisColor.primaryColorDark,
                              fontSize: 15),
                        ),
                        const Spacer(),
                        SynapsisButton(
                            content: 'Clear My Choice',
                            type: SynapsisButtonType.secondary,
                            onclick: () => context.read<SurveiDetailBloc>().add(
                                AnswerQuestionEvent(
                                    questionId: question.id, answer: 0)))
                      ],
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: 1,
                    color: const Color(0xFFF0ECEC),
                  ),
                  Expanded(
                    child: Column(
                      children: question.options
                          .map((e) => optionContainer(e, groupValue, context))
                          .toList(),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 2.h, horizontal: 3.h),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 35.w,
                          child: SynapsisButton(
                              content: 'Back',
                              type: SynapsisButtonType.secondary,
                              onclick: () {
                                context
                                    .read<SurveiDetailBloc>()
                                    .add(PreviousQuestionEvent());
                              }),
                        ),
                        SizedBox(
                          width: 2.h,
                        ),
                        Expanded(
                          child: SynapsisButton(
                              content: 'Next',
                              type: SynapsisButtonType.primary,
                              onclick: () => context
                                  .read<SurveiDetailBloc>()
                                  .add(NextQuestionEvent())),
                        )
                      ],
                    ),
                  )
                ],
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }

  Container optionContainer(
      Option option, int? groupValue, BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 1.5.h, horizontal: 3.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 2.h,
            height: 2.h,
            child: Radio(
                value: option.value,
                groupValue: groupValue,
                onChanged: (value) {
                  context.read<SurveiDetailBloc>().add(AnswerQuestionEvent(
                      questionId: option.id, answer: value!));
                }),
          ),
          SizedBox(
            width: 1.h,
          ),
          Expanded(
            child: Text(option.optionName,
                style: const TextStyle(
                    fontSize: 15, color: SynapsisColor.primaryColorDark)),
          ),
        ],
      ),
    );
  }
}
