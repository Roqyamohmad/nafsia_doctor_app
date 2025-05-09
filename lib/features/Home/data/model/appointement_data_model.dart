class AppointmentDataModel {
  final String? id;
  final String? day;
  final String? startAtHour;
  final int? duration;
  final int? price;
  final String? title;

  AppointmentDataModel({
    this.id,
    this.day,
    this.startAtHour,
    this.duration,
    this.price,
    this.title,
  });

  factory AppointmentDataModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'] ?? json; // fallback if no 'data' wrapper
    return AppointmentDataModel(
      id: data['_id'] ?? '',
      day: data['day'] ?? '',
      startAtHour: data['startAtHour'] ?? '',
      duration: data['duration'] ?? 0,
      price: data['price'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'day': day,
      'startAtHour': startAtHour,
      'duration': duration,
      'price': price,
    };
  }
}
