import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:uashopi_mobile/core/api_client.dart';
import 'package:uashopi_mobile/screens/login_screen.dart';
import 'package:uashopi_mobile/utils/validator.dart';
import 'package:shared_preferences/shared_preferences.dart';

final GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();

class BookingAddScreen extends StatefulWidget {
  const BookingAddScreen({Key? key}) : super(key: key);

  @override
  State<BookingAddScreen> createState() => _BookingAddScreenState();
}

class _BookingAddScreenState extends State<BookingAddScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController userIdController = TextEditingController();
  final TextEditingController ruanganIdController = TextEditingController();
  final TextEditingController startBookController = TextEditingController();
  final TextEditingController endBookController = TextEditingController();
  final ApiClient _apiClient = ApiClient();
  String accesstoken = '';

  @override
  void initState() {
    super.initState();
    _loadToken();
  }

  _loadToken() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var data = localStorage.getString('accessToken');

    if (data != null) {
      setState(() {
        accesstoken = data;
      });
    }
  }

  Future<void> addBooking() async {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text('Processing Data'),
        backgroundColor: Colors.green.shade300,
      ));

      Map<String, dynamic> bookingData = {
        "user_id": userIdController.text,
        "ruangan_id": ruanganIdController.text,
        "start_book": startBookController.text,
        "end_book": endBookController.text,
      };

      final res = await _apiClient.addBooking(accesstoken, bookingData);

      ScaffoldMessenger.of(context).hideCurrentSnackBar();

      if (res.statusCode == 200 || res.statusCode == 201) {
        var msg = jsonDecode(res.body);
        ScaffoldMessenger.of(this.context).showSnackBar(SnackBar(
          content: Text('${msg['message'].toString()}'),
          backgroundColor: Colors.green.shade300,
        ));
        Navigator.pop(_scaffoldState.currentState!.context);
      } else if (res.statusCode == 401) {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const LoginScreen()));
      } else if (res.statusCode == 500) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Error: Internal Server Error 500'),
          backgroundColor: Colors.red.shade300,
        ));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Error: ${res.body.toString()}'),
          backgroundColor: Colors.red.shade300,
        ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldState,
      backgroundColor: Colors.blueGrey[200],
      body: Form(
        key: _formKey,
        child: SizedBox(
          width: size.width,
          height: size.height,
          child: Align(
            alignment: Alignment.center,
            child: Container(
              width: size.width * 0.85,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    //   SizedBox(height: size.height * 0.08),
                    const Center(
                      child: Text(
                        "Tambah Booking",
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: size.height * 0.05),

                    SizedBox(height: size.height * 0.03),
                    TextFormField(
                      validator: (value) => Validator.validateText(value ?? ""),
                      controller: userIdController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        hintText: "User ID",
                        isDense: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    SizedBox(height: size.height * 0.03),
                    TextFormField(
                      validator: (value) => Validator.validateText(value ?? ""),
                      controller: ruanganIdController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        hintText: "Ruangan ID",
                        isDense: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    SizedBox(height: size.height * 0.03),
                    TextFormField(
                      validator: (value) => Validator.validateText(value ?? ""),
                      controller: startBookController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        hintText: "Start Book",
                        isDense: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    SizedBox(height: size.height * 0.03),
                    TextFormField(
                      validator: (value) => Validator.validateText(value ?? ""),
                      controller: endBookController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        hintText: "End Book",
                        isDense: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    SizedBox(height: size.height * 0.06),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: addBooking,
                        style: ElevatedButton.styleFrom(
                            primary: Colors.indigo,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 40, vertical: 15)),
                        child: const Text(
                          "Save",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
