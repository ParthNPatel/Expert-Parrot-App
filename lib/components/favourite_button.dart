import 'package:flutter/material.dart';

import '../constant/color_const.dart';
import '../constant/image_const.dart';
import 'common_widget.dart';

class FavouriteButton extends StatefulWidget {
  const FavouriteButton({Key? key}) : super(key: key);

  @override
  State<FavouriteButton> createState() => _FavouriteButtonState();
}

class _FavouriteButtonState extends State<FavouriteButton> {
  bool _isFavourite = false;
  @override
  Widget build(BuildContext context) {
    return InkResponse(
      onTap: () {
        setState(() {
          _isFavourite = !_isFavourite;
        });
      },
      child: _isFavourite == true
          ? Icon(
              Icons.favorite,
              size: 20,
              color: Colors.red,
            )
          : CommonWidget.commonSvgPitcher(
              height: 20,
              image: ImageConst.hartBorderIcon,
              color: CommonColor.gery636363),
    );
  }
}
