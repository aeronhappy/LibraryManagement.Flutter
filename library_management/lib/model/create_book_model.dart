class CreateBookModel {
  final String title;
  final String author;
  final String isbn;

  CreateBookModel({
    required this.title,
    required this.author,
    required this.isbn,
  });

  factory CreateBookModel.fromJson(Map<String, dynamic> json) {
    return CreateBookModel(
      title: json['title'] as String,
      author: json['author'] as String,
      isbn: json['isbn'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
    'title': title,
    'author': author,
    'isbn': isbn,
  };

  static CreateBookModel fromMap(Map<String, dynamic> map) =>
      CreateBookModel.fromJson(map);
}
