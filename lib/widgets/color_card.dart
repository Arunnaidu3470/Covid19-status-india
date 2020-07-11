import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ColorCard extends StatelessWidget {
  final Color backgroundColor;
  final String title;
  final int flex;
  final int count;
  final int subCount;

  ColorCard({
    Key key,
    @required this.backgroundColor,
    @required this.title,
    this.flex,
    this.count,
    this.subCount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex ?? 1,
      child: Container(
        decoration: BoxDecoration(
            color: backgroundColor ?? Colors.transparent,
            borderRadius: BorderRadius.circular(10)),
        height: 100,
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title ?? '',
              style: Theme.of(context).primaryTextTheme.bodyText1,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  subCount != null ? '+${formatNumber(subCount)}' : '',
                  style: Theme.of(context)
                      .primaryTextTheme
                      .bodyText1
                      .copyWith(fontSize: 15, fontWeight: FontWeight.w400),
                ),
                Text(
                  formatNumber(count),
                  style: Theme.of(context)
                      .primaryTextTheme
                      .bodyText1
                      .copyWith(fontSize: 20),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String formatNumber(int number) {
    if (number == null) return '';
    return NumberFormat('#,##,###').format(number);
  }
}
