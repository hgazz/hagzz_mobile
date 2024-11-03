class RegisterValidationErrorModel {
  int? status;
  String? message;
  Errors? errors;

  RegisterValidationErrorModel({this.status, this.message, this.errors});

  RegisterValidationErrorModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    errors =
        json['errors'] != null ? new Errors.fromJson(json['errors']) : null;
  }
}

class Errors {
  List<String>? phone;

  Errors({
    this.phone,
  });

  Errors.fromJson(Map<String, dynamic> json) {
    phone = json['phone'].cast<String>();
  }
}
