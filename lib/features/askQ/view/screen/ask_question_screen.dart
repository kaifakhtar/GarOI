import 'package:flutter/material.dart';


class AskQuesScreen extends StatefulWidget {
  const AskQuesScreen({super.key});

  @override
  State<AskQuesScreen> createState() => _AskQuesScreenState();
}

class _AskQuesScreenState extends State<AskQuesScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text("Ask a scholar"),),
    );
  }
}