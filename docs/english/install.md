# Installation

Follow the instruction below to install Fireflutter into your app.

## Install Fireflutter

### Install Fireflutter as a package

Simply add the latest version of Fireflutter from pub.dev.

### Install Fireflutter as a package developer

You may wish to develop your app while building(or updating) the Fireflutter package together.

- Fork the Fireflutter from `https://github.com/thruthesky/fireflutter`

- Then, clone it

- Then, create a branch in Fireflutter local repository

- Create `apps` folder under the root of Fireflutter folder and create your app inside `apps` folder.

```dart
mkdir apps
cd apps
flutter create your_project
```

- You need to add the path of the dependency as `../..`. Add the Fireflutter dependency like below.

```yaml
dependencies:
  fireflutter:
    path: ../..
```

- If you have update any code in Fireflutter, consider to submit a `pull request`.

## Installing Firebase Realtime Database Security

Copy the [Firebase Realtime Database Security](../assets/realtime_database_security_rules.md) and paste it into your Firebase project, then save it.

## Default app-environment entitlement

Add the following code into `info.plist`. These will be needed for access to camera and gallery.

```xml
<key>NSCameraUsageDescription</key>
<string>PhiLov app requires access to the camera to share the photo on profile, chat, forum.</string>
<key>NSMicrophoneUsageDescription</key>
<string>PhiLov app requires access to the microphone to share vioce with other users.</string>
<key>NSPhotoLibraryUsageDescription</key>
<string>PhiLov app requires access to the photo library to share the photo on profile, chat, forum.</string>
```

## Install Cloud Functions

Run the following command to install all the push notification cloud functions.

```sh
% cd firebase/function
% npm run deploy:message
```

And set the end point URL to `MessagingService.instance.init(sendPushNotificationsUrl: ..)`

Run the following command to install typesense related cloud functions.

```sh
% cd firebase/function
% npm run deploy:typesense
```

Run the following command to install a function that manages summarization of all posts under `/posts-all-summary`.
See the [Forum](forum.md) document for the details.

```sh
% cd firebase/function
% npm run deploy:managePostsAllSummary
```

## Initializing TextService

Fireflutter has some UI and you may want to show it in different languages.

And you can use the text translation funtionality in your app.

```dart

/// Call this somewhere while the app boots.
initTextService();

void initTextService() {
  print('--> AppService.initTextService()');

  TextService.instance.texts = {
    ...TextService.instance.texts,
    if ( languageCode == 'ko' ) ...{
      T.ok: '확인',
      T.no: '아니오',
      T.yes: '예',
      T.error: '에러',
      T.dismiss: '닫기',
      Code.profileUpdate: '프로필 수정',
      Code.recentLoginRequiredForResign:
          '회원 탈퇴는 본인 인증을 위해서, 로그아웃 후 다시 로그인 한 다음 탈퇴하셔야합니다.',
      Categories.qna: '질문',
      Categories.discussion: '토론',
      Categories.buyandsell: '장터',
      Categories.info: '정보/알림',
      T.notVerifiedMessage: '본인 인증을 하셔야 전체 기능을 이용 할 수 있습니다.',
      T.chatRoomNoMessageYet: '앗, 아직 메시지가 없습니다.\n채팅을 시작 해 보세요.',
    },
    if ( languageCode == 'en' ) ...{
      T.ok: 'Ok',
      // ...
    }
  };
}
```

## Admin

- See [Admin Doc](admin.md)

## Unit tests

- There are many unit test codes. You can read other document of Fireflutter on how to install and test the unit test codes.
