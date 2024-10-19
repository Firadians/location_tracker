import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:location_tracker/features/auth/domain/repositories/auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;

  AuthBloc(this._authRepository) : super(AuthInitial()) {
    on<RegisterUserEvent>((event, emit) async {
      emit(AuthLoading());

      if (event.password != event.confirmPassword) {
        emit(AuthError('Passwords do not match.'));
        return;
      }

      try {
        final user = await _authRepository.registerUser(
          username: event.username,
          email: event.email,
          password: event.password,
        );

        if (user != null) {
          emit(AuthAuthenticated(user.uid));
        }
      } catch (e) {
        emit(AuthError(e.toString()));
      }
    });

    on<LoginUserEvent>((event, emit) async {
      emit(AuthLoading());

      try {
        final user = await _authRepository.loginUser(
          email: event.email,
          password: event.password,
        );

        if (user != null) {
          emit(AuthAuthenticated(user.uid));
        }
      } catch (e) {
        emit(AuthError(e.toString()));
      }
    });

    on<LogoutEvent>((event, emit) async {
      await _authRepository.signOut();
      emit(AuthInitial());
    });
  }
}
