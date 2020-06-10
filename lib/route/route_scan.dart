import 'package:coupon_college/utils/constant.dart';
import 'package:flutter/material.dart';

class ScanScreen extends StatefulWidget {
  @override
  _ScanScreenState createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orangeAccent,
      body: _Body(),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 12.0),
        child: FloatingActionButton.extended(onPressed: (){
          Navigator.pop(context);
        }, label: Text("Submit")),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}

class _Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) currentFocus.unfocus();
      },
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(top: 70),
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: <Widget>[
              _Card(),
              SizedBox(height: 20),
              _Card2(),
              SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}

class _Card extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 24.0),
              child: Text("Invitation Card", style: TextStyle(fontSize: 32)),
            ),
            Table(
              columnWidths: {0: FractionColumnWidth(0.25)},
              children: [
                TableRow(children: [title("Events "), data(value1)]),
                TableRow(children: [title("Date "), data(value2)]),
                TableRow(children: [title("Venue "), data(value3)]),
                TableRow(children: [title("Info "), data(value4)]),
              ],
            ),
            SizedBox(height: 24)
          ],
        ),
      ),
    );
  }

  TableCell title(String value) {
    return TableCell(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 6),
        child: Text(
          value + ':',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  TableCell data(String value) {
    return TableCell(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6.0),
        child: Text(
          value,
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}

class _Card2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 24),
            Text("Feedback", style: TextStyle(fontSize: 24)),
            TextField(
              maxLength: 100,
              decoration:
                  InputDecoration(hintText: "Please share your experience"),
              keyboardType: TextInputType.multiline,
              maxLines: null,
              minLines: null,
            ),
            SizedBox(height: 24)
          ],
        ),
      ),
    );
  }
}
