class BookModel {
  final String id;
  final String title;
  final String author;
  final String isbn;
  final bool isBorrowed;
  final String? borrowerId;
  final DateTime? dateBorrow;
  final DateTime? dueDate;

  BookModel({
    required this.id,
    required this.title,
    required this.author,
    required this.isbn,
    required this.isBorrowed,
    this.borrowerId,
    this.dateBorrow,
    this.dueDate,
  });

  factory BookModel.fromJson(Map<String, dynamic> json) {
    return BookModel(
      id: json['id'] as String,
      title: json['title'] as String,
      author: json['author'] as String,
      isbn: json['isbn'] as String,
      isBorrowed: json['isBorrowed'] as bool,
      borrowerId: json['borrowerId'] as String?,
      dateBorrow: json['dateBorrow'] != null
          ? DateTime.parse(json['dateBorrow'] as String)
          : null,
      dueDate: json['dueDate'] != null
          ? DateTime.parse(json['dueDate'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'author': author,
    'isbn': isbn,
    'isBorrowed': isBorrowed,
    'borrowerId': borrowerId,
    'dateBorrow': dateBorrow?.toIso8601String(),
    'dueDate': dueDate?.toIso8601String(),
  };

  static BookModel fromMap(Map<String, dynamic> map) => BookModel.fromJson(map);
}
