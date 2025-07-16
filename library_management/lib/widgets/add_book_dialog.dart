import 'package:flutter/material.dart';
import 'package:library_management/design/app_colors.dart';
import 'package:library_management/design/text_style.dart';
import 'package:library_management/model/create_book_model.dart';

Future<CreateBookModel?> addBookDialog(BuildContext context) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AddBookDialog();
    },
  );
}

class AddBookDialog extends StatefulWidget {
  const AddBookDialog({super.key});

  @override
  State<AddBookDialog> createState() => _AddBookDialogState();
}

class _AddBookDialogState extends State<AddBookDialog> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController authorController = TextEditingController();
  final TextEditingController isbnController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: Container(
        width: 400,
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Add Book", style: Theme.of(context).textTheme.titleMedium),
            SizedBox(height: 10),
            Container(
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(width: 1.5, color: navBarIconColor),
              ),
              child: TextField(
                controller: titleController,
                minLines: 2,
                maxLines: 3,
                autofocus: true,
                onChanged: (value) {
                  setState(() {});
                },
                textDirection: TextDirection.ltr,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  isDense: true,
                  contentPadding: EdgeInsets.all(8),
                  hintText: 'title',
                  hintStyle: Theme.of(
                    context,
                  ).textTheme.bodyMedium!.copyWith(color: navBarIconColor),
                ),
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium!.copyWith(height: 1.5),
              ),
            ),
            SizedBox(height: 5),
            Container(
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(width: 1.5, color: navBarIconColor),
              ),
              child: TextField(
                controller: authorController,
                minLines: 2,
                maxLines: 3,
                autofocus: true,
                onChanged: (value) {
                  setState(() {});
                },
                textDirection: TextDirection.ltr,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  isDense: true,
                  contentPadding: EdgeInsets.all(8),
                  hintText: 'author',
                  hintStyle: Theme.of(
                    context,
                  ).textTheme.bodyMedium!.copyWith(color: navBarIconColor),
                ),
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium!.copyWith(height: 1.5),
              ),
            ),
            SizedBox(height: 5),
            Container(
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(width: 1.5, color: navBarIconColor),
              ),
              child: TextField(
                controller: isbnController,
                minLines: 2,
                maxLines: 3,
                autofocus: true,
                onChanged: (value) {
                  setState(() {});
                },
                textDirection: TextDirection.ltr,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  isDense: true,
                  contentPadding: EdgeInsets.all(8),
                  hintText: 'ISBN',
                  hintStyle: Theme.of(
                    context,
                  ).textTheme.bodyMedium!.copyWith(color: navBarIconColor),
                ),
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium!.copyWith(height: 1.5),
              ),
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: Material(
                    borderRadius: BorderRadius.circular(8),
                    color: titleController.text.isEmpty
                        ? navBarIconColor
                        : primaryColor,
                    child: InkWell(
                      onTap: titleController.text.isEmpty
                          ? null
                          : () async {
                              Navigator.pop(
                                context,
                                CreateBookModel(
                                  title: titleController.text,
                                  author: authorController.text,
                                  isbn: isbnController.text,
                                ),
                              );
                            },
                      borderRadius: BorderRadius.circular(8),
                      child: SizedBox(
                        height: 35,
                        child: Center(
                          child: Text(
                            "Add Book",
                            style: titleSmallDark.copyWith(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Material(
                    borderRadius: BorderRadius.circular(8),
                    child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      borderRadius: BorderRadius.circular(8),
                      child: Container(
                        height: 35,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(width: 1.5, color: primaryColor),
                        ),
                        child: Center(
                          child: Text(
                            "Cancel",
                            style: titleSmallDark.copyWith(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: primaryColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
