import 'package:fireflutter/fireflutter.dart';
import 'package:flutter/material.dart';

class ClubCreateForm extends StatefulWidget {
  const ClubCreateForm({
    super.key,
    required this.onCreate,
  });

  final void Function(Club club) onCreate;

  @override
  State<ClubCreateForm> createState() => _ClubCreateFormState();
}

class _ClubCreateFormState extends State<ClubCreateForm> {
  final TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(T.meetingName.tr),
        TextField(
          controller: nameController,
          onChanged: (value) => setState(() {}),
        ),
        const SizedBox(height: 8),
        Text(T.meetingNameDescription.tr),
        const SizedBox(height: 24),
        if (nameController.text.trim().isNotEmpty)
          Align(
            child: OutlinedButton(
              onPressed: () async {
                final club = await Club.create(name: nameController.text);
                widget.onCreate(club);
              },
              child: Text(T.createAMeeting.tr),
            ),
          ),
      ],
    );
  }
}
