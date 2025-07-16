import 'package:flutter/material.dart';
import 'package:library_management/design/app_colors.dart';
import 'package:library_management/design/text_style.dart';
import 'package:library_management/model/create_member_model.dart';

Future<CreateMemberModel?> addMemberDialog(BuildContext context) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AddMemberDialog();
    },
  );
}

class AddMemberDialog extends StatefulWidget {
  const AddMemberDialog({super.key});

  @override
  State<AddMemberDialog> createState() => _AddMemberDialogState();
}

class _AddMemberDialogState extends State<AddMemberDialog> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

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
                controller: nameController,
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
                  hintText: 'Name',
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
                controller: emailController,
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
                  hintText: 'email@example.com',
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
                    color: nameController.text.isEmpty
                        ? navBarIconColor
                        : primaryColor,
                    child: InkWell(
                      onTap: nameController.text.isEmpty
                          ? null
                          : () async {
                              Navigator.pop(
                                context,
                                CreateMemberModel(
                                  name: nameController.text,
                                  email: emailController.text,
                                ),
                              );
                            },
                      borderRadius: BorderRadius.circular(8),
                      child: SizedBox(
                        height: 35,
                        child: Center(
                          child: Text(
                            "Add Member",
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
