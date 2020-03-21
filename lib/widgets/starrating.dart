import 'package:flutter/material.dart';

class StarRating extends StatelessWidget {
  final void Function(int index) onChanged;
  final int value;
  final IconData filledStar;
  final IconData unfilledStar;
  final double size;
  final bool iconsOnly;
  const StarRating(
      {Key key,
      this.value = 0,
      this.filledStar,
      this.unfilledStar,
      this.onChanged,
      this.size,
      this.iconsOnly})
      : assert(value != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).accentColor;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        return iconsOnly ?? false
            ? Icon(
                index < value
                    ? filledStar ?? Icons.star
                    : unfilledStar ?? Icons.star_border,
                color: index < value ? color : null,
                size: size ?? 36.0,
              )
            : IconButton(
                onPressed: onChanged != null
                    ? () {
                        onChanged(value == index + 1 ? index : index + 1);
                      }
                    : null,
                color: index < value ? color : null,
                iconSize: size ?? 36.0,
                icon: Icon(
                  index < value
                      ? filledStar ?? Icons.star
                      : unfilledStar ?? Icons.star_border,
                ),
                padding: EdgeInsets.zero,
                tooltip: "${index + 1} of 5",
              );
      }),
    );
  }
}
