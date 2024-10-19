import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:location_tracker/features/auth/presentation/bloc/auth_bloc.dart';

class RegisterScreen extends StatelessWidget {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Register')),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthError) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(state.error),
            ));
          } else if (state is AuthAuthenticated) {
            Navigator.pop(context); // Go back after successful registration
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
                    controller: usernameController,
                    decoration: InputDecoration(labelText: 'Username')),
                TextField(
                    controller: emailController,
                    decoration: InputDecoration(labelText: 'Email')),
                TextField(
                    controller: passwordController,
                    decoration: InputDecoration(labelText: 'Password'),
                    obscureText: true),
                TextField(
                    controller: confirmPasswordController,
                    decoration: InputDecoration(labelText: 'Re-enter Password'),
                    obscureText: true),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    BlocProvider.of<AuthBloc>(context).add(RegisterUserEvent(
                      username: usernameController.text,
                      email: emailController.text,
                      password: passwordController.text,
                      confirmPassword: confirmPasswordController.text,
                    ));
                  },
                  child: Text('Register'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
