import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';

class WalletCard extends StatefulWidget {
  const WalletCard({
    super.key,
    required this.balance,
    this.isLoading = false,
  });

  final double balance;
  final bool isLoading;

  @override
  State<WalletCard> createState() => _WalletCardState();
}

class _WalletCardState extends State<WalletCard> {
  bool showBalance = true;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Stack(
      children: [
        SvgPicture.asset('assets/coins_card.svg'),
        Positioned(
          left: 0,
          right: 0,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Current Balance',
                      style: textTheme.bodyMedium?.copyWith(color: Colors.white),
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          showBalance = !showBalance;
                        });
                      },
                      icon: FaIcon(showBalance ? FontAwesomeIcons.eyeSlash : FontAwesomeIcons.eye),
                      color: Colors.white,
                    )
                  ],
                ),
                const Gap(20),
                if (widget.isLoading)
                  const CircularProgressIndicator()
                else
                  Text(
                    showBalance ? 'PHP ${widget.balance.toStringAsFixed(2)}' : 'PHP ******',
                    style: textTheme.headlineMedium?.copyWith(color: Colors.white),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
