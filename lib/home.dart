import 'dart:convert';

import 'package:cowin/slots.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController pincodeController = TextEditingController();
  TextEditingController dayController = TextEditingController();
  String dropdownValue = "01";
  List slots = [];

  fetchSlots() async {
    await http
        .get(Uri.parse(
            'https://cdn-api.co-vin.in/api/v2/appointment/sessions/public/findByPin?pincode=' +
                pincodeController.text +
                '&date=' +
                dayController.text +
                '%2F' +
                dropdownValue +
                '%2F2022'))
        .then((value) {
      Map result = jsonDecode(value.body);
      setState(() {
        slots = result['sessions'];
      });
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Slots(slots: slots),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Enter Details",
          style: TextStyle(fontSize: 25),
        ),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(10),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.all(20),
                height: 250,
                child: Image.asset("assets/vaccine1.png"),
              ),
              TextField(
                controller: pincodeController,
                keyboardType: TextInputType.number,
                maxLength: 6,
                decoration: InputDecoration(
                  labelText: "Pin Code",
                  labelStyle: TextStyle(color: Colors.black),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.cyan),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      height: 60,
                      child: TextField(
                        controller: dayController,
                        keyboardType: TextInputType.datetime,
                        decoration: InputDecoration(
                          labelText: "Date",
                          labelStyle: TextStyle(color: Colors.black),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.cyan),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: Container(
                      height: 70,
                      child: DropdownButton<String>(
                        value: dropdownValue,
                        isExpanded: true,
                        icon: const Icon(Icons.arrow_drop_down),
                        elevation: 16,
                        style: const TextStyle(color: Colors.black),
                        underline: Container(
                          height: 2,
                          color: Colors.cyan,
                        ),
                        onChanged: (String? newValue) {
                          setState(() {
                            dropdownValue = newValue!;
                          });
                        },
                        items: <String>[
                          '01',
                          '02',
                          '03',
                          '04',
                          '05',
                          '06',
                          '07',
                          '08',
                          '09',
                          '10',
                          '11',
                          '12'
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                width: double.infinity,
                height: 45,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        Theme.of(context).primaryColor),
                  ),
                  child: Text(
                    "Find Slots",
                    style: TextStyle(fontSize: 20),
                  ),
                  onPressed: () {
                    fetchSlots();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
