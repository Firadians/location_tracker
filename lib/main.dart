import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:location_tracker/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:location_tracker/features/auth/domain/repositories/auth_repository.dart';
import 'package:location_tracker/features/auth/presentation/pages/login_screen.dart';
import 'package:location_tracker/features/auth/presentation/pages/register_screen.dart';
import 'package:location_tracker/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final AuthRepository authRepository = AuthRepository();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(authRepository),
      child: MaterialApp(
        title: 'Flutter Firebase Auth',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => BlocBuilder<AuthBloc, AuthState>(
                builder: (context, state) {
                  if (state is AuthAuthenticated) {
                    return HomeScreen(); // Go to Home if authenticated
                  } else {
                    return LoginScreen(); // Show Login by default
                  }
                },
              ),
          '/register': (context) => RegisterScreen(),
          '/home': (context) => HomeScreen(),
        },
      ),
    );
  }
}
