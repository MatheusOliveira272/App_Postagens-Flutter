class Post {
  final int? userId;
  final int? id;
  final String? title;
  final String? body;
  const Post({this.userId, this.id, this.title, this.body});
  Post copyWith({int? userId, int? id, String? title, String? body}) {
    return Post(
        userId: userId ?? this.userId,
        id: id ?? this.id,
        title: title ?? this.title,
        body: body ?? this.body);
  }

  Map<String, Object?> toJson() {
    return {'userId': userId, 'id': id, 'title': title, 'body': body};
  }

  static Post fromJson(Map<String, Object?> json) {
    return Post(
        userId: json['userId'] == null ? null : json['userId'] as int,
        id: json['id'] == null ? null : json['id'] as int,
        title: json['title'] == null ? null : json['title'] as String,
        body: json['body'] == null ? null : json['body'] as String);
  }

  @override
  String toString() {
    return '''Post(
            userId:$userId,
            id:$id,
            title:$title,
            body:$body
    ) ''';
  }

  @override
  bool operator ==(Object other) {
    return other is Post &&
        other.runtimeType == runtimeType &&
        other.userId == userId &&
        other.id == id &&
        other.title == title &&
        other.body == body;
  }

  @override
  int get hashCode {
    return Object.hash(runtimeType, userId, id, title, body);
  }
}
