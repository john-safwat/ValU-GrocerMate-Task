import 'package:valu_task/core/base_ui/app_error_message.dart';

sealed class AppError {
  AppErrorMessage errorMessage;

  AppError(this.errorMessage);
}

class UnKnownError extends AppError {
  UnKnownError(super.errorMessage);
}

class NetworkError extends AppError {
  NetworkError(super.errorMessage);
}

class TimeoutError extends AppError {
  TimeoutError(super.errorMessage);
}

class ServerError extends AppError {
  final int? statusCode;

  ServerError(super.errorMessage, {this.statusCode});
}

class ClientError extends AppError {
  final int? statusCode;

  ClientError(super.errorMessage, {this.statusCode});
}

class UnauthorizedError extends AppError {
  UnauthorizedError(super.errorMessage);
}

class NotFoundError extends AppError {
  NotFoundError(super.errorMessage);
}

class ParsingError extends AppError {
  ParsingError(super.errorMessage);
}

class NoInternetError extends AppError {
  NoInternetError(super.errorMessage);
}
