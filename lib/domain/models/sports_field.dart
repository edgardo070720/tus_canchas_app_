class SportsField {
  late String sportsFieldId;
  late String sportsFieldName;
  late double hourValue;
  late List<String> availability;
  late String typeSportsField;
  late String detail;

  SportsField(
      {required this.sportsFieldId,
      required this.sportsFieldName,
      required this.hourValue,
      required this.availability,
      required this.typeSportsField,
      required this.detail});

  factory SportsField.fromJson(Map<String, dynamic> dataJson) {
    List<String> voidList = [];
    return SportsField(
        sportsFieldId: dataJson['sports_field_id'] ?? 'not id',
        sportsFieldName: dataJson['sports_field_name'] ?? 'not name',
        hourValue: dataJson['hour_value'] ?? 0,
        availability: dataJson['availability'] ?? voidList,
        typeSportsField:
            dataJson['type_sports_field'] ?? 'not type sports field',
        detail: dataJson['detail'] ?? 'not detail');
  }

  Map<String, dynamic> toMap() {
    return {
      'sports_field_id': sportsFieldId,
      'sports_field_name': sportsFieldName,
      'hour_value': hourValue,
      'availability': availability,
      'type_sports_field': typeSportsField,
      'detail': detail
    };
  }
}
