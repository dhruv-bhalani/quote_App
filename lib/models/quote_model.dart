class QuoteModel {
  String quote;
  String author;
  String category;

  QuoteModel(this.quote, this.author, this.category);

  factory QuoteModel.fromMap({required Map data}) =>
      QuoteModel(data['quote'], data['author'], data['category']);

  Map<String, dynamic> get toMap =>
      {'quote': quote, 'author': author, 'category': category};
}
