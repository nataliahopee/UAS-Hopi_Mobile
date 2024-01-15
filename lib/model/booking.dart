import 'dart:convert';
import 'package:http/http.dart' as http;

class Booking {
  int id;
  String user_id;
  String ruangan_id;
  String start_book;
  String end_book;

  static final http.Client client = http.Client();

  Booking({
    this.id = 0,
    required this.user_id,
    required this.ruangan_id,
    required this.start_book,
    required this.end_book,
  });

  factory Booking.fromJson(Map<String, dynamic> map) {
    return Booking(
      id: map["id"],
      user_id: map["user_id"],
      ruangan_id: map["ruangan_id"],
      start_book: map["start_book"],
      end_book: map["end_book"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "user_id": user_id,
      "ruangan_id": ruangan_id,
      "start_book": start_book,
      "end_book": end_book,
    };
  }

  @override
  String toString() {
    return 'Booking{id: $id, user_id: $user_id, ruangan_id: $ruangan_id, start_book: $start_book, "end_book": $end_book }';
  }

  static void dispose() {
    client.close();
  }
}

List<Booking> bookingFromJson(String jsonData) {
  final data = json.decode(jsonData);
  return List<Booking>.from(data.map((item) => Booking.fromJson(item)));
}

String bookingToJson(Booking data) {
  final jsonData = data.toJson();
  return json.encode(jsonData);
}
