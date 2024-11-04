import 'package:tus_canchas_app_v2/domain/models/payment.dart';
import 'package:tus_canchas_app_v2/domain/models/sports_field.dart';

class Reservation {
  late String reservationId;
  late DateTime reservatioDate;
  late double hoursNumber;
  late Payment reservatioPayment;
  late SportsField sportsField;

  Reservation(
      {required this.reservationId,
      required this.reservatioDate,
      required this.hoursNumber,
      required this.reservatioPayment, required this.sportsField});

  factory Reservation.fromJson(Map<String, dynamic> dataJson) {
    return Reservation(
        reservationId: dataJson['reservation_id']??'not reservatio id',
        reservatioDate: dataJson['reservation_date']??DateTime.now(),
        hoursNumber: dataJson['hours_number']??0,
        reservatioPayment: Payment.fromJson(dataJson['reservation_payment']),
        sportsField: SportsField.fromJson(dataJson['sports_field']));
  }

  Map<String, dynamic> toMap() {
    return {
      'reservation_id': reservationId,
      'reservation_date': DateTime.now(),
      'hours_number':hoursNumber,
      'reservation_payment':reservatioPayment.toMap(),
      'sports_field':sportsField.toMap()
    };
  }
}
