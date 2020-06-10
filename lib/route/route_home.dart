import 'package:barcode_scan/barcode_scan.dart';
import 'package:coupon_college/utils/constant.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  final String id;

  HomeScreen({@required this.id});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  TabController _controller;

  _HomeScreenState() {
    _controller = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.person, size: 32),
            onPressed: () {
              showDialog(context: context, builder: (context) => _Dialog(id:widget.id));
            }),
        bottom: TabBar(
          controller: _controller,
          tabs: [
            Tab(
                child:
                    Text('UPCOMINGS', style: TextStyle(color: Colors.white))),
            Tab(child: Text('ATTEMPTS', style: TextStyle(color: Colors.white))),
            Tab(
                child:
                    Text('COLLECTED', style: TextStyle(color: Colors.white))),
          ],
        ),
        title: Text('e-Coupon College', style: TextStyle(color: Colors.white)),
        actions: <Widget>[
          IconButton(
              icon: Icon(
                Icons.exit_to_app,
                size: 32,
                color: Colors.white,
              ),
              onPressed: () => BarcodeScanner.scan().then((value) =>Navigator.pushNamed(context, route_scan)))
        ],
      ),
      body: _Body(ctlr: _controller),
    );
  }
}

class _Body extends StatelessWidget {
  final TabController controller;

  _Body({@required TabController ctlr}) : this.controller = ctlr;
  @override
  Widget build(BuildContext context) {
    return TabBarView(
      controller: controller,
      children: [
        _ListUpcoming(InvitationType.non, newEvents),
        _ListUpcoming(InvitationType.attend, attemptEvents),
        _ListUpcoming(InvitationType.attended, attendedEvents),
      ],
    );
  }

  
}

class _ListUpcoming extends StatelessWidget {
  final InvitationType type;
  final List<Invitation> contents;

  _ListUpcoming(a, List<Map<String,String>> values) : this.type = a ,
       this.contents = values.map<Invitation>((f) => _generateInvite(f, a)).toList();

  static Invitation _generateInvite(Map<String,String> value, type) => Invitation(value['event'], value['date'], value['venue'], value['description'], type: type);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (ctx, _) => Divider(
        color: Colors.deepOrange,
      ),
      padding: EdgeInsets.symmetric(horizontal: 6, vertical: 24),
      itemCount: contents.length,
      itemBuilder: (ctx, index) => _Tile(contents[index]),
    );
  }
}

class _Tile extends StatelessWidget {
  final Invitation invitation;

  _Tile(this.invitation);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(invitation.name),
      subtitle: Padding(
        padding: const EdgeInsets.all(6.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(invitation.venue),
            SizedBox(height: 6),
            Text(
              invitation.date,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ],
        ),
      ),
      onTap: () =>
          Navigator.pushNamed(context, route_detail, arguments: invitation),
    );
  }
}

class _Dialog extends StatelessWidget {
  final User user;
  final String id;

  _Dialog({@required this.id}): this.user = users.firstWhere((test) => test.id == id, orElse: () =>  User(
    name: "Syafiqah binti Azhar",
    id: "2015291042",
    ic: "921011-14-4321",
    semester: "4",
    course: "CS404",
    phone: "019-8762342",
    room: "123",
  ));

  final EdgeInsets padding =
      EdgeInsets.symmetric(vertical: 4.0, horizontal: 12.0);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: EdgeInsets.all(12),
        height: MediaQuery.of(context).size.height * 0.8,
        width: MediaQuery.of(context).size.width * 0.8,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(
            children: <Widget>[
              Text("Profile", style: TextStyle(fontSize: 32)),
              Spacer(),
              IconButton(
                  icon: Icon(Icons.close, color: Colors.deepOrange),
                  onPressed: () => Navigator.pop(context)),
            ],
          ),
          SizedBox(height: 12),
          Table(
            columnWidths: {0: FractionColumnWidth(0.35)},
            children: [
              TableRow(children: [title("Name"), data(user?.name ?? '')]),
              TableRow(children: [title("Student ID"), data(user?.id ?? '')]),
              TableRow(children: [title("IC Number"), data(user?.ic ?? '')]),
              TableRow(children: [title("Semester"), data(user?.semester ?? '')]),
              TableRow(children: [title("Course"), data(user?.course ?? '')]),
              TableRow(children: [title("Phone"), data(user?.phone ?? '')]),
              TableRow(children: [title("Room"), data(user?.room ?? '')]),
            ],
          ),
          Spacer(),
          Divider(
            color: Colors.deepOrange,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              SizedBox(
                width: 38,
                child: RaisedButton(
                  padding: EdgeInsets.all(0),
                  shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(18.0)),
                  color: Colors.deepOrange,
                  child: Icon(
                    Icons.edit,
                    color: Colors.white,
                  ),
                  onPressed: () =>
                      Navigator.pushReplacementNamed(context, route_profile, arguments: id),
                ),
              ),
              SizedBox(width: 8),
              RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(18.0)),
                color: Colors.deepOrange,
                child: Text("Logout",
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.bold)),
                onPressed: () =>
                    Navigator.pushReplacementNamed(context, route_login),
              ),
              SizedBox(width: 12),
            ],
          )
        ]),
      ),
    );
  }

  TableCell title(String value) {
    return TableCell(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 6),
        child: Text(
          value + ' :',
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
