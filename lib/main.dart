import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:blog/firebase_options.dart';
import 'package:blog/views/sign_in.dart';
import 'package:blog/viewmodel/home_viewmodel.dart';
import 'package:blog/viewmodel/profile_viewmodel.dart';
import 'package:blog/data/repositories/local/blog_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => HomeViewModel()),
        ChangeNotifierProvider(
          create: (_) => ProfileViewModel(blogRepository: BlogRespository()),
        ),
      ],
      child: MaterialApp(
        title: 'Blog App',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        debugShowCheckedModeBanner: false,
        home: const SignInScreen(),
      ),
    );
  }
}