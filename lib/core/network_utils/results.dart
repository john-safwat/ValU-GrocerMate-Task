import 'package:valu_task/core/network_utils/app_errors.dart';
import 'package:valu_task/core/network_utils/status.dart';

class Results<T> {
  final Status status;
  final T? data;
  final AppError? error;

  const Results.initial() : status = Status.initial, data = null, error = null;

  const Results.error({this.data, this.error}) : status = Status.error;

  const Results.success({this.data}) : status = Status.success, error = null;

  const Results.loading({this.data}) : status = Status.loading, error = null;
}
