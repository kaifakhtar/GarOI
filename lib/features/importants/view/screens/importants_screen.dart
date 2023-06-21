import 'package:flutter/material.dart';


class ImportantsScreen extends StatefulWidget {
  const ImportantsScreen({super.key});

  @override
  State<ImportantsScreen> createState() => _ImportantsScreenState();
}

class _ImportantsScreenState extends State<ImportantsScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text("Your importants here"),),
    );
  }
}