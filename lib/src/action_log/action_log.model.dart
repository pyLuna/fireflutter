import 'package:firebase_database/firebase_database.dart';
import 'package:fireflutter/fireflutter.dart';

/// ActionLog
///
/// 액션 모델은, 사용자의 활동을 기록하는 모델이다.
/// Fireship 의 적절한 위치에서 이 모델의 [userProfileView], [chatJoin], [postCreate], [commentCreate] 등의 함수를
/// 호출하여 사용자의 활동을 기록하면 된다.
class ActionLog {
  /// Paths and Refs
  static const String path = 'action-logs';
  static String get userProfileViewPath => '$path/user-profile-view/$myUid';
  static String get chatJoinPath => '$path/chat-join/$myUid';
  static String get postCreatePath => '$path/post-create/$myUid';
  static String get commentCreatePath => '$path/comment-create/$myUid';
  static categoryCreateRef(String category) =>
      root.child(postCreatePath).child(category);

  ///
  static DatabaseReference get root => FirebaseDatabase.instance.ref();
  static DatabaseReference get ref => root.child(path);
  static DatabaseReference get userProfileViewRef =>
      root.child(userProfileViewPath);
  static DatabaseReference get chatJoinRef => root.child(chatJoinPath);
  static DatabaseReference get postCreateRef => root.child(postCreatePath);
  static DatabaseReference get commentCreateRef =>
      root.child(commentCreatePath);

  /// Member Variables
  final String key;

  /// [category] 는 게시판의 경우만 필요하다. key 가 게시판의 id 이다.
  final String? category;

  /// [postId] 는 코멘트의 경우만 필요하다. key 가 코멘트의 id 이다.
  final String? postId;

  ///
  final int createdAt;

  const ActionLog({
    required this.key,
    this.category,
    this.postId,
    required this.createdAt,
  });

  factory ActionLog.fromJson(Map<Object?, Object?> json, String key) {
    return ActionLog(
      key: key,
      category: json['category'] as String?,
      postId: json['postId'] as String?,
      createdAt: json['createdAt'] as int,
    );
  }

  factory ActionLog.fromSnapshot(DataSnapshot snapshot) {
    return ActionLog.fromJson(snapshot.value as Map, snapshot.key!);
  }

  /// Check if the user profile view exists
  ///
  /// 만약, [otherUserUid] 의 프로필을 본 적이 있다면, true 를 반환한다.
  /// 이 함수는 action log 에서, overtime 이 발생 할 때, 이전에 본 적인 프로필이면 그대로 볼 수 있게 위해서 사용한다.
  static Future<bool> userProfileViewExists(String otherUserUid) async {
    final snapshot = await userProfileViewRef.child(otherUserUid).get();
    return snapshot.exists;
  }

  /// Create a new action log for user profiel view
  static Future<void> userProfileView(String otherUserUid) async {
    if (myUid == null) return;
    if (ActionLogService.instance.userProfileView.ref == null) return;
    final ref = userProfileViewRef.child(otherUserUid);
    dog("[Check] User Profile View Ref: ${ref.path}");
    try {
      final snapshot = await ref.get();
      if (snapshot.exists) {
        return;
      }
      return await ref.set({
        'createdAt': ServerValue.timestamp,
      });
    } catch (e) {
      dog('----> ActionLog.userProfileView() Error: $e, path: ${ref.path}');
      rethrow;
    }
  }

  /// Check if the chat join exists
  ///
  /// 만약, [roomId] 의 채팅방에 들어간 적이 있다면, true 를 반환한다.
  /// 이 함수는 action log 에서, overtime 이 발생 할 때, 이전에 입장한 채팅방이면 그대로 입장 할 수 있게 위해서 사용한다.
  static Future<bool> chatJoinExists(String roomId) async {
    final snapshot = await chatJoinRef.child(roomId).get();
    return snapshot.exists;
  }

  /// Create a new action log for chat join
  static Future<void> chatJoin(String roomId) async {
    if (myUid == null) return;
    if (ActionLogService.instance.chatJoin.ref == null) return;

    final ref = chatJoinRef.child(roomId);

    try {
      final snapshot = await ref.get();
      if (snapshot.exists) {
        return;
      }
      return await ref.set({
        'createdAt': ServerValue.timestamp,
      });
    } catch (e) {
      dog('----> ActionLog.chatJoin() Error: $e, path: ${ref.path}');
      rethrow;
    }
  }

  /// Create a new action log for post creation
  ///
  ///
  static Future<void> postCreate({
    required String category,
    required String postId,
  }) async {
    if (myUid == null) return;

    /// 글 생성 액션 기록 설정이 없으면, 그냥 리턴.
    ///
    /// 그래서, 만약, 전체 기록만 남길 수 없고, 설정이 되어져 있다면, 모든 카테고리를 다 기록한다.
    /// 제한 할 때에만, 특정 카테고리를 제한 할 수 있다.
    if (ActionLogService.instance.postCreate.isEmpty) {
      return;
      // if (await ActionLogService.instance.postCreate[category]!.isOverLimit()) {
      //   return;
      // }
    }

    /// For logging all posts
    final ref = categoryCreateRef('all').child(postId);
    final categoryRef = categoryCreateRef(category).child(postId);

    try {
      await ref.set({
        'createdAt': ServerValue.timestamp,
      });

      /// For logging category specific posts
      await categoryRef.set({
        'createdAt': ServerValue.timestamp,
      });
    } catch (e) {
      dog('----> ActionLog.postCreate() Error: $e, path: ${ref.path}');
      rethrow;
    }
  }

  /// Create a new action log for comment creation
  static Future<void> commentCreate({
    required String postId,
    required String commentId,
  }) async {
    if (myUid == null) return;
    if (ActionLogService.instance.commentCreate.ref == null) return;
    final ref = commentCreateRef.child(commentId);
    try {
      return await ref.set({
        'createdAt': ServerValue.timestamp,
        'postId': postId,
      });
    } catch (e) {
      dog('----> ActionLog.commentCreate() Error: $e, path: ${ref.path}');
      rethrow;
    }
  }
}
