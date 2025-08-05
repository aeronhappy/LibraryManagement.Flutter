import 'package:flutter/material.dart';
import 'package:library_management/design/app_colors.dart';
import 'package:library_management/design/text_style.dart';
import 'package:library_management/features/Book/bloc/book/book_bloc.dart';
import 'package:library_management/features/BorrowingRecord/model/borrowing_record_model.dart';
import 'package:library_management/features/Member/model/member_model.dart';
import 'package:library_management/types/book_filter_types.dart';

Future<List<String>?> returnBookDialog(
  BuildContext context,
  MemberModel membermodel,
) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return ReturnBookDialog(membermodel: membermodel);
    },
  );
}

class ReturnBookDialog extends StatefulWidget {
  final MemberModel membermodel;
  const ReturnBookDialog({super.key, required this.membermodel});

  @override
  State<ReturnBookDialog> createState() => _ReturnBookDialogState();
}

class _ReturnBookDialogState extends State<ReturnBookDialog> {
  TextEditingController searchText = TextEditingController();
  @override
  void initState() {
    super.initState();
  }

  Future<void> searchData() async {
    await Future.delayed(const Duration(milliseconds: 500));
    GetAllBooks(
      searchText: searchText.text,
      bookFilterTypes: BookFilterTypes.available,
    );
  }

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
            Text(
              "${widget.membermodel.name} wants to return",
              style: Theme.of(context).textTheme.titleMedium,
            ),
            SizedBox(height: 10),
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  double maxWidth = constraints.maxWidth;
                  double desiredItemWidth = 180;
                  int crossAxisCount = (maxWidth / desiredItemWidth)
                      .floor()
                      .clamp(1, 7);
                  double spacing = 15.0;

                  final List<BorrowingRecordModel> currentlyBorrowed = widget
                      .membermodel
                      .borrowingHistory
                      .where((record) => record.dateReturned == null)
                      .toList();

                  return GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount,
                      mainAxisSpacing: spacing,
                      crossAxisSpacing: spacing,
                      mainAxisExtent: 220,
                    ),
                    itemCount: widget.membermodel.borrowedBooksCount,
                    itemBuilder: (context, index) {
                      var book = currentlyBorrowed[index].book!;
                      return Material(
                        elevation: 0.5,
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.brown.withAlpha(120),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(12),
                          onTap: () {
                            Navigator.pop(context, [
                              widget.membermodel.id,
                              book.id,
                            ]);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Center(
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 15,
                                        vertical: 5,
                                      ),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                          100,
                                        ),
                                        color: Colors.white,
                                      ),
                                      child: Text(
                                        book.title,
                                        style: headlineSmallLight.copyWith(
                                          fontSize: 22,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Column(
                                  children: [
                                    Text(book.author),
                                    Text(book.isbn),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            SizedBox(height: 10),
            Material(
              borderRadius: BorderRadius.circular(8),
              child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  height: 35,
                  width: double.infinity,
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
          ],
        ),
      ),
    );
  }
}
