import 'package:bloc/bloc.dart';
import 'package:library_management/features/Book/datasource/book_remote_datesource.dart';
import 'package:library_management/features/BorrowingRecord/datasource/borrowing_remote_datesource.dart';

part 'book_controller_event.dart';
part 'book_controller_state.dart';

class BookControllerBloc
    extends Bloc<BookControllerEvent, BookControllerState> {
  final IBookRemoteDatasource bookRemoteDatasource;
  final IBorrowingRemoteDatasource borrowingRemoteDatasource;
  BookControllerBloc({
    required this.bookRemoteDatasource,
    required this.borrowingRemoteDatasource,
  }) : super(BookControllerInitial()) {
    on<AddBook>((event, emit) async {
      await bookRemoteDatasource.addBook(event.title, event.author, event.isbn);
      emit(BookCreated());
    });

    on<DeleteBook>((event, emit) async {
      await bookRemoteDatasource.deleteBook(event.bookId);
      emit(BookDeleted());
    });

    on<BorrowBook>((event, emit) async {
      await borrowingRemoteDatasource.borrowBook(event.memberId, event.bookId);
      emit(BorrowedBook());
    });

    on<ReturnBook>((event, emit) async {
      await borrowingRemoteDatasource.returnBook(event.memberId, event.bookId);
      emit(ReturnedBook());
    });
  }
}
