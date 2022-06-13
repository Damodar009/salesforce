import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:salesforce/utils/app_colors.dart';

Widget textFormField(
    {required String hintText,
    bool obsecureText = false,
    required TextEditingController controller,
    TextInputType textInputType = TextInputType.text,
    required String? Function(String?) validator,
    required void Function() obsecureText1,
    bool showObsecureIcon = false,
    bool enableTextField = true}) {
  return TextFormField(
    enabled: enableTextField,
    controller: controller,
    validator: (val) => validator(val),
    keyboardType: textInputType,
    style: const TextStyle(
      fontFamily: 'Inter',
      fontSize: 15,
    ),
    decoration: InputDecoration(
        suffixIcon: showObsecureIcon
            ? InkWell(
                onTap: obsecureText1,
                child: obsecureText
                    ? const Icon(
                        Icons.visibility_off,
                        size: 20,
                      )
                    : const Icon(
                        Icons.visibility,
                        size: 20,
                      ),
              )
            : const SizedBox(),
        fillColor: Colors.white,
        errorStyle: const TextStyle(color: AppColors.primaryColor),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(30.0),
          ),
          borderSide: BorderSide(color: AppColors.textFeildINputBorder),
        ),
        filled: true,
        hintStyle: const TextStyle(
          color: Colors.black,
          fontFamily: 'Inter',
          fontSize: 15,
        ),
        hintText: hintText,
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue),
            borderRadius: BorderRadius.all(
              Radius.circular(30.0),
            )),
        enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue),
            borderRadius: BorderRadius.all(
              Radius.circular(30.0),
            ))),
    obscureText: obsecureText,
  );
}

Widget textFeildWithDropDown({
  required String hintText,
  TextEditingController? controller,
  TextInputType textInputType = TextInputType.text,
  required String? Function(String?) validator,
  required List<String> item,
}) {
  return TextFormField(
    controller: controller,
    validator: (val) => validator(val),
    keyboardType: textInputType,
    style: const TextStyle(
      fontFamily: 'Inter',
      fontSize: 15,
    ),
    decoration: InputDecoration(
        suffixIcon: PopupMenuButton<String>(
          icon: Container(
            padding: EdgeInsets.all(6),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Colors.amber,
            ),
            child: const Icon(
              Icons.arrow_downward,
              size: 20,
              color: Colors.white,
            ),
          ),
          onSelected: (String value) {
            controller!.text = value;
          },
          itemBuilder: (BuildContext context) {
            return item.map<PopupMenuItem<String>>((String value) {
              return PopupMenuItem(child: Text(value), value: value);
            }).toList();
          },
        ),
        fillColor: Colors.white,
        errorStyle: const TextStyle(color: AppColors.primaryColor),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(30.0),
          ),
          borderSide: BorderSide(color: AppColors.textFeildINputBorder),
        ),
        filled: true,
        hintStyle: const TextStyle(
          color: Colors.black,
          fontFamily: 'Inter',
          fontSize: 15,
        ),
        hintText: hintText,
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue),
            borderRadius: BorderRadius.all(
              Radius.circular(30.0),
            )),
        enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue),
            borderRadius: BorderRadius.all(
              Radius.circular(30.0),
            ))),
  );
}

Widget textFeildWithMultipleLines({
  required String hintText,
  required TextEditingController controller,
  required String? Function(String?) validator,
}) {
  return TextFormField(
    controller: controller,
    keyboardType: TextInputType.multiline,
    maxLines: 6,
    style: const TextStyle(
      fontFamily: 'Inter',
      fontSize: 15,
    ),
    decoration: InputDecoration(
        fillColor: Colors.white,
        errorStyle: const TextStyle(color: AppColors.primaryColor),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(15.0),
          ),
          borderSide: BorderSide(color: AppColors.textFeildINputBorder),
        ),
        filled: true,
        hintStyle: const TextStyle(
          color: Colors.grey,
          fontFamily: 'Inter',
          fontSize: 15,
        ),
        hintText: hintText,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue),
            borderRadius: BorderRadius.all(
              Radius.circular(30.0),
            )),
        enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue),
            borderRadius: BorderRadius.all(
              Radius.circular(30.0),
            ))),
  );
}

