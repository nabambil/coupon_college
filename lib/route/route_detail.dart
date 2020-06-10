import 'dart:async';

import 'package:coupon_college/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

class DetailScreen extends StatefulWidget {
  final Invitation invitation;

  DetailScreen(this.invitation);

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  bool enableFloating = false;
  String title = 'Upcoming Event/ Activities';

  @override
  void initState() {
    super.initState();

    Timer(
        Duration(milliseconds: 500),
        () => setState(() => enableFloating =
            widget.invitation.type != InvitationType.attended));

    switch (widget.invitation.type) {
      case InvitationType.non:
        title = '🌟 Upcoming 🌟';
        break;
      case InvitationType.attend:
        title = '🙋🏻 Attempt 🙋🏻';
        break;
      case InvitationType.not:
        title = '🤷🏻‍♂️ Attempt 🤷🏻‍♂️';
        break;
      case InvitationType.attended:
        title = '🎯 Collected 🎯';
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepOrangeAccent,
      appBar: AppBar(
        title: Text(title),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.share),
              onPressed: () {
                showModalBottomSheet(
                    context: context,
                    builder: (BuildContext bc) {
                      return Container(
                        child: new Wrap(
                          children: <Widget>[
                            new ListTile(
                                title: new Text('Share To:',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold))),
                            new ListTile(
                                title: new Text('WhatsApp'),
                                onTap: () {
                                  Toast.show("Not support at moment", context);
                                  Navigator.pop(context);
                                }),
                            new ListTile(
                              title: new Text('Telegram'),
                              onTap: () {
                                Toast.show("Not support at moment", context);
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        ),
                      );
                    });
              })
        ],
      ),
      body: _Body(invitation: widget.invitation),
      floatingActionButton: enableFloating ? _FloatingAction() : null,
    );
  }
}

class _Body extends StatelessWidget {
  final Invitation invitation;

  _Body({@required this.invitation});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 24),
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          _Card(invitation: invitation),
          Spacer(),
          if (invitation.type == InvitationType.attended)
            Padding(
              padding: EdgeInsets.only(bottom: 32),
              child: Text(
                "Thanks for Coming to our Event",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
            ),
          if (invitation.type == InvitationType.attend)
            Padding(
              padding: EdgeInsets.only(bottom: 120),
              child: Text(
                "Can't Wait to see you.",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
            ),
          if (invitation.type == InvitationType.not)
            Padding(
              padding: EdgeInsets.only(bottom: 120),
              child: Text(
                "You chosing not come, why not?",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
            ),
        ],
      ),
      // ),
    );
  }
}

class _Card extends StatelessWidget {
  final Invitation invitation;
  _Card({@required this.invitation});
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
                TableRow(children: [title("Events "), data(invitation.name)]),
                TableRow(children: [title("Date "), data(invitation.date)]),
                TableRow(children: [title("Venue "), data(invitation.venue)]),
                TableRow(
                    children: [title("Info "), data(invitation.description)]),
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

class _FloatingAction extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          FloatingActionButton.extended(
            heroTag: "Attend",
            label: Text("😄 Attend"),
            onPressed: () {
              Toast.show("See you there!", context, gravity: Toast.CENTER);
              Timer(Duration(seconds: 1), () => Navigator.pop(context));
            },
          ),
          SizedBox(width: 12),
          FloatingActionButton.extended(
            heroTag: "Not Attend",
            label: Text("☹️ I'm Sorry"),
            onPressed: () {
              Toast.show(
                "Hoping you coming.",
                context,
                gravity: Toast.CENTER,
              );
              Timer(Duration(seconds: 1), () => Navigator.pop(context));
            },
          ),
        ],
      ),
    );
  }
}
