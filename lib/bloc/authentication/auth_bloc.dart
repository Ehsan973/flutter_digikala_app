import 'package:bloc/bloc.dart';
import 'package:digikala_app/bloc/authentication/auth_event.dart';
import 'package:digikala_app/bloc/authentication/auth_state.dart';
import 'package:digikala_app/data/repository/authentication_repository.dart';
import 'package:digikala_app/di/di.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final IAuthRepository _repository = locator.get();
  AuthBloc() : super(AuthInitialState()) {
    on<AuthLoginRequest>((event, emit) async {
      emit(AuthLoadingState());
      var response = await _repository.login(event.username, event.password);
      emit(AuthResponseState(response));
    });

    on<AuthRegisterRequest>((event, emit) async {
      emit(AuthLoadingState());
      var response = await _repository.register(
          event.username, event.password, event.passwordConfirm);
      emit(AuthResponseState(response));
    });
  }
}
