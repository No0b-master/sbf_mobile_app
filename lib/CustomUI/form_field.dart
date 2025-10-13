import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_image_picker/form_builder_image_picker.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

Widget formField({
  TextInputType? type,
  required String label,
  required String name,
  String? initialValue,
  bool? enabled,
}) {
  return Padding(
    padding: const EdgeInsets.only(top: 10.0, right: 10, left: 10),
    child: FormBuilderTextField(
        keyboardType: type,
        initialValue: initialValue == "null" ? "" : initialValue,
        name: name,
        enabled: enabled == false ? false : true,
        decoration: InputDecoration(
            labelText: label,
            errorStyle:
                const TextStyle(color: Colors.red, fontWeight: FontWeight.w600),
            border: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.green, width: 2))),
        validator: (val) {
          if (val == null || val.toString() == "null" || val.isEmpty) {
            return '$label cannot be empty';
          }
        }),
  );
}

Widget fileUploadField(
    {required String name,
    required String label,
      bool? required  ,
    required BuildContext context}) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        const SizedBox(height: 10),
        FormBuilderImagePicker(
          name: name,

          showDecoration: false,

          icon: Icons.add_a_photo,
          maxImages: 1,
          validator: required==true ? (val){

            if(val==null){
              return 'kcansjcans';
            }
            else{
              return null ;
            }
          } : null,

          previewAutoSizeWidth: false,
          fit: BoxFit.cover,
          previewWidth: MediaQuery.of(context).size.width / 2.2,
        ),
      ],
    ),
  );
}

Widget checkBoxField(
    {TextInputType? type,
    required String label,
    required String name,
    required GlobalKey<FormBuilderState> key,
    required List<String> options,
    String? initialValue}) {
  return Padding(
    padding: const EdgeInsets.only(top: 10.0, right: 10, left: 10),
    child: FormBuilderCheckboxGroup(
        initialValue: [initialValue?.substring(1, initialValue.length - 1)],
        name: name,
        valueTransformer: (value) {
          return value.toString();
        },
        decoration: InputDecoration(
            floatingLabelAlignment: FloatingLabelAlignment.start,
            floatingLabelBehavior: FloatingLabelBehavior.auto,
            label: Text(
              label,
              style: const TextStyle(
                  fontSize: 17, height: 1.1, fontStyle: FontStyle.italic),
            ),
            errorStyle:
                const TextStyle(color: Colors.red, fontWeight: FontWeight.w600),
            border: InputBorder.none),
        // validator: (val) {
        //   print(val);
        //   if (val==null || val.isEmpty) {
        //     return '$label cannot be empty';
        //   }
        // }
        onChanged: (values) {
          if (values != null && values.length > 1) {
            values.removeAt(0);
            key.currentState!.fields['single_selection']?.didChange(values);
          }
        },
        validator: (values) {
          if (values == null ||
              values.isEmpty ||
              values.toString() == "[null]") {
            return 'Please select one option';
          }
          return null;
        },
        options: options
            .map(
              (data) => FormBuilderFieldOption(
                value: data,
                child: Text(data),
              ),
            )
            .toList(growable: false)),
  );
}

Widget checkBoxMultipleField({
  TextInputType? type,
  required String label,
  required String name,
  required List<String> options,
  String? initialValue,
}) {
  return Padding(
    padding: const EdgeInsets.only(top: 10.0, right: 10, left: 10),
    child: FormBuilderCheckboxGroup(
        initialValue: initialValue == null
            ? []
            : initialValue.substring(1, initialValue.length - 1).split(', '),
        name: name,
        valueTransformer: (value) {
          return value.toString();
        },
        decoration: InputDecoration(
            floatingLabelAlignment: FloatingLabelAlignment.start,
            floatingLabelBehavior: FloatingLabelBehavior.auto,
            label: Text(
              label,
              style: const TextStyle(
                  fontSize: 19, height: 1.5, fontStyle: FontStyle.italic),
            ),
            errorStyle:
                const TextStyle(color: Colors.red, fontWeight: FontWeight.w600),
            border: InputBorder.none),
        // validator: (val) {
        //   print(val);
        //   if (val==null || val.isEmpty) {
        //     return '$label cannot be empty';
        //   }
        // }
        validator: (values) {
          if (values == null || values.isEmpty) {
            return 'Please select one option';
          }
          return null;
        },
        options: options
            .map(
              (data) => FormBuilderFieldOption(
                value: data,
                child: Text(data),
              ),
            )
            .toList(growable: false)),
  );
}

Widget dateField(
    {required String label, required String name, DateTime? initialValue}) {
  return Padding(
    padding: const EdgeInsets.only(top: 10.0, right: 10, left: 10),
    child: FormBuilderDateTimePicker(
        name: name,
        initialValue: initialValue == "null" ? null : initialValue,
        inputType: InputType.date,
        valueTransformer: (value) {
          return "${value?.day}/${value?.month}/${value!.year}";
        },
        decoration: InputDecoration(
            labelText: label,
            errorStyle:
                const TextStyle(color: Colors.red, fontWeight: FontWeight.w600),
            border: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.green, width: 2))),
        validator: (val) {
          if (val == null) {
            return '$label cannot be empty';
          }
        }),
  );
}

Widget dropDownField(
    {TextInputType? type,
    required String label,
    required String name,
    required List<String> items,
    bool? required,
    String? initialValue}) {
  return Padding(
    padding: const EdgeInsets.only(top: 10.0, right: 10, left: 10),
    child: FormBuilderDropdown(
      initialValue: initialValue,
      isExpanded: true,
      name: name,

      decoration: InputDecoration(
          labelText: label,
          errorStyle:
              const TextStyle(color: Colors.red, fontWeight: FontWeight.w600),
          border: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.green, width: 2))),
      validator: (required==null  || required==true)  ? (val) {
        if (val == null) {
          return '$label cannot be empty';
        }
      } : null,
      items: items
          .map((item) => DropdownMenuItem(
                alignment: AlignmentDirectional.centerStart,
                value: item,
                child: Text(
                  item,
                  textAlign: TextAlign.start,
                ),
              ))
          .toList(),
    ),
  );
}
