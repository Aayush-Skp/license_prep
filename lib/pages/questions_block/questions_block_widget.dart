import 'package:flutter/material.dart';
import 'package:license_entrance/app/theme.dart';

class QuestionBlockWidget extends StatefulWidget {
  final String question;
  final List<String> options;
  const QuestionBlockWidget({
    super.key,
    required this.options,
    required this.question,
  });

  @override
  State<QuestionBlockWidget> createState() => _QuestionBlockWidgetState();
}

class _QuestionBlockWidgetState extends State<QuestionBlockWidget> {
  String? selectedOption;
  @override
  Widget build(BuildContext context) {
    return Card(
      // margin: EdgeInsets.only(top: 10),
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
                title: Text(option, style: TextStyle(color: Colors.white)),
                value: option,
                groupValue: selectedOption,
                onChanged: (value) {
                  setState(() {
                    selectedOption = value;
                  });
                },
                activeColor: Colors.blue,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
