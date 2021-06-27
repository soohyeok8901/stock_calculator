// import 'package:averge_price_calc/constant.dart';
// import 'package:averge_price_calc/widgets/ui_data_provider.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// class TitleTextField extends StatelessWidget {
//   const TitleTextField({
//     @required this.titleTextController,
//     @required this.onChangedCB,
//     @required this.onPressedCB,
//     @required this.context,
//   });

//   final TextEditingController titleTextController;
//   final Function onChangedCB;
//   final Function onPressedCB;
//   final BuildContext context;

//   @override
//   Widget build(BuildContext context) {
//     bool modifyMode = true;
//     return showTitle(modifyMode);
//   }

//   Widget showTitle(modifyMode) {
//     return modifyMode ? showText() : showTextField();
//   }

//   // bool toggleModifyMode() {
//   //   ChangeNotifier();
//   //   print(modifyMode);
//   //   return modifyMode = !modifyMode;
//   // }

//   Widget showText() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: <Widget>[
//         Padding(
//           padding: EdgeInsets.only(left: 10),
//           child: Text(
//             // titleTextController.text,
//             'asda',
//             style: TextStyle(fontSize: 23),
//           ),
//         ),
//         IconButton(
//           icon: Icon(Icons.edit),
//           onPressed: () {
//             // modifyMode =
//             //     Provider.of<HandleUiDataProvider>(context, listen: false)
//             //         .toggleModifyMode(modifyMode);
//           },
//         ),
//       ],
//     );
//   }

//   Widget showTextField() {
//     return TextField(
//       controller: titleTextController,
//       decoration: InputDecoration(
//           hintText: '타이틀',
//           suffixIcon: (titleTextController.text.length > 0)
//               ? IconButton(
//                   icon: Icon(Icons.done_outline),
//                   color: green,
//                   onPressed: onPressedCB,
//                 )
//               : null),
//       textAlignVertical: TextAlignVertical.bottom,
//       textAlign: TextAlign.center,
//       style: TextStyle(fontSize: 23),
//       maxLength: 12,
//       onChanged: onChangedCB,
//     );
//   }
// }
