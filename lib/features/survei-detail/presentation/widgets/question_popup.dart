import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';
import 'package:synapsis_challenge/config/themes/colors.dart';
import 'package:synapsis_challenge/features/survei-detail/presentation/bloc/survei_detail_bloc.dart';

class QuestionPopUp extends StatefulWidget {
  final int sliderItemCount;
  final SurveiDetailLoaded state;
  const QuestionPopUp(
      {super.key, required this.sliderItemCount, required this.state});

  @override
  State<QuestionPopUp> createState() => _QuestionPopUpState();
}

class _QuestionPopUpState extends State<QuestionPopUp> {
  late int index;
  @override
  void initState() {
    index = (widget.state.index / 20).floor();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    padding:
                        EdgeInsets.symmetric(vertical: 1.5.h, horizontal: 3.h),
                    child: const Text(
                      'Survei Question',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: 1,
                    color: const Color(0xFFD9D9D9),
                  ),
                  CarouselSlider.builder(
                      itemCount: widget.sliderItemCount,
                      itemBuilder: (context, index, realIndex) {
                        int startIndex = index * 20;
                        int endIndex = startIndex + 20;
                        if (endIndex > widget.state.totalQuestion) {
                          endIndex = widget.state.totalQuestion;
                        }
                        List<int> list = List<int>.generate(
                            endIndex - startIndex, (i) => i + startIndex);

                        return Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(
                              vertical: 2.h, horizontal: 3.h),
                          child: GridView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            itemCount: list.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 5,
                                    crossAxisSpacing: 1.h,
                                    mainAxisSpacing: 1.h),
                            itemBuilder: (context, index) {
                              bool isCurrentIdx =
                                  list[index] == widget.state.index;
                              bool isAnswered = widget.state.userAnswerEntity
                                      .answers[list[index]].answer !=
                                  null;
                              return InkWell(
                                onTap: () {
                                  context.read<SurveiDetailBloc>().add(
                                      NavigateQuestionEvent(
                                          index: list[index]));
                                  context.pop();
                                },
                                child: Container(
                                    decoration: BoxDecoration(
                                      color: isAnswered
                                          ? SynapsisColor.primaryColor
                                          : isCurrentIdx
                                              ? SynapsisColor.primaryColor
                                                  .withOpacity(0.2)
                                              : Colors.white,
                                      border: Border.all(
                                          color: isCurrentIdx
                                              ? SynapsisColor.primaryColor
                                              : isAnswered
                                                  ? Colors.transparent
                                                  : const Color(0xFF787878),
                                          width: 1),
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Center(
                                      child: Text(
                                        (list[index] + 1).toString(),
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500,
                                            color: isAnswered
                                                ? Colors.white
                                                : isCurrentIdx
                                                    ? SynapsisColor.primaryColor
                                                    : const Color(0xFF787878)),
                                      ),
                                    )),
                              );
                            },
                          ),
                        );
                      },
                      options: CarouselOptions(
                        initialPage: index,
                        onPageChanged: (carouselIndex, reason) {
                          setState(() {
                            index = carouselIndex;
                          });
                        },
                        height: 40.h,
                        viewportFraction: 1,
                        enableInfiniteScroll: false,
                      )),
                  DotsIndicator(
                    decorator: const DotsDecorator(
                      color: Color(0xFFD9D9D9),
                      activeColor: SynapsisColor.primaryColor,
                    ),
                    dotsCount: widget.sliderItemCount,
                    position: index,
                  ),
                  SizedBox(
                    height: 2.h,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
