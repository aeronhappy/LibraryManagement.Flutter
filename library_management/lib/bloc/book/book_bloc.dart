import 'package:bloc/bloc.dart';
import 'package:library_management/model/book_model.dart';
import 'package:library_management/datasource/book_remote_datesource.dart';
import 'package:library_management/types/book_filter_types.dart';

part 'book_event.dart';
part 'book_state.dart';

class BookBloc extends Bloc<BookEvent, BookState> {
  final IBookRemoteDatasource bookRemoteDatasource;
  BookBloc({required this.bookRemoteDatasource}) : super(BookInitial()) {
    on<GetAllBooks>((event, emit) async {
      List<BookModel> books = [];
      if (event.bookFilterTypes == BookFilterTypes.all) {
        books = await bookRemoteDatasource.getBooks(event.searchText);
      }
      if (event.bookFilterTypes == BookFilterTypes.available) {
        books = await bookRemoteDatasource.getAvailableBooks(event.searchText);
      }
      if (event.bookFilterTypes == BookFilterTypes.overdue) {
        books = await bookRemoteDatasource.getOverdueBooks(event.searchText);
      }
      emit(LoadedBook(books: books));
    });
  }
}
