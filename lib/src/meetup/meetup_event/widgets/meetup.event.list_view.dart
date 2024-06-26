import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:fireflutter/fireflutter.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

/// 모임 목록 위젯
///
/// [meetup] Meetup data model. 이 값이 주어지면, 해당 클럽의 모임 목록만 표시한다.
///
/// [query] 파라미터를 통해, Firestore 쿼리를 전달할 수 있다. 기본 값은 `Club.col.orderBy('createdAt', descending: true)` 이다.
///
/// [loadingBuilder] 파라미터를 통해, 데이터를 불러오는 중일 때 보여줄 위젯을 지정할 수 있다. 기본 값은 `CircularProgressIndicator.adaptive()` 이다.
///
/// [errorBuilder] 파라미터를 통해, 에러가 발생했을 때 보여줄 위젯을 지정할 수 있다. 기본 값은 `Text('Something went wrong! ${snapshot.error}')` 이다.
///
/// [separatorBuilder] 파라미터를 통해, 각 아이템 사이에 보여줄 위젯을 지정할 수 있다. 기본 값은 `SizedBox.shrink()` 이다.
///
/// 그 외, [ListView.separated] 가 지원하는 모든 옵션(파라미터)을 지원한다. 따라서 [ListView.separated] 를 사용하듯 사용하면 된다.
///
class MeetupEventListView extends StatelessWidget {
  const MeetupEventListView({
    super.key,
    this.meetup,
    this.query,
    this.pageSize = 10,
    this.loadingBuilder,
    this.errorBuilder,
    this.separatorBuilder,
    this.scrollDirection = Axis.vertical,
    this.reverse = false,
    this.controller,
    this.primary,
    this.physics,
    this.shrinkWrap = false,
    this.padding,
    this.addAutomaticKeepAlives = true,
    this.addRepaintBoundaries = true,
    this.addSemanticIndexes = true,
    this.cacheExtent,
    this.dragStartBehavior = DragStartBehavior.start,
    this.keyboardDismissBehavior = ScrollViewKeyboardDismissBehavior.manual,
    this.restorationId,
    this.clipBehavior = Clip.hardEdge,
    this.itemBuilder,
    this.emptyBuilder,
  });

  final Meetup? meetup;
  final Query? query;

  final int pageSize;
  final Widget Function()? loadingBuilder;
  final Widget Function(String)? errorBuilder;
  final Widget Function(BuildContext, int)? separatorBuilder;
  final Axis scrollDirection;
  final bool reverse;
  final ScrollController? controller;
  final bool? primary;
  final ScrollPhysics? physics;
  final bool shrinkWrap;
  final EdgeInsetsGeometry? padding;
  final bool addAutomaticKeepAlives;
  final bool addRepaintBoundaries;
  final bool addSemanticIndexes;
  final double? cacheExtent;
  final DragStartBehavior dragStartBehavior;
  final ScrollViewKeyboardDismissBehavior keyboardDismissBehavior;
  final String? restorationId;
  final Clip clipBehavior;
  final Widget Function(MeetupEvent, Meetup?, int)? itemBuilder;
  final Widget Function()? emptyBuilder;

  @override
  Widget build(BuildContext context) {
    Query? q = query;
    if (q == null) {
      q = MeetupEvent.col;
      if (meetup != null) {
        q = q.where('meetupId', isEqualTo: meetup!.id);
      }
      q = q.orderBy('createdAt', descending: true);
    }

    return FirestoreQueryBuilder(
      query: q,
      builder: (_, snapshot, __) {
        if (snapshot.isFetching) {
          return loadingBuilder?.call() ??
              const Center(child: CircularProgressIndicator.adaptive());
        }

        if (snapshot.hasError) {
          dog('Error: ${snapshot.error}');
          return errorBuilder?.call(snapshot.error.toString()) ??
              Text('Something went wrong! ${snapshot.error}');
        }

        if (snapshot.hasData && snapshot.docs.isEmpty && !snapshot.hasMore) {
          return emptyBuilder?.call() ??
              const Center(child: Text('No club found.'));
        }

        return ListView.separated(
          scrollDirection: scrollDirection,
          itemCount: snapshot.docs.length,
          separatorBuilder: (context, index) =>
              separatorBuilder?.call(context, index) ?? const SizedBox.shrink(),
          reverse: reverse,
          controller: controller,
          primary: primary,
          physics: physics,
          shrinkWrap: shrinkWrap,
          padding: padding,
          addAutomaticKeepAlives: addAutomaticKeepAlives,
          addRepaintBoundaries: addRepaintBoundaries,
          addSemanticIndexes: addSemanticIndexes,
          cacheExtent: cacheExtent,
          dragStartBehavior: dragStartBehavior,
          keyboardDismissBehavior: keyboardDismissBehavior,
          restorationId: restorationId,
          clipBehavior: clipBehavior,
          itemBuilder: (context, index) {
            // if we reached the end of the currently obtained items, we try to
            // obtain more items
            if (snapshot.hasMore && index + 1 == snapshot.docs.length) {
              // Tell FirestoreQueryBuilder to try to obtain more items.
              // It is safe to call this function from within the build method.
              snapshot.fetchMore();
            }
            final event = MeetupEvent.fromSnapshot(snapshot.docs[index]);
            return itemBuilder?.call(event, meetup, index) ??
                MeetupEventCard(
                  event: event,
                  meetup: meetup,
                );
          },
        );
      },
    );
  }
}
