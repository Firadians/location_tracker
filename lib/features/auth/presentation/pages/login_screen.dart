import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:location_tracker/features/auth/presentation/bloc/auth_bloc.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthError) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(state.error),
            ));
          } else if (state is AuthAuthenticated) {
            Navigator.pushReplacementNamed(
                context, '/home'); // Navigate to home after successful login
          }
        },
        builder: (context, state) {
          if (state is AuthLoading) {
            return Center(child: CircularProgressIndicator());
          }
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextField(
                    controller: emailController,
                    decoration: InputDecoration(labelText: 'Email')),
                TextField(
                    controller: passwordController,
                    decoration: InputDecoration(labelText: 'Password'),
                    obscureText: true),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    BlocProvider.of<AuthBloc>(context).add(LoginUserEvent(
                      email: emailController.text,
                      password: passwordController.text,
                    ));
                  },
                  child: Text('Login'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
