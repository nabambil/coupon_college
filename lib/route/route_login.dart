import 'dart:async';
import 'dart:ui';

import 'package:coupon_college/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final FocusNode fieldID = FocusNode();
  final FocusNode fieldIC = FocusNode();
  final TextEditingController controllerID = TextEditingController();
  final TextEditingController controllerIC = TextEditingController();

  _LoginScreenState(){
    controllerID.addListener(() => print(controllerID.text));
    controllerIC.addListener(() => print(controllerIC.text));
  }

  @override
  void dispose() {
    fieldIC.dispose();
    fieldID.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: _Body(
          fieldIC: fieldIC,
          fieldID: fieldID,
          controllerIC: controllerIC,
          controllerID: controllerID,
        ),
      ),
      floatingActionButton: _FloatingButton(value: _formKey, idController: controllerID, icController: controllerIC),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

class _Body extends StatelessWidget {
  final FocusNode fieldID;
  final FocusNode fieldIC;
  final TextEditingController controllerID;
  final TextEditingController controllerIC;
  final ScrollController _controller = ScrollController();

  _Body(
      {@required this.fieldIC,
      @required this.fieldID,
      @required this.controllerID,
      @required this.controllerIC});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) currentFocus.unfocus();
      },
      child: SingleChildScrollView(
        controller: _controller,
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/login_background.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 4.0, sigmaY: 4.0),
            child: Container(
              padding: const EdgeInsets.all(24.0),
              color: Colors.white38,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/logo.png', height: 160),
                  SizedBox(height: 40),
                  _Title(),
                  _Field(
                    label: "Student ID",
                    type: FieldType.id,
                    node: fieldID,
                    next: () => fieldIC.requestFocus(),
                    tap: fieldTap,
                    onChange: controllerID,
                  ),
                  _Field(
                    label: "IC Number",
                    type: FieldType.password,
                    node: fieldIC,
                    next: () => fieldIC.unfocus(),
                    tap: fieldTap,
                    onChange: controllerIC,
                  ),
                  SizedBox(height: 60)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void fieldTap() {
    Timer(Duration(milliseconds: 500), () => _controller.jumpTo(120));
  }
}

class _Title extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 32.0),
      child: Text(
        'E-Coupon College for Kolej Melati',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
      ),
    );
  }
}

enum FieldType { id, password }

class _Field extends StatefulWidget {
  final String label;
  final FieldType type;
  final FocusNode node;
  final Function next;
  final Function tap;
  final TextEditingController onChange;

  _Field({
    @required this.label,
    @required this.type,
    @required this.node,
    @required this.next,
    @required this.tap,
    @required this.onChange,
  });

  @override
  __FieldState createState() => __FieldState();
}

class __FieldState extends State<_Field> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.onChange,
      focusNode: widget.node,
      keyboardType: TextInputType.numberWithOptions(),
      decoration: InputDecoration(
        labelText: widget.label,
        prefixIcon: widget.type == FieldType.id
            ? Icon(Icons.chrome_reader_mode)
            : Icon(Icons.person),
      ),
      validator: (value) {
        if (value.length < 8) return '${widget.label} must be more than 8';
        return null;
      },
      onFieldSubmitted: (text) {
        if (text.length > 8) widget.next();
      },
      onTap: widget.tap,
    );
  }
}

class _FloatingButton extends StatelessWidget {
  final GlobalKey<FormState> _formKey;
  final TextEditingController icController;
  final TextEditingController idController;
  final List<String> ics;
  final List<String> ids;
  _FloatingButton(
      {@required GlobalKey<FormState> value,
      @required this.icController,
      @required this.idController})
      : this._formKey = value,
        this.ics = users.map<String>((f) => f.ic).toList(),
        this.ids = users.map<String>((f) => f.id).toList();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: FloatingActionButton.extended(
        label: Text("  LOGIN  "),
        // backgroundColor: Colors.black54,
        onPressed: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) currentFocus.unfocus();

          if (_formKey.currentState.validate()) {
            final controller = Scaffold.of(context)
                .showSnackBar(SnackBar(content: Text('Processing..')));

            Timer(Duration(seconds: 2), () {
              controller.close();
              if (ics.contains(icController.text) && ids.contains(idController.text))
                Navigator.pushReplacementNamed(context, route_home, arguments: idController.text);
              else if(!ics.contains(icController.text) && ids.contains(idController.text))
                Toast.show("Incorrect ic number or id number", context, duration: 1);
              else
                Navigator.pushReplacementNamed(context, route_profile, arguments: idController.text);
            });
          } else {
            Toast.show("Please check all field", context, duration: 1);
          }
        },
      ),
    );
  }
}
