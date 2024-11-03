import 'package:equatable/equatable.dart';

class ErrorResponseModel extends Equatable {
  int? status;
  String? message;
  Map<String, dynamic>? errors;

  ErrorResponseModel({this.status, this.message, this.errors});

  ErrorResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    errors = json['errors'];
  }

  @override
  // TODO: implement props
  List<Object?> get props => [status, message, errors];
}
