import 'package:equatable/equatable.dart';

class PaymentModel extends Equatable {
  ResultObj? resultObj;
  int? returnCode;
  int? errorCode;
  String? errorMessage;
  String? error;
  String? validationErrors;
  bool? hasError;
  bool? hasValidationError;

  PaymentModel(
      {this.resultObj,
      this.returnCode,
      this.errorCode,
      this.errorMessage,
      this.error,
      this.validationErrors,
      this.hasError,
      this.hasValidationError});

  PaymentModel.fromJson(Map<String, dynamic> json) {
    resultObj = json['resultObj'] != null
        ? new ResultObj.fromJson(json['resultObj'])
        : null;
    returnCode = json['returnCode'];
    errorCode = json['errorCode'];
    errorMessage = json['errorMessage'];
    error = json['error'];
    validationErrors = json['validationErrors'];
    hasError = json['hasError'];
    hasValidationError = json['hasValidationError'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.resultObj != null) {
      data['resultObj'] = this.resultObj!.toJson();
    }
    data['returnCode'] = this.returnCode;
    data['errorCode'] = this.errorCode;
    data['errorMessage'] = this.errorMessage;
    data['error'] = this.error;
    data['validationErrors'] = this.validationErrors;
    data['hasError'] = this.hasError;
    data['hasValidationError'] = this.hasValidationError;
    return data;
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
        resultObj,
        returnCode,
        errorCode,
        errorMessage,
        error,
        validationErrors,
        hasError,
        hasValidationError,
      ];
}

class ResultObj extends Equatable {
  String? id;
  int? statusId;
  String? created;
  String? payUrl;
  String? amount;
  int? firstPaymentAmount;
  String? currency;
  String? transactionId;
  String? finishedDate;
  String? custom1;
  String? custom2;
  String? custom3;
  String? custom4;
  String? custom5;
  String? custom6;
  String? custom7;
  String? custom8;
  String? custom9;
  String? custom10;
  String? visaId;
  String? refundId;
  String? refundStatusId;
  String? tokenId;
  String? status;
  String? cardType;
  String? cardNumber;
  String? recurringSubscriptionId;
  String? info;

  ResultObj(
      {this.id,
      this.statusId,
      this.created,
      this.payUrl,
      this.amount,
      this.firstPaymentAmount,
      this.currency,
      this.transactionId,
      this.finishedDate,
      this.custom1,
      this.custom2,
      this.custom3,
      this.custom4,
      this.custom5,
      this.custom6,
      this.custom7,
      this.custom8,
      this.custom9,
      this.custom10,
      this.visaId,
      this.refundId,
      this.refundStatusId,
      this.tokenId,
      this.status,
      this.cardType,
      this.cardNumber,
      this.recurringSubscriptionId,
      this.info});

  ResultObj.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    statusId = json['statusId'];
    created = json['created'];
    payUrl = json['payUrl'];
    amount = json['amount'];
    firstPaymentAmount = json['firstPaymentAmount'];
    currency = json['currency'];
    transactionId = json['transactionId'];
    finishedDate = json['finishedDate'];
    custom1 = json['custom1'];
    custom2 = json['custom2'];
    custom3 = json['custom3'];
    custom4 = json['custom4'];
    custom5 = json['custom5'];
    custom6 = json['custom6'];
    custom7 = json['custom7'];
    custom8 = json['custom8'];
    custom9 = json['custom9'];
    custom10 = json['custom10'];
    visaId = json['visaId'];
    refundId = json['refundId'];
    refundStatusId = json['refundStatusId'];
    tokenId = json['tokenId'];
    status = json['status'];
    cardType = json['cardType'];
    cardNumber = json['cardNumber'];
    recurringSubscriptionId = json['recurringSubscriptionId'];
    info = json['info'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['statusId'] = this.statusId;
    data['created'] = this.created;
    data['payUrl'] = this.payUrl;
    data['amount'] = this.amount;
    data['firstPaymentAmount'] = this.firstPaymentAmount;
    data['currency'] = this.currency;
    data['transactionId'] = this.transactionId;
    data['finishedDate'] = this.finishedDate;
    data['custom1'] = this.custom1;
    data['custom2'] = this.custom2;
    data['custom3'] = this.custom3;
    data['custom4'] = this.custom4;
    data['custom5'] = this.custom5;
    data['custom6'] = this.custom6;
    data['custom7'] = this.custom7;
    data['custom8'] = this.custom8;
    data['custom9'] = this.custom9;
    data['custom10'] = this.custom10;
    data['visaId'] = this.visaId;
    data['refundId'] = this.refundId;
    data['refundStatusId'] = this.refundStatusId;
    data['tokenId'] = this.tokenId;
    data['status'] = this.status;
    data['cardType'] = this.cardType;
    data['cardNumber'] = this.cardNumber;
    data['recurringSubscriptionId'] = this.recurringSubscriptionId;
    data['info'] = this.info;
    return data;
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
        id,
        statusId,
        created,
        payUrl,
        amount,
        firstPaymentAmount,
        currency,
        transactionId,
        finishedDate,
        custom1,
        custom2,
        custom3,
        custom4,
        custom5,
        custom6,
        custom7,
        custom8,
        custom9,
        custom10,
        visaId,
        refundId,
        refundStatusId,
        tokenId,
        status,
        cardType,
        cardNumber,
        recurringSubscriptionId,
        info,
      ];
}
