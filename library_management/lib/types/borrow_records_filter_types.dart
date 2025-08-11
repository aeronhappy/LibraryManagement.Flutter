enum BorrowRecordsFilterTypes {
  all,
  unreturned,
  returned;

  String bookFilterToString() {
    return switch (this) {
      BorrowRecordsFilterTypes.all => "All",
      BorrowRecordsFilterTypes.unreturned => "Unreturned",
      BorrowRecordsFilterTypes.returned => "Returned",
    };
  }
}
