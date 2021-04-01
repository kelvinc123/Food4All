import 'package:flutter/material.dart';
import 'package:food4all_app/pallete.dart';

import '../../pallete.dart';

class TextInputField extends StatelessWidget {
  const TextInputField(
      {Key key,
      @required this.icon,
      @required this.label,
      this.hint,
      this.isPassword = false,
      this.isEmail = false,
      this.inputType,
      this.inputAction,
      this.onChanged,
      this.validator,
      this.controller})
      : super(key: key);

  final IconData icon;
  final String hint;
  final String label;
  final bool isPassword;
  final bool isEmail;
  final TextInputType inputType;
  final TextInputAction inputAction;
  final Function onChanged;
  final Function validator;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Container(
          width: size.width * 0.8,
          height: 100,
          child: TextFormField(
            decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.greenAccent[700], width: 3.0),
                    borderRadius: BorderRadius.circular(10.0)),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey[600], width: 3.0),
                    borderRadius: BorderRadius.circular(10.0)),
                errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red[800], width: 3.0),
                    borderRadius: BorderRadius.circular(10.0)),
                focusedErrorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red[800], width: 3.0),
                    borderRadius: BorderRadius.circular(10.0)),
                prefixIcon: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Icon(
                    icon,
                    size: 20,
                    color: kWhite,
                  ),
                ),
                filled: true,
                fillColor: Colors.grey.withOpacity(0.24),
                labelText: label,
                labelStyle: kBodyText,
                floatingLabelBehavior: FloatingLabelBehavior.never,
                hintStyle: kHintText,
                // helperText: " ",
                errorStyle: kHintText),
            onChanged: onChanged,
            validator: validator,
            controller: controller,
            obscureText: isPassword ? true : false,
            keyboardType: isEmail ? TextInputType.emailAddress : inputType,
            style: kBodyText,
            textInputAction: inputAction,
          ),
        ));
  }
}
