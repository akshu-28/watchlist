part of 'registration_bloc.dart';

abstract class RegistrationState {}

class RegistrationInitial extends RegistrationState {}

class RegistrationLoad extends RegistrationState {}

class RegistrationDone extends RegistrationState {
  final RegistrationResponse response;

  RegistrationDone(this.response);
}

class LoginDone extends RegistrationState {
  final LoginResponse response;

  LoginDone(this.response);
}

class RegistrationError extends RegistrationState {
  final String error;

  RegistrationError(this.error);
}
