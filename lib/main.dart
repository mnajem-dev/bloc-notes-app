import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'pages/home_page.dart';
import 'services/note_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  runApp(MyApp(prefs: prefs));
}

class MyApp extends StatelessWidget {
  final SharedPreferences prefs;

  const MyApp({super.key, required this.prefs});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => NoteService(prefs),
      child: MaterialApp(
        title: 'Bloc-Notes',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.deepPurple,
            brightness: Brightness.light,
            surface: const Color(0xFFF8F9FA),
            surfaceContainer: Colors.white,
          ),
          scaffoldBackgroundColor: const Color(0xFFF8F9FA),
          textTheme: GoogleFonts.poppinsTextTheme(
            ThemeData.light().textTheme,
          ),
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.transparent,
            elevation: 0,
            centerTitle: false,
            iconTheme: IconThemeData(color: Colors.black87),
            titleTextStyle: TextStyle(
              color: Colors.black87,
              fontSize: 24,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        home: const HomePage(),
      ),
    );
  }
}
