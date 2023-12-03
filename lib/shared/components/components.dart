import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ye_airways/shared/styles/colors.dart';

void showToastMsg({required String txt, required ToastTypes type}) {
  Fluttertoast.showToast(
      msg: txt,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: ChangeColor(type),
      textColor: Colors.white,
      fontSize: 16.0);
}

Color ChangeColor(ToastTypes type) {
  if (type == ToastTypes.SUCSSEFUL) {
    return Colors.green;
  } else if (type == ToastTypes.ERROR)
    return Colors.red;
  else if (type == ToastTypes.WARNING) return Colors.orange;

  return Colors.grey;
}

enum ToastTypes {
  SUCSSEFUL,
  ERROR,
  WARNING,
}

Widget defaultFormField({
  @required TextEditingController? controller,
  @required TextInputType? type,
  ValueChanged<String>? onSubmit,
  ValueChanged<String>? onChange,
  Function()? onTap,
  bool isPassword = false,
  FormFieldValidator<String>? validate,
  @required String? label,
  @required IconData? prefix,
  IconData? suffix,
  Function()? suffixPressed,
  bool isClickable = true,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      obscureText: isPassword,
      enabled: isClickable,
      onFieldSubmitted: onSubmit,
      onChanged: onChange,
      onTap: onTap,
      validator: validate,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(
          prefix,
        ),
        suffixIcon: suffix != null
            ? IconButton(
                onPressed: suffixPressed,
                icon: Icon(
                  suffix,
                ),
              )
            : null,
        border: const OutlineInputBorder(),
      ),
    );

Widget defaultButtn({
  @required String? title,
  double width = double.infinity,
  EdgeInsets margin = EdgeInsets.zero,
  @required Function()? onPressed,
}) =>
    Container(
      margin: margin,
      width: width,
      height: 55,
      child: TextButton(
          style: TextButton.styleFrom(
              backgroundColor: kRedColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(17))),
          onPressed: onPressed,
          child: Text(
            "$title",
            style: whiteTextStyle.copyWith(fontSize: 20, fontWeight: medium),
          )),
    );

Widget myDivider() => Padding(
      padding: const EdgeInsetsDirectional.only(
        start: 20.0,
      ),
      child: Container(
        width: double.infinity,
        height: 1.0,
        color: Colors.grey[300],
      ),
    );

showSnackBar(BuildContext context, String text) {
  return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    duration: const Duration(days: 1),
    content: Text(text),
    action: SnackBarAction(label: "close", onPressed: () {}),
  ));
}

class InactiveInfoCustomText extends StatelessWidget {
  const InactiveInfoCustomText({super.key, @required required this.text});

  final String? text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text!,
      style: TextStyle(
        color: kBlackColor,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}

class ActiveInfoCustomText extends StatelessWidget {
  const ActiveInfoCustomText({super.key, @required required this.text});

  final String? text;
  // final Color? color;

  @override
  Widget build(BuildContext context) {
    return Text(
      textAlign: TextAlign.center,
      text!,
      style: const TextStyle(
        fontSize: 15,
        color: kPrimaryColor,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

class AcronymCustomText extends StatelessWidget {
  const AcronymCustomText({super.key, @required required this.text});

  final String? text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text!,
      style: TextStyle(
        color: kPrimaryColor,
        fontSize: 30.0,
        fontWeight: medium,
      ),
    );
  }
}
