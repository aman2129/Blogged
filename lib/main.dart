import 'package:blog_app/data_model/data_model.dart';
import 'package:blog_app/views/auth_screens/login_screen.dart';
import 'package:blog_app/views/auth_screens/register_screen.dart';
import 'package:blog_app/views/auth_screens/verify_email_view.dart';
import 'package:blog_app/views/blog_screens/blocs/blog_bloc/blog_bloc.dart';
import 'package:blog_app/views/blog_screens/blocs/bookmark_bloc/bookmark_bloc.dart';
import 'package:blog_app/views/blog_screens/blocs/internet_bloc/internet_bloc.dart';
import 'package:blog_app/views/blog_screens/blog_home/blog_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

const primaryColor = Color(0xFF151026);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Hive.initFlutter();
  Hive.registerAdapter<BlogDataModel>(BlogDataModelAdapter());
  await Hive.openBox('bookmark');
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => BlogBloc(),
        ),
        BlocProvider(
          create: (context) => InternetBloc(),
        ),
        BlocProvider(
          create: (context) => BookmarkBloc(),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(
            colorSchemeSeed: const Color(0xffffffff),
          fontFamily: GoogleFonts.aleo().fontFamily,
          useMaterial3: true
        ),
        debugShowCheckedModeBanner: false,
        home: const HomePage(),
        routes: {
          '/RegisterScreen/': (context) => const RegisterScreen(),
          '/LoginScreen/': (context) => const LoginScreen(),
          '/VerifyEmailView/': (context) => const VerifyEmailView(),
          '/BlogView/': (context) => BlogView(),
        },
      ),
    ),
  );
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            final user = FirebaseAuth.instance.currentUser;
            if (user != null) {
              if (user.emailVerified) {
                return const LoginScreen();
              } else {
                return const VerifyEmailView();
              }
            } else {
              return const LoginScreen();
            }
          default:
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
        }
      },
    );
  }
}

