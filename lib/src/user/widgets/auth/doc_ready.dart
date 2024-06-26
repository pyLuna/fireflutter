import 'package:fireflutter/fireflutter.dart';
import 'package:flutter/material.dart';

/// DocReady
///
/// 사용자 문서가 로딩되었는지 확인한다. 단순히, [MyDoc] 위젯을 사용하여, 사용자 문서가 로딩되었는지 확인하는 것으로
/// 사용자 문서가 로딩되었으면, builder(User)이 실행되며, 로딩이 안되었으면, [loading] 이 실행된다.
///
/// [MyDoc] 을 사용하면, builder(User) 가 null 일 수 있으므로, null 체크를 해야 하는데,
/// [DocReady] 는 builder(User) 가 null 이 아니므로 조금 더 편리하게 사용 할 수 있다.
///
class DocReady extends StatelessWidget {
  const DocReady({super.key, required this.builder, this.loadingBuilder});

  final Widget Function(User) builder;
  final Widget Function()? loadingBuilder;

  @override
  Widget build(BuildContext context) {
    return MyDoc(builder: (my) {
      if (my == null) {
        return loadingBuilder?.call() ?? const SizedBox.shrink();
      }
      return builder(my);
    });
  }
}
