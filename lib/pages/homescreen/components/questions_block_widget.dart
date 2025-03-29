import 'package:flutter/material.dart';
import 'package:license_entrance/app/theme.dart';

class QuestionBlockWidget extends StatefulWidget {
  final String question;
  final List<String> options;
  final String correctAnswer;
  final bool isSubmitted;
  final String? selectedAnswer;
  final Function(String?) onAnswerSelected;
  const QuestionBlockWidget({
    super.key,
    required this.options,
    required this.question,
    required this.correctAnswer,
    this.isSubmitted = false,
    this.selectedAnswer,
    required this.onAnswerSelected,
  });

  @override
  State<QuestionBlockWidget> createState() => _QuestionBlockWidgetState();
}

class _QuestionBlockWidgetState extends State<QuestionBlockWidget> {
  String? selectedOption;
  @override
  Widget build(BuildContext context) {
    return Card(
      color: CustomTheme.secondaryColor,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 17.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 4.0),
                      child: Icon(
                        Icons.question_answer_rounded,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      widget.question,
                      style: TextStyle(color: Colors.white, fontSize: 18),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            ...widget.options.map(
              (option) => RadioListTile<String>(
                title: Text(
                  option,
                  style: TextStyle(
                    color:
                        widget.isSubmitted
                            ? (option == widget.correctAnswer
                                ? Color(0xFF5cd44a)
                                : Color(0xFFDCDCDE))
                            : Colors.white,
                  ),
                ),
                value: option,
                groupValue: widget.selectedAnswer,
                onChanged: widget.isSubmitted ? null : widget.onAnswerSelected,
                activeColor: Colors.blue,
              ),
            ),
            (widget.isSubmitted &&
                    widget.selectedAnswer != widget.correctAnswer)
                ? Container(
                  decoration: BoxDecoration(
                    color: Colors.red.withAlpha(400),
                    borderRadius: BorderRadius.circular(7),
                  ),
                  child: Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        widget.correctAnswer,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                )
                : SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
