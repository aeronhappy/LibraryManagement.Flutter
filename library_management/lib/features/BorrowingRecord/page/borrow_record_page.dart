import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:library_management/design/app_colors.dart';
import 'package:library_management/design/text_style.dart';
import 'package:library_management/features/BorrowingRecord/bloc/borrow/borrow_bloc.dart';
import 'package:library_management/types/borrow_records_filter_types.dart';
import 'package:library_management/widgets/converter.dart';

class BorrowRecordPage extends StatefulWidget {
  const BorrowRecordPage({super.key});

  @override
  State<BorrowRecordPage> createState() => _BorrowRecordPageState();
}

class _BorrowRecordPageState extends State<BorrowRecordPage> {
  TextEditingController searchTextController = TextEditingController();
  BorrowRecordsFilterTypes selectedStatus = BorrowRecordsFilterTypes.all;

  @override
  void initState() {
    super.initState();
    refreshData();
  }

  refreshData() {
    context.read<BorrowBloc>().add(
      GetAllBorrowingRecords(
        searchText: searchTextController.text,
        dateTime: null,
        borrowRecordsFilterTypes: selectedStatus,
      ),
    );
  }

  void filteringBorrowRecords(BorrowRecordsFilterTypes status) {
    setState(() {
      selectedStatus = status;
    });
    refreshData();
  }

  Future<void> searchData() async {
    await Future.delayed(const Duration(milliseconds: 500));
    refreshData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsetsGeometry.symmetric(horizontal: 15, vertical: 10),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      "Borrow History",
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    Spacer(),
                    PopupMenuButton<BorrowRecordsFilterTypes>(
                      borderRadius: BorderRadius.circular(45),
                      tooltip: 'Filter Orders',
                      onSelected: filteringBorrowRecords,
                      child: Material(
                        borderRadius: BorderRadius.circular(45),
                        color: navBarIconColor.withAlpha(100),
                        child: Container(
                          height: 40,
                          padding: EdgeInsets.only(left: 15, right: 5),
                          child: Row(
                            children: [
                              Text(
                                selectedStatus.bookFilterToString(),
                                style: bodyLargeLight,
                              ),
                              Icon(Icons.arrow_drop_down),
                            ],
                          ),
                        ),
                      ),
                      itemBuilder: (context) =>
                          BorrowRecordsFilterTypes.values.map((status) {
                            return PopupMenuItem<BorrowRecordsFilterTypes>(
                              height: 35,
                              value: status,
                              child: Text(
                                status.bookFilterToString(),
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                            );
                          }).toList(),
                    ),
                    SizedBox(width: 8),
                    Flexible(
                      child: Container(
                        height: 45,
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        decoration: BoxDecoration(
                          color: navBarIconColor.withAlpha(50),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        alignment: Alignment.center,
                        child: TextField(
                          controller: searchTextController,
                          style: bodyMediumLight,
                          textAlignVertical: TextAlignVertical.top,
                          onChanged: (value) => searchData(),
                          decoration: InputDecoration(
                            hintText: 'Search book or user . . .',
                            hintStyle: bodyMediumLight.copyWith(
                              decoration: TextDecoration.none,
                              color: navBarIconColor,
                              height: 2,
                            ),
                            border: InputBorder.none,
                            prefixIcon: Icon(
                              Icons.search,
                              color: navBarIconColor,
                            ),
                            suffixIcon: searchTextController.text.isEmpty
                                ? null
                                : IconButton(
                                    icon: const Icon(Icons.close, size: 20),
                                    onPressed: () {
                                      setState(() {
                                        searchTextController.clear();
                                        refreshData();
                                      });
                                    },
                                  ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Container(
                  height: 45,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: navBarIconColor.withAlpha(40),
                  ),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 50,
                        child: Center(
                          child: Text(
                            "No.",
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                        ),
                      ),
                      SizedBox(width: 20),
                      Expanded(
                        child: Center(
                          child: Text(
                            "Borrower",
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Center(
                          child: Text(
                            "Book",
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Center(
                          child: Text(
                            "Borrow Date",
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Center(
                          child: Text(
                            "Due / Status",
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Center(
                          child: Text(
                            "Return Date",
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                Expanded(
                  child: BlocBuilder<BorrowBloc, BorrowState>(
                    builder: (context, state) {
                      if (state is LoadedBorrowRecord) {
                        return ListView.separated(
                          separatorBuilder: (context, index) => Divider(
                            thickness: .5,
                            height: 5,
                            color: navBarIconColor.withAlpha(100),
                          ),
                          itemCount: state.borrowingRecords.length,
                          itemBuilder: (context, index) {
                            var borrowRecord = state.borrowingRecords[index];
                            return SizedBox(
                              height: 50,
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 50,
                                    child: Center(
                                      child: Text(
                                        "${index + 1}",
                                        style: Theme.of(
                                          context,
                                        ).textTheme.bodyMedium,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 20),
                                  Expanded(
                                    child: Center(
                                      child: Text(
                                        borrowRecord.borrower!.name,
                                        style: Theme.of(
                                          context,
                                        ).textTheme.bodyMedium,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Center(
                                      child: Text(
                                        borrowRecord.book!.title,
                                        style: Theme.of(
                                          context,
                                        ).textTheme.bodyMedium,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Center(
                                      child: Text(
                                        convertDateTimePH(
                                          borrowRecord.dateBorrowed.toString(),
                                        ),
                                        style: Theme.of(
                                          context,
                                        ).textTheme.bodyMedium,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Center(
                                      child: Text(
                                        getDueInLabel(
                                          borrowRecord.dateOverdue,
                                          borrowRecord.dateReturned,
                                        ),
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium!
                                            .copyWith(
                                              color: getReturnStatusColor(
                                                borrowRecord.dateOverdue,
                                                borrowRecord.dateReturned,
                                                context,
                                              ),
                                            ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Center(
                                      child: Text(
                                        borrowRecord.dateReturned != null
                                            ? convertDateTimePH(
                                                borrowRecord.dateReturned
                                                    .toString(),
                                              )
                                            : "———",
                                        style: Theme.of(
                                          context,
                                        ).textTheme.bodyMedium,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              // Row(
                              //   mainAxisSize: MainAxisSize.max,
                              //   mainAxisAlignment:
                              //       MainAxisAlignment.spaceBetween,
                              //   children: [
                              //     Text(borrowRecord.borrower!.name),
                              //     Text(borrowRecord.book!.title),
                              //     Text(
                              //       convertDateTimePH(
                              //         borrowRecord.dateBorrowed.toString(),
                              //       ),
                              //     ),
                              //     Text(
                              //       convertDurationToDueString(
                              //         borrowRecord.dateOverdue,
                              //       ),
                              //     ),

                              //     Text(
                              //       borrowRecord.dateReturned != null
                              //           ? convertDateTimePH(
                              //               borrowRecord.dateBorrowed
                              //                   .toString(),
                              //             )
                              //           : "Unreturn",
                              //     ),
                              //   ],
                              // ),
                            );
                          },
                        );
                      }
                      return Center(child: Text("wala nga ni"));
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
