import 'dart:io';
import 'package:flutter/material.dart';
import 'package:wechat/hive/hive_tool.dart';
import 'package:wechat/page/wechat_home_page.dart';
import 'package:window_manager/window_manager.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
void main() async {
  await initWindow();

  await initHive();

  runApp(const ProviderScope(child:MyApp()));
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
