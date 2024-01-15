import 'dart:convert';
import 'package:http/http.dart' as http;

class Booking {
  int id;
  String nama_booking;
  String keterangan;
  String created_at;
  String updated_at;
  String kapasitas;

  static final http.Client client = http.Client();

  Booking(
      {this.id = 0,
      required this.nama_booking,
      required this.keterangan,
      required this.kapasitas,
      required this.created_at,
      required this.updated_at});

  factory Booking.fromJson(Map<String, dynamic> map) {
    return Booking(
        id: map["id"],
        nama_booking: map["nama_booking"],
        keterangan: map["keterangan"],
        kapasitas: map["kapasitas"],
        created_at: map["created_at"],
        updated_at: map["updated_at"]);
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "nama_booking": nama_booking,
      "keterangan": keterangan,
      "kapasitas": kapasitas,
      "created_at": created_at,
      "updated_at": updated_at
    };
  }

  @override
  String toString() {
    return 'Booking{id: $id, nama_booking: $nama_booking, keterangan: $keterangan, created_at: $created_at, "updated_at": $updated_at }';
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
