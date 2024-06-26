/// Post message data
///
/// This is for post messages only.
class PostMessaging {
  // It was noted that is id is supposedly the post id but due to
  // some logic it might be the comment id.
  String id;
  String category;

  PostMessaging({
    required this.id,
    required this.category,
  });

  factory PostMessaging.fromMap(Map<String, dynamic> map) {
    return PostMessaging(
      id: map['id'],
      category: map['category'],
    );
  }
}
