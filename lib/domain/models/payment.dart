class Payment {
  late String paymentReference;
  late double paymentValue;
  late DateTime paymentDate;
  late String proofPayment;

  Payment(
      {required this.paymentReference,
      required this.paymentValue,
      required this.paymentDate,
      required this.proofPayment});
  factory Payment.fromJson(Map<String, dynamic> dataJson) {
    return Payment(
        paymentReference: dataJson['payment_reference']??'not reference',
        paymentValue: dataJson['payment_value']??0,
        paymentDate: dataJson['payment_date']??DateTime.now(),
        proofPayment: dataJson['proof_payment']??'not proof of payment');
  }

  Map<String,dynamic> toMap(){
    return {
      'payment_reference':paymentReference,
      'payment_value':paymentValue,
      'payment_date':DateTime.now()
    };
  }
}
