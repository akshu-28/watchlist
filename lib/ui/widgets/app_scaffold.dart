import 'package:flutter/material.dart';

class Appscaffold extends StatefulWidget {
  const Appscaffold({Key? key, required this.body, this.title})
      : super(key: key);
  final Widget body;
  final Widget? title;
  @override
  State<Appscaffold> createState() => _AppscaffoldState();
}

class _AppscaffoldState extends State<Appscaffold> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.grey.withOpacity(0.5),
        bottomOpacity: 0,
        shadowColor: Colors.transparent,
        title: widget.title ?? const Text(""),
      ),
      body: widget.body,
    );
  }
}
