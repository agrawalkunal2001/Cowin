import 'package:flutter/material.dart';

class Slots extends StatefulWidget {
  final List slots;
  Slots({required this.slots});

  @override
  State<Slots> createState() => _SlotsState();
}

class _SlotsState extends State<Slots> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Available Slots",
          style: TextStyle(fontSize: 25),
        ),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: ListView.builder(
          itemCount: widget.slots.length,
          itemBuilder: (context, index) {
            return Container(
              height: 350,
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.all(10),
              color: Colors.black12,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Center ID: " + widget.slots[index]['center_id'].toString(),
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    "Center Name: " + widget.slots[index]['name'].toString(),
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    "Center Address: " +
                        widget.slots[index]['address'].toString(),
                    style: TextStyle(fontSize: 16),
                  ),
                  Divider(
                    thickness: 1,
                  ),
                  Text(
                    "Vaccine Name: " +
                        widget.slots[index]['vaccine'].toString(),
                    style: TextStyle(fontSize: 16),
                  ),
                  Divider(
                    thickness: 1,
                  ),
                  Text(
                    "Slots: " + widget.slots[index]['slots'].toString(),
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
