import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../data/repositories/auth_repository.dart';
import '../../data/models/user_model.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository repository;

  AuthBloc(this.repository) : super(const AuthInitial()) {
    on<LoginSubmitted>(_onLoginSubmitted);
    on<LoadUser>(_onLoadUser);
    on<LogoutRequested>(_onLogoutRequested);
  }

  Future<void> _onLoginSubmitted(
    LoginSubmitted event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());
    
    try {
      final user = await repository.login(event.email, event.password);
      emit(AuthSuccess(user));
    } catch (e) {
      emit(AuthFailure(
        e.toString().replaceFirst('Exception: ', ''),
      ));
    }
  }

  Future<void> _onLoadUser(
    LoadUser event,
    Emitter<AuthState> emit,
  ) async {
    // Ne pas afficher de loading si on vérifie juste le token
    try {
      final user = await repository.getCurrentUser();
      emit(AuthSuccess(user));
    } catch (e) {
      // Si pas de token valide, rester sur l'état initial (pas d'erreur)
      emit(const AuthInitial());
    }
  }

  Future<void> _onLogoutRequested(
    LogoutRequested event,
    Emitter<AuthState> emit,
  ) async {
    await repository.logout();
    emit(const AuthInitial());
  }
}