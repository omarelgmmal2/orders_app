import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../utils/app_color.dart';
import '../utils/spacing.dart';
import '../utils/text_style_theme.dart';

class RatBar extends StatefulWidget {
  final double itemSize;
  final MainAxisAlignment mainAxisAlignment;

  const RatBar({
    super.key,
    this.itemSize = 15,
    this.mainAxisAlignment = MainAxisAlignment.start,
  });

  @override
  State<RatBar> createState() => _RatBarState();
}

class _RatBarState extends State<RatBar> {
  double ratingBarValue = 0;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: widget.mainAxisAlignment,
      children: [
        RatingBar.builder(
          initialRating: 0,
          glow: false,
          minRating: 1,
          maxRating: 5,
          direction: Axis.horizontal,
          allowHalfRating: true,
          itemCount: 5,
          itemSize: widget.itemSize,
          unratedColor: AppColor.gray,
          itemBuilder: (context, _) => Icon(Icons.star, color: Colors.amber),
          onRatingUpdate: (rating) {
            setState(() {
              ratingBarValue = rating;
            });
          },
        ),
        horizontalSpace(5),
        Text(
          "($ratingBarValue)".toString(),
          style: TextStyleTheme.textStyle11Regular,
        ),
      ],
    );
  }
}