Widget textFormFeildIncreAndDecre({
  required String initialValue,
  required String? Function(String?) validator,
  required String? Function(String?) onChanged,
  Function? incrementReturn,
  Function? decrementReturn,
}) {
  return TextFormField(
    key: Key(initialValue),
    initialValue: initialValue,
    onChanged: onChanged,
    keyboardType: TextInputType.number,
    style: const TextStyle(
      fontFamily: 'Inter',
      fontSize: 15,
    ),
    decoration: InputDecoration(
        prefix: InkWell(
          onTap: () {
            decrementReturn;
          },
          child: const Icon(
            Icons.minimize_outlined,
            color: AppColors.primaryColor,
          ),
        ),
        suffixIcon: InkWell(
          onTap: () {},
          child: InkWell(
            onTap: () {
              incrementReturn;
            },
            child: const Icon(
              Icons.add,
              color: AppColors.primaryColor,
            ),
          ),
        ),
        fillColor: Colors.white,
        errorStyle: const TextStyle(color: AppColors.primaryColor),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(30.0),
          ),
          borderSide: BorderSide(color: AppColors.textFeildINputBorder),
        ),
        filled: true,
        hintStyle: const TextStyle(
          color: Colors.grey,
          fontFamily: 'Inter',
          fontSize: 15,
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue),
            borderRadius: BorderRadius.all(
              Radius.circular(30.0),
            )),
        enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue),
            borderRadius: BorderRadius.all(
              Radius.circular(30.0),
            ))),
  );
}

Widget textFeildWithDropDownFor(
    {required String initialText,
    TextInputType textInputType = TextInputType.text,
    required String? Function(String?) validator,
    required List<String> item,
    required Function(String) onselect}) {
  return TextFormField(
    key: Key(initialText),
    initialValue: initialText,
    validator: (val) => validator(val),
    keyboardType: textInputType,
    style: const TextStyle(
      fontFamily: 'Inter',
      fontSize: 15,
    ),
    decoration: InputDecoration(
        suffixIcon: PopupMenuButton<String>(
          icon: Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Colors.amber,
            ),
            child: const Icon(
              Icons.arrow_downward,
              size: 20,
              color: Colors.white,
            ),
          ),
          onSelected: (string) {
            onselect(string);
          },
          itemBuilder: (BuildContext context) {
            return item.map<PopupMenuItem<String>>((String value) {
              return PopupMenuItem(child: Text(value), value: value);
            }).toList();
          },
        ),
        fillColor: Colors.white,
        errorStyle: const TextStyle(color: AppColors.primaryColor),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(30.0),
          ),
          borderSide: BorderSide(color: AppColors.textFeildINputBorder),
        ),
        filled: true,
        hintStyle: const TextStyle(
          color: Colors.blue,
          fontFamily: 'Inter',
          fontSize: 15,
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue),
            borderRadius: BorderRadius.all(
              Radius.circular(30.0),
            )),
        enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue),
            borderRadius: BorderRadius.all(
              Radius.circular(30.0),
            ))),
  );
}

// Widget dropDownWithSearch({required String initialText,
//     TextInputType textInputType = TextInputType.text,
//     required String? Function(String?) validator,
//     required List<String> item,}) {
//   return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 20),
//       child: DropdownSearch<String>(
//         popupProps: const PopupProps.menu(
//           showSearchBox: true,
//           showSelectedItems: true,
//         ),
//         items: ["sdfas", "fsaf", "dsfadsf"],
//         dropdownSearchDecoration: const InputDecoration(
//           hintText: "Select one",
//         ),
//         onChanged: (value) {
//           // setState(() {
//           //   int index = parentCategory!
//           //       .indexWhere((element) => element.name == value!);
//           //   dropDownValue = parentCategory![index].id;
//           //   print(dropDownValue);
//           // });
//         },
//       ));
// }

// Widget InputDecoration(){
//   return const InputDecoration(
//                                 fillColor: Colors.white,
//                                 errorStyle: const TextStyle(
//                                     color: Color.fromRGBO(2, 40, 89, 1)),
//                                 border: const OutlineInputBorder(
//                                   borderRadius: BorderRadius.all(
//                                     Radius.circular(30.0),
//                                   ),
//                                   borderSide: BorderSide(
//                                       color: AppColors.textFeildINputBorder),
//                                 ),
//                                 filled: true,
//                                 hintStyle: const TextStyle(
//                                   color: Colors.black,
//                                   fontFamily: 'Inter',
//                                   fontSize: 15,
//                                 ),
//                                 hintText: "Select",
//                                 // (widget.getProfileState.userDetail!.dob == null)
//                                 //     ? "Choose your dob"
//                                 //     : widget.getProfileState.userDetail!.dob,
//                                 contentPadding: const EdgeInsets.symmetric(
//                                     horizontal: 20, vertical: 5),
//                                 focusedBorder: const OutlineInputBorder(
//                                     borderSide: BorderSide(color: Colors.blue),
//                                     borderRadius: BorderRadius.all(
//                                       Radius.circular(30.0),
//                                     )),
//                                 enabledBorder: const OutlineInputBorder(
//                                     borderSide: BorderSide(color: Colors.blue),
//                                     borderRadius: BorderRadius.all(
//                                       Radius.circular(30.0),
//                                     )));
// }
