import 'package:coupon_college/utils/constant.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  final User user;
  final String id;

  ProfileScreen({@required this.id}): this.user = users.singleWhere((test) => test.id == id, orElse: () => null) ;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Update Profile"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: <Widget>[
            _Field("Name", value: user?.name),
            _Field("Student ID", value: user?.id),
            _Field("IC Number", value: user?.ic),
            _Field("Semester", value: user?.semester),
            _Field("Course", value: user?.course),
            _Field("Phone", value: user?.phone),
            _Field("Room", value: user?.room),
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom:12.0),
        child: FloatingActionButton.extended(
            onPressed: () {
              Navigator.pushReplacementNamed(context, route_home, arguments: id);
            },
            label: Text("Save", style: TextStyle(color: Colors.white),), backgroundColor: Colors.deepOrange,),
      ),
    );
  }
}

class _Field extends StatelessWidget {
  final String label;
  final String value;

  _Field(this.label, {this.value});

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(labelText: label),
      controller: new TextEditingController(text: value),
    );
  }
}
