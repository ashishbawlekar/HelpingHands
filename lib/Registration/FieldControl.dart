
import 'package:flutter/material.dart';

class FieldControl extends StatelessWidget {
  FieldControl({
    this.label,
    this.hint,
    this.controller,
    this.autofocus = false,
    this.hideText = false,
    this.validate,
    this.keyboardType = TextInputType.text,
    this.maxlines = 1,
    this.maxLength,
    this.expand = false,
    this.icon,
    this.hpad = 30.0,
  });
  @required
  var label;
  var autofocus;
  var hideText;
  TextEditingController controller;
  @required
  var hint;
  var validate;
  var keyboardType;
  var maxlines;
  var maxLength;
  bool expand;
  var icon;
  var hpad;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: hpad, vertical: 5.0),
      decoration: BoxDecoration(
        border: Border(
            // right: BorderSide(color: Colors.red),
            // left: BorderSide(color: Colors.red),
            ),
        // color: Colors.red,
      ),
      // transform: Matrix4.rotationZ(0.01),
      child: TextFormField(
        expands: this.expand,
        maxLength: this.maxLength,
        maxLines: this.maxlines,
        keyboardType: this.keyboardType,
        validator: this.validate,
        obscureText: this.hideText,
        autofocus: this.autofocus,
        controller: this.controller,
        decoration: InputDecoration(
            icon: this.icon,
            hintText: this.hint,
            hintStyle: TextStyle(fontWeight: FontWeight.w600),
            focusColor: Colors.black,
            labelText: this.label),
      ),
    );
  }
}
