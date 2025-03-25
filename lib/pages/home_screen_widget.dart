import 'package:flutter/material.dart';
import 'package:license_entrance/app/data_provider.dart';
import 'package:license_entrance/pages/questions_block/questions_block_widget.dart';
import 'package:provider/provider.dart';

class HomeScreenWidget extends StatefulWidget {
  const HomeScreenWidget({super.key});

  @override
  State<HomeScreenWidget> createState() => _HomeScreenWidgetState();
}

class _HomeScreenWidgetState extends State<HomeScreenWidget> {
  @override
  Widget build(BuildContext context) {
    return Consumer<DataProvider>(
      builder: (context, provider, child) {
        return ListView.builder(
          itemCount: provider.responseModel?.data.length ?? 0,
          itemBuilder: (context, index) {
            final datum = provider.responseModel?.data[index];
            RegExp regExp = RegExp(r'Q\d+:\s*(.*)');
            Match? match = regExp.firstMatch(datum?.question ?? '');
            final question = match?.group(1) ?? '';
            if (datum != null) {
              return QuestionBlockWidget(
                options: datum.options,
                question: question,
              );
            } else {
              return SizedBox();
            }
          },
        );
      },
    );
  }
}
