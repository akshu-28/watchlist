

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../model/login_request.dart';
import '../../model/login_response.dart';
import '../../repository/login_repo.dart';


part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginRequestEvent>((event, emit) async {
      emit(LoginLoad());
      try {
        var response = await LoginRepository().login(event.loginRequest);
        emit(LoginDone(response));
      } catch (e) {
        emit(LoginError(e.toString()));
      }
    });
  }
}
