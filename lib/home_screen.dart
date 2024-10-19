import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:location_tracker/features/auth/presentation/bloc/auth_bloc.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              BlocProvider.of<AuthBloc>(context).add(LogoutEvent());
            },
          ),
        ],
      ),
      body: Center(child: Text('Welcome to Home Screen!')),
    );
  }
}
