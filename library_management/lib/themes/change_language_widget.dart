// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:localization/localization.dart';
// import 'package:seeking/features/language/blocs/languages/language_bloc.dart';
// import 'package:seeking/features/language/models/language_model.dart';

// // ignore: must_be_immutable
// class ChangeLanguageWidget extends StatefulWidget {
//   int id;
//   ChangeLanguageWidget({super.key, required this.id});

//   @override
//   State<ChangeLanguageWidget> createState() => _ChangeLanguageWidgetState();
// }

// class _ChangeLanguageWidgetState extends State<ChangeLanguageWidget> {
//   bool isExpanded = false;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//         decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(8),
//             border: Border.all(color: Theme.of(context).cardColor)),
//         child: Theme(
//           data: Theme.of(context).copyWith(
//             splashColor: Colors.transparent,
//             highlightColor: Colors.transparent,
//           ),
//           child: ExpansionTile(
//               tilePadding: EdgeInsets.symmetric(horizontal: 10),
//               minTileHeight: 45,
//               enableFeedback: false,
//               leading: Icon(Icons.translate_rounded,
//                   color: Theme.of(context).primaryColor),
//               title: Text('Language'.i18n(),
//                   style: Theme.of(context).textTheme.bodyLarge),
//               trailing: Icon(isExpanded
//                   ? Icons.arrow_drop_up_rounded
//                   : Icons.arrow_drop_down_rounded),
//               onExpansionChanged: (expanded) {
//                 setState(() {
//                   isExpanded = expanded;
//                 });
//               },
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(8),
//                 side: BorderSide.none,
//               ),
//               collapsedShape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(8),
//                   side: BorderSide.none),
//               children: [
//                 Stack(
//                   children: [
//                     Container(
//                       width: double.infinity,
//                       height: MediaQuery.of(context).size.height * .25,
//                       child: RawScrollbar(
//                         thumbVisibility: true,
//                         thickness: 5,
//                         radius: Radius.circular(20),
//                         thumbColor:
//                             Theme.of(context).iconTheme.color!.withOpacity(.5),
//                         child: ListView(
//                           children: languageList.map((language) {
//                             return InkWell(
//                               splashColor: Theme.of(context).highlightColor,
//                               highlightColor: Theme.of(context).highlightColor,
//                               onTap: () {
//                                 setState(() {
//                                   context.read<LanguageBloc>().add(
//                                       ChangeLanguage(languageModel: language));
//                                 });
//                               },
//                               child: Container(
//                                 color: language.id == widget.id
//                                     ? Theme.of(context)
//                                         .primaryColor
//                                         .withOpacity(.3)
//                                     : Colors.transparent,
//                                 width: double.infinity,
//                                 padding: EdgeInsets.symmetric(
//                                     horizontal: 20, vertical: 5),
//                                 child: Text(language.name,
//                                     style:
//                                         Theme.of(context).textTheme.bodyMedium),
//                               ),
//                             );
//                           }).toList(),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: 10)
//               ]),
//         ));
//   }
// }
