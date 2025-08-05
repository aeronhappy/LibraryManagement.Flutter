import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:library_management/design/app_colors.dart';
import 'package:library_management/design/text_style.dart';
import 'package:library_management/features/BorrowingRecord/bloc/borrow/borrow_bloc.dart';

class BorrowRecordPage extends StatefulWidget {
  const BorrowRecordPage({super.key});

  @override
  State<BorrowRecordPage> createState() => _BorrowRecordPageState();
}

class _BorrowRecordPageState extends State<BorrowRecordPage> {
  TextEditingController searchTextController = TextEditingController();
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
      ),
    );
  }

  Future<void> searchData() async {
    await Future.delayed(const Duration(milliseconds: 500));
    refreshData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsetsGeometry.symmetric(horizontal: 15, vertical: 10),
            child: Column(
              children: [
                Row(
                  children: [
                    Spacer(),
                    Flexible(
                      child: Container(
                        height: 45,
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,
                          borderRadius: BorderRadius.circular(50),
                        ),
                        alignment: Alignment.center,
                        child: TextField(
                          controller: searchTextController,
                          style: bodyMediumLight,
                          textAlignVertical: TextAlignVertical.top,
                          onChanged: (value) => searchData(),
                          decoration: InputDecoration(
                            hintText: 'Search book title or author . . .',
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
                SizedBox(height: 10),
                Expanded(
                  child: BlocBuilder<BorrowBloc, BorrowState>(
                    builder: (context, state) {
                      if (state is LoadedBorrowRecord) {
                        return LayoutBuilder(
                          builder: (context, constraints) {
                            double maxWidth = constraints.maxWidth;
                            double desiredItemWidth = 200;
                            int crossAxisCount = (maxWidth / desiredItemWidth)
                                .floor()
                                .clamp(1, 7);
                            double spacing = 15.0;

                            return GridView.builder(
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: crossAxisCount,
                                    mainAxisSpacing: spacing,
                                    crossAxisSpacing: spacing,
                                    mainAxisExtent: 250,
                                  ),
                              itemCount: state.borrowingRecord.length,
                              itemBuilder: (context, index) {
                                var borrowRecord = state.borrowingRecord[index];
                                return Stack(
                                  children: [
                                    Material(
                                      elevation: 0.5,
                                      borderRadius: BorderRadius.circular(12),
                                      color: Colors.brown.withAlpha(120),
                                      child: Padding(
                                        padding: const EdgeInsets.all(20),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Expanded(
                                              child: Center(
                                                child: Container(
                                                  padding: EdgeInsets.symmetric(
                                                    horizontal: 15,
                                                    vertical: 5,
                                                  ),
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          100,
                                                        ),
                                                    color: Colors.white,
                                                  ),
                                                  child: Text(
                                                    borrowRecord.book!.title,
                                                    style: headlineSmallLight
                                                        .copyWith(fontSize: 22),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Column(
                                              children: [
                                                Text(borrowRecord.book!.author),
                                                Text(borrowRecord.book!.isbn),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              },
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
