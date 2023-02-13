import 'package:flutter/material.dart';

class CollectPage extends StatefulWidget {
 const CollectPage({Key? key}) : super(key: key);

  @override
  State<CollectPage> createState() => _CollectPageState();
}

class _CollectPageState extends State<CollectPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      color: Color.fromARGB(255, 133, 44, 44),
    );
  }
}
