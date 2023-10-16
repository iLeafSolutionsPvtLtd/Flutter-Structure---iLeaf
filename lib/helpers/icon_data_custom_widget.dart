import 'package:flutter/material.dart';
import 'package:flutter_structure/helpers/commons.dart';

class IconDataCustomWidget extends StatelessWidget {
  const IconDataCustomWidget({
    required this.value,
    super.key,
    this.text,
    this.direction = Direction.right,
    this.asset,
  });
  final String? text;
  final String value;
  final Direction? direction;
  final String? asset;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (direction == Direction.right)
          Row(
            children: [
              if (asset != null)
                Image.asset(
                  asset!,
                  scale: 10,
                ),
              Text(
                value,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ],
          )
        else
          Column(
            children: [
              if (asset != null)
                Image.asset(
                  asset!,
                  scale: 10,
                ),
              Text(
                value,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ],
          ),
        if (text != null)
          Text(
            text.toString(),
            style: Theme.of(context).textTheme.bodyMedium,
          ),
      ],
    );
  }
}
