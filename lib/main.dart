import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'core/theme/app_theme.dart';
import 'features/shell/main_shell.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );
  runApp(const BookMyTestApp());
}

class BookMyTestApp extends StatelessWidget {
  const BookMyTestApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Book My Test',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      home: const MainShell(),
    );
  }
}
