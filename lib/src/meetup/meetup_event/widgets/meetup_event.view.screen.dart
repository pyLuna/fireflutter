import 'package:cached_network_image/cached_network_image.dart';
import 'package:fireflutter/fireflutter.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MeetupEventViewScreen extends StatefulWidget {
  const MeetupEventViewScreen({
    super.key,
    required this.event,
  });

  final MeetupEvent event;

  @override
  State<MeetupEventViewScreen> createState() => _MeetupEventViewScreenState();
}

class _MeetupEventViewScreenState extends State<MeetupEventViewScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MeetupEventDoc(
      event: widget.event,
      builder: (event) => Scaffold(
        appBar: AppBar(
          title: Text(widget.event.title),
          actions: [
            if (event.uid == myUid)
              IconButton(
                onPressed: () {
                  MeetupEventService.instance.showUpdateScreen(
                    context: context,
                    event: widget.event,
                  );
                },
                icon: const Icon(
                  Icons.edit,
                ),
              ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (event.photoUrl != null)
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: CachedNetworkImage(
                    imageUrl: event.photoUrl!,
                    width: double.infinity,
                    height: 200,
                    fit: BoxFit.cover,
                    errorWidget: (context, url, error) {
                      dog('meetup_event.view.screen: Image url has problem: $error');
                      return const Center(
                        child: Icon(
                          Icons.error_outline,
                          color: Colors.red,
                        ),
                      );
                    },
                  ),
                ),
              const SizedBox(height: 16),
              Text(
                T.meetupDateAndTime.tr,
                style: Theme.of(context).textTheme.labelSmall,
              ),
              if (event.meetAt != null)
                Row(
                  children: [
                    Text(
                      DateFormat.yMMMEd().format(event.meetAt!),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      DateFormat.jm().format(event.meetAt!),
                    ),
                  ],
                ),
              const SizedBox(height: 16),
              Text(
                T.meetupDescriptionLabel.tr,
                style: Theme.of(context).textTheme.labelSmall,
              ),
              SizedBox(
                width: double.infinity,
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text(event.description),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              if (event.joined)
                ElevatedButton(
                  onPressed: () async {
                    if (event.joined == false) {
                      error(
                        context: context,
                        title: T.meetupMembershipRequired.tr,
                        message: T.meetupMembershipRequiredMessage.tr,
                      );
                      return;
                    }
                    await event.leave();
                    toast(
                      context: context,
                      message: T.meetupCancelledAttendance.tr,
                    );
                  },
                  child: Text(T.meetupCancelAttendance.tr),
                )
              else
                ElevatedButton(
                  onPressed: () async {
                    /// * Refactor this not to access database. Or caching the meetup data.
                    final meetup = await Meetup.get(id: event.meetupId!);

                    /// if the user is block from meetup display apply attend blocked  error message
                    if (meetup.blocked == true) {
                      error(
                        context: context,
                        title: T.meetupEventApplyAttendBlocked.tr,
                        message: T.meetupEventApplyAttendBlockedMessage.tr,
                      );
                      return;
                    }

                    /// if the user didnt join the meetup display membership required error message
                    if (meetup.joined == false) {
                      error(
                        context: context,
                        title: T.meetupMembershipRequired.tr,
                        message: T.joinFirstThenApplyToAttend.tr,
                      );
                      return;
                    }
                    await event.join();
                    toast(
                        context: context, message: T.applyToAttendConfirmed.tr);
                  },
                  child: Text(T.applyToAttend.tr),
                ),
              const SizedBox(height: 16),
              Text(T.listOfAttendees.tr),
              if (event.users.isNotEmpty)
                Wrap(
                  children: event.users
                      .map(
                        (uid) => Padding(
                          padding: const EdgeInsets.all(8),
                          child: UserAvatar.sync(
                            uid: uid,
                            size: 64,
                            radius: 26,
                          ),
                        ),
                      )
                      .toList(),
                )
              else
                Text(T.noApplicantsYet.tr),
            ],
          ),
        ),
      ),
    );
  }
}
