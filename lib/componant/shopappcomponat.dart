import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void navigateTo(context, widget) =>
    Navigator.push(context, MaterialPageRoute(builder: (context) => widget));

void navigateAndFinsh(context, widget) => Navigator.pushAndRemoveUntil(
  context,
  MaterialPageRoute(builder: (context) => widget),
  (Route<dynamic> route) => false,
);

Widget defaultFormField({
  Function(String)? onSubmit,
  Function(String)? onChange,
  required TextEditingController controler,
  required TextInputType type,
  String? Function(String?)? validator,
  bool obscuretext = false,
  required IconData prefix,
  IconData? suffixIcon,
  required String lable,
  VoidCallback? click,
  bool isClickable = true,
  VoidCallback? onSuffixTap,
}) => TextFormField(
  obscureText: obscuretext,
  controller: controler,
  keyboardType: type,
  onTap: click,
  enabled: isClickable,
  onFieldSubmitted: onSubmit,
  onChanged: onChange,
  validator: validator,
  decoration: InputDecoration(
    suffixIcon: suffixIcon != null
        ? IconButton(icon: Icon(suffixIcon), onPressed: onSuffixTap)
        : null,
    labelText: lable,
    prefixIcon: Icon(prefix),
    border: OutlineInputBorder(),
  ),
);

Widget defaultButton({
  required String label,
  required VoidCallback onPressed,
  Color? backgroundColor,
}) => SizedBox(
  width: double.infinity,
  child: ElevatedButton(
    onPressed: onPressed,
    style: ElevatedButton.styleFrom(
      backgroundColor: backgroundColor,
      padding: EdgeInsets.symmetric(vertical: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
    child: Text(
      label,
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
    ),
  ),
);

String? validateRequiredField(String? value, String label) {
  if (value == null || value.isEmpty) {
    return 'Please enter your $label';
  }
  return null;
}

void showToast({required String text, required ToastStates state}) =>
    Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: chooseToastColor(state),
      textColor: Colors.white,
      fontSize: 16.0,
    );

enum ToastStates { Success, Error, Warning }

Color chooseToastColor(ToastStates state) {
  Color color;
  switch (state) {
    case ToastStates.Success:
      color = Colors.green;
      break;
    case ToastStates.Error:
      color = Colors.red;
      break;
    case ToastStates.Warning:
      color = Colors.amber;
      break;
  }
  return color;
}
