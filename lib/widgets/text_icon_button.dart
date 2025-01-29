import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class TextIconButton extends StatelessWidget {
  const TextIconButton({
    required this.onPressed,
    required this.icon,
    required this.text,
    super.key,
  });

  final VoidCallback onPressed;
  final Widget icon;
  final String text;

  @override
  Widget build(BuildContext context) => InkWell(
        onTap: onPressed,
        child: SizedBox(
          width: 100,
          height: 75,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              icon,
              const Gap(10),
              Text(
                text,
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
}
