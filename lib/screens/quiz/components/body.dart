import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:quizapp/constants.dart';
import 'package:quizapp/controllers/question_controller.dart';
import 'package:quizapp/screens/quiz/components/progress_bar.dart';
import 'package:quizapp/screens/quiz/components/question_card.dart';

class Body extends StatelessWidget {
  const Body({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    QuestionController _questionController = Get.put(QuestionController());
    return Stack(
      children: [
        SvgPicture.asset(
          "assets/icons/bg.svg",
          fit: BoxFit.fill,
        ),
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: kDefaultPadding,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: kDefaultPadding,
                  ),
                  child: ProgressBar(),
                ),
                SizedBox(height: kDefaultPadding),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                  child: Obx(
                    () => Text.rich(
                      TextSpan(
                        text:
                            "Question ${_questionController.questionNumber.value}",
                        style: Theme.of(context).textTheme.headline4!.copyWith(
                              color: kSecondaryColor,
                            ),
                        children: [
                          TextSpan(
                            text: "/${_questionController.questions.length}",
                            style:
                                Theme.of(context).textTheme.headline5!.copyWith(
                                      color: kSecondaryColor,
                                    ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Divider(thickness: 1.5),
                SizedBox(height: kDefaultPadding),
                Expanded(
                  child: PageView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    onPageChanged: _questionController.updateTheQnNum,
                    controller: _questionController.pageController,
                    itemCount: _questionController.questions.length,
                    itemBuilder: (context, index) => QustionCard(
                      question: _questionController.questions[index],
                      index: index,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
