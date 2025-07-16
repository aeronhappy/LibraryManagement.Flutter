import 'package:bloc/bloc.dart';
import 'package:library_management/datasource/book_remote_datesource.dart';

part 'book_controller_event.dart';
part 'book_controller_state.dart';

class BookControllerBloc
    extends Bloc<BookControllerEvent, BookControllerState> {
  final IBookRemoteDatasource bookRemoteDatasource;
  BookControllerBloc({required this.bookRemoteDatasource})
    : super(BookControllerInitial()) {
    on<AddBook>((event, emit) async {
      await bookRemoteDatasource.addBook(event.title, event.author, event.isbn);
      emit(BookCreated());
    });

    on<DeleteBook>((event, emit) async {
      await bookRemoteDatasource.deleteBook(event.bookId);
      emit(BookDeleted());
    });

    on<BorrowBook>((event, emit) async {
      await bookRemoteDatasource.borrowBook(event.memberId, event.bookId);
      emit(BorrowedBook());
    });

    on<ReturnBook>((event, emit) async {
      await bookRemoteDatasource.returnBook(event.memberId, event.bookId);
      emit(ReturnedBook());
    });
  }
}
