import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fireflutter/fireflutter.dart';

class Club {
  static final col = FirebaseFirestore.instance.collection('clubs');

  String id;
  final String uid;
  final String master;
  final String name;
  final String description;
  final String? photoUrl;
  final List<String> users;
  final String reminder;

  Club({
    required this.id,
    required this.uid,
    required this.master,
    required this.name,
    required this.description,
    this.photoUrl,
    required this.users,
    required this.reminder,
  });

  DocumentReference get ref => col.doc(id);

  bool get joined => users.contains(myUid);
  bool get isMaster => master == myUid;

  factory Club.fromSnapshot(DocumentSnapshot snapshot) {
    return Club.fromMap(snapshot.data() as Map, snapshot.id);
  }

  factory Club.fromMap(Map<dynamic, dynamic> map, String id) {
    return Club(
      id: id,
      uid: map['uid'],
      master:
          map['master'] ?? map['uid'], // 초반 개발에서 에러 방지. 나중에 map[uid] 는 없애도 됨.
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      photoUrl: map['photoUrl'],
      users: List<String>.from((map['users'] ?? [])),
      reminder: map['reminder'] ?? '',
    );
  }

  @override
  String toString() {
    return 'Club{id: $id, uid: $uid, master: $master, name: $name, description: $description, photoUrl: $photoUrl, users: $users, reminder: $reminder}';
  }

  /// 클럽 생성을 위한, 데이터 맵을 만든다.
  static Map<String, dynamic> toCreate({
    required String name,
  }) {
    return {
      'uid': myUid!,
      'master': myUid!,
      'users': [myUid!],
      'name': name,
      'createdAt': FieldValue.serverTimestamp(),
    };
  }

  static Future<Club> get(DocumentReference ref) async {
    final snapshot = await ref.get();
    return Club.fromSnapshot(snapshot);
  }

  /// 모임 만들기
  ///
  /// 1. 채팅방 생성
  /// 2. 게시판 생성
  /// 3. 갤러리 게시판 생성
  ///
  /// 생성된 Club 객체를 리턴한다.
  static Future<Club> create({
    required String name,
  }) async {
    if (name.trim().isEmpty) {
      throw FireFlutterException('club-create/name-empty', 'Input name.');
    }

    final ref = await col.add(
      Club.toCreate(
        name: name,
      ),
    );

    final club = await Club.get(ref);

    final room = await ChatRoom.create(
      name: name,
      roomId: club.id,
      isOpenGroupChat: false,
    );

    final chat = ChatModel(room: room);
    await chat.join(forceJoin: true);

    return club;
  }

  /// Update club
  ///
  /// [photoUrl] is optional. After uploading photo into Storage, set the photo url using this parameter.
  /// And [hasPhoto] is set to true if [photoUrl] is not null.
  /// If [photoUrl] is null, it does not update [photoUrl], nor [hasPhoto]
  /// ! If [photoUrl] is empty string, then, [photoUrl] is deleted from document and [hasPhoto] is set to false.
  ///
  ///
  Future<void> update({
    String? name,
    String? description,
    String? photoUrl,
    bool? hasPhoto,
    String? reminder,
  }) async {
    // 모임 이름이 들어오는 경우, 빈 문자열이면 에러
    if (name != null && name.trim().isEmpty) {
      throw FireFlutterException('club-update/name-empty', 'Input name.');
    }

    final Map<String, dynamic> data = {
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      'updatedAt': FieldValue.serverTimestamp(),
      if (reminder != null) 'reminder': reminder,
    };

    /// Photo
    if (photoUrl == null) {
      /// do nothing
    } else if (photoUrl == '') {
      data['photoUrl'] = FieldValue.delete();
      data['hasPhoto'] = false;
    } else {
      data['photoUrl'] = photoUrl;
      data['hasPhoto'] = true;
    }

    await ref.update(data);
  }

  /// 클럽 가입
  ///
  /// 클럽 가입 할 때, 채팅방에 따로 입장 할 필요 없이, 최초 채팅방 입장시 자동으로 chat-rooms/{users}, chat-join 등이 설정된다.
  /// 하지만, 사용자가 채팅방에 입장을 하지 않을 수 있으니, 미리 채팅방 입장을 해 준다.
  join() async {
    await ref.update({
      'users': FieldValue.arrayUnion([myUid]),
    });
    await ChatRoom.fromRoomdId(id).join(myUid!, forceJoin: true);
  }

  /// 클럽 탈퇴
  ///
  /// 이 때, 채팅방도 같이 탈퇴를 해야 한다.
  leave() async {
    await ref.update({
      'users': FieldValue.arrayRemove([myUid]),
    });
    await ChatRoom.fromRoomdId(id).leave();
  }
}