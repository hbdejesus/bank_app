import 'package:bank_app/utils/enum/status.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TransactionStatus extends StatelessWidget {
  const TransactionStatus({
    required this.status,
    super.key,
  });

  final Status status;

  IconData getIcon() => switch (status) {
        Status.inProgress => FontAwesomeIcons.info,
        Status.done => FontAwesomeIcons.circleCheck,
        Status.failed => FontAwesomeIcons.circleXmark,
        Status.undefined => FontAwesomeIcons.question,
      };

  Color getColor() => switch (status) {
        Status.inProgress => Colors.yellow.shade200,
        Status.done => Colors.green,
        Status.failed => Colors.red,
        Status.undefined => Colors.grey,
      };

  @override
  Widget build(BuildContext context) => Container(
        height: 50,
        width: 50,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: getColor(),
          shape: BoxShape.circle,
        ),
        child: FaIcon(getIcon()),
      );
}
