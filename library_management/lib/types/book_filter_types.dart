enum BookFilterTypes {
  all,
  available,
  overdue;

  String bookFilterToString() {
    return switch (this) {
      BookFilterTypes.all => "All",
      BookFilterTypes.available => "Available",
      BookFilterTypes.overdue => "Overdue",
    };
  }
}
