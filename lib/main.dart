import 'dart:io';
import 'package:desktop_multi_window/desktop_multi_window.dart';
import 'package:flutter/material.dart';
import 'package:wechat/hive/hive_tool.dart';
import 'package:wechat/page/document/document_page.dart';
import 'package:wechat/page/wechat_home_page.dart';
import 'package:window_manager/window_manager.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:convert';
import 'package:collection/collection.dart';

void main(List<String> args) async {
  if (args.firstOrNull == 'multi_window') {
    final windowId = int.parse(args[1]);
    final argument = args[2].isEmpty
        ? const {}
        : jsonDecode(args[2]) as Map<String, dynamic>;
    runApp(ProviderScope(
        child: DocumentPage(
      windowController: WindowController.fromWindowId(windowId),
      args: argument,
    )));
  } else {
    await initWindow();

    await initHive();

    runApp(const ProviderScope(child: MyApp()));
  }
}

initHive() async {
  await DBUtil.install();
  await DBUtil.getInstance();
}

initWindow() async {
  if (Platform.isMacOS || Platform.isWindows || Platform.isLinux) {
    WidgetsFlutterBinding.ensureInitialized();

    await windowManager.ensureInitialized();

    WindowOptions windowOptions = const WindowOptions(
      size: Size(830, 630),
      minimumSize: Size(830, 556),
      center: true,
      skipTaskbar: false,
      title: '',
      backgroundColor: Colors.white,
      titleBarStyle: TitleBarStyle.hidden,
    );
    windowManager.waitUntilReadyToShow(windowOptions, () async {
      await windowManager.show();
      await windowManager.focus();
    });
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const WechatHomePage());
  }
}
