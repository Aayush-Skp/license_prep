import 'package:flutter/material.dart';
import 'package:license_entrance/common/shared_pref/shared_pref.dart';
import 'package:license_entrance/pages/performance/user_statistics_graph_widget.dart';

class PerformanceWidget extends StatefulWidget {
  const PerformanceWidget({super.key});

  @override
  State<PerformanceWidget> createState() => _PerformanceWidgetState();
}

class _PerformanceWidgetState extends State<PerformanceWidget> {
  List<dynamic> sampleResults = [];
  bool _isLoading = true;
  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final results = await SharedPref.getResults();
    print("Loaded results: $results");
    setState(() {
      sampleResults = results;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const SafeArea(child: Center(child: CircularProgressIndicator()));
    }

    return SafeArea(child: UserStatisticsGraph(results: sampleResults));
  }
}
