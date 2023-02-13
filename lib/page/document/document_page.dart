import 'package:desktop_multi_window/desktop_multi_window.dart';
import 'package:flutter/material.dart';

class DocumentPage extends StatelessWidget {
  const DocumentPage({
    Key? key,
    required this.windowController,
    required this.args,
  }) : super(key: key);

  final WindowController windowController;
  final Map? args;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Row(
        children: [
          Column(
            children: [
              FlutterLogo(
                size: 200,
              )
            ],
          )
          // if (args != null)
          //   Text(
          //     'Arguments: ${args.toString()}',
          //     style: const TextStyle(fontSize: 20),
          //   ),
          // ValueListenableBuilder<bool>(
          //   valueListenable: DesktopLifecycle.instance.isActive,
          //   builder: (context, active, child) {
          //     if (active) {
          //       return const Text('Window Active');
          //     } else {
          //       return const Text('Window Inactive');
          //     }
          //   },
          // ),
        ],
      ),
    );
  }
}
