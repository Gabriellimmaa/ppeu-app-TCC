import 'package:flutter/material.dart';
import 'package:ppue/screens/Report/widgets/GraphUMUH.widget.dart';

class ReportGraphs extends StatefulWidget {
  const ReportGraphs({Key? key}) : super(key: key);

  @override
  State<ReportGraphs> createState() => _ReportGraphsState();
}

class _ReportGraphsState extends State<ReportGraphs> {
  @override
  Widget build(BuildContext context) {
    return ReportGraphUMUH();
  }
}
