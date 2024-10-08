import 'package:flutter/material.dart';
import 'package:marvel/helpers/constants.dart';

class CustomeTextFormFiled extends StatelessWidget {
  const CustomeTextFormFiled({super.key, required this.label, this.hint,  required this.textEditingController, required this.validate});
  final String? label ;
  final String? hint;
  final TextEditingController  textEditingController;
  final FormFieldValidator<String?> validate ;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textEditingController,
      validator: validate,
      decoration: InputDecoration(
        hintText: hint,
        label: label==null?null : Text(label!),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        focusColor: mainColor,
      ),
    );
  }
}