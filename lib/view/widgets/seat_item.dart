import 'package:ye_airways/shared/styles/colors.dart';
import 'package:flutter/material.dart';

class SeatItem extends StatefulWidget {
  int status;
  Function() onTap;

  SeatItem({Key? key, required this.status, required this.onTap})
      : super(key: key);

  @override
  State<SeatItem> createState() => _SeatItemState();
}

class _SeatItemState extends State<SeatItem> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    backgroundColor() {
      switch (widget.status) {
        case 0:
          return kAvailableColor;
        case 1:
          return kPrimaryColor;
        case 2:
          return kUnavailableColor;
        default:
          return kUnavailableColor;
      }
    }

    borderColor() {
      switch (widget.status) {
        case 0:
          return kPrimaryColor;
        case 1:
          return kPrimaryColor;
        case 2:
          return kUnavailableColor;
        default:
          return kUnavailableColor;
      }
    }

    child() {
      switch (widget.status) {
        case 0:
          return const SizedBox();
        case 1:
          return Center(
            child: Text(
              'You',
              style: whiteTextStyle.copyWith(fontWeight: semiBold),
            ),
          );
        case 2:
          return const SizedBox();
        default:
          return const SizedBox();
      }
    }

    return InkWell(
      onTap: widget.onTap,
      child: Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
              color: backgroundColor(),
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: borderColor(), width: 2)),
          child: child()),
    );
  }
}
