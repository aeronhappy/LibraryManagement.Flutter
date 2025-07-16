import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:library_management/bloc/book/book_bloc.dart';
import 'package:library_management/bloc/book_controller/book_controller_bloc.dart';
import 'package:library_management/design/app_colors.dart';
import 'package:library_management/design/text_style.dart';
import 'package:library_management/model/create_book_model.dart';
import 'package:library_management/types/book_filter_types.dart';
import 'package:library_management/widgets/add_book_dialog.dart';

class BookPage extends StatefulWidget {
  const BookPage({super.key});

  @override
  State<BookPage> createState() => _BookPageState();
}

class _BookPageState extends State<BookPage> {
  BookFilterTypes selectedStatus = BookFilterTypes.all;
  TextEditingController searchTextController = TextEditingController();
  @override
  void initState() {
    super.initState();
    refreshData();
  }

  refreshData() {
    context.read<BookBloc>().add(
      GetAllBooks(
        searchText: searchTextController.text,
        bookFilterTypes: selectedStatus,
      ),
    );
  }

  void filteringBooks(BookFilterTypes status) {
    setState(() {
      selectedStatus = status;
    });
    refreshData();
  }

  Future<void> searchData() async {
    await Future.delayed(const Duration(milliseconds: 500));
    refreshData();
  }

  void addbooks(CreateBookModel createBookModel) {
    context.read<BookControllerBloc>().add(
      AddBook(
        title: createBookModel.title,
        author: createBookModel.author,
        isbn: createBookModel.isbn,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<BookControllerBloc, BookControllerState>(
      listener: (context, state) {
        if (state is BookCreated) {
          filteringBooks(selectedStatus);
        }
        if (state is BookDeleted) {
          filteringBooks(selectedStatus);
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            Padding(
              padding: EdgeInsetsGeometry.symmetric(
                horizontal: 15,
                vertical: 10,
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Spacer(),
                      Material(
                        color: primaryColor,
                        borderRadius: BorderRadius.circular(45),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(45),
                          onTap: () async {
                            var createBookModel = await addBookDialog(context);

                            if (!mounted) return;

                            if (createBookModel != null) {
                              addbooks(createBookModel);
                            }
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            height: 40,
                            child: Center(
                              child: Text("Add Book", style: bodyMediumDark),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      PopupMenuButton<BookFilterTypes>(
                        borderRadius: BorderRadius.circular(45),
                        tooltip: 'Filter Orders',
                        onSelected: filteringBooks,
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
                            BookFilterTypes.values.map((status) {
                              return PopupMenuItem<BookFilterTypes>(
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
                    child: BlocBuilder<BookBloc, BookState>(
                      builder: (context, state) {
                        if (state is LoadedBook) {
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
                                itemCount: state.books.length,
                                itemBuilder: (context, index) {
                                  var book = state.books[index];
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
                                                    padding:
                                                        EdgeInsets.symmetric(
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
                                                      book.title,
                                                      style: headlineSmallLight
                                                          .copyWith(
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
                                      Positioned(
                                        right: 10,
                                        top: 10,
                                        child: Material(
                                          borderRadius: BorderRadius.circular(
                                            100,
                                          ),
                                          child: InkWell(
                                            borderRadius: BorderRadius.circular(
                                              100,
                                            ),
                                            onTap: () {
                                              context
                                                  .read<BookControllerBloc>()
                                                  .add(
                                                    DeleteBook(bookId: book.id),
                                                  );
                                            },
                                            child: SizedBox(
                                              height: 25,
                                              width: 25,
                                              child: Center(
                                                child: Icon(
                                                  Icons.delete,
                                                  size: 17,
                                                ),
                                              ),
                                            ),
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
      ),
    );
  }
}
