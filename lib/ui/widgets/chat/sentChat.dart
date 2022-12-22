import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:realtime_chat/shared/theme.dart';

class SentChat extends StatelessWidget {
  final String message;
  const SentChat({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 15),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          const Expanded(
            flex: 1,
            child: SizedBox(width: double.infinity),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
              flex: 8,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Stack(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(bottom: 5, right: 6),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 8),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                message,
                                style: blackTextStyle.copyWith(fontSize: 16),
                              ),
                              Container(
                                alignment: Alignment.bottomRight,
                                margin: const EdgeInsets.only(top: 5),
                                child: Text(
                                  '09.19',
                                  textAlign: TextAlign.right,
                                  style: greyTextStyle.copyWith(
                                      fontSize: 14, fontWeight: light),
                                ),
                              )
                            ]),
                        decoration: BoxDecoration(
                            border: Border.all(color: kBGGreyColor),
                            borderRadius: BorderRadius.circular(10),
                            color: kBGBlueColor),
                      ),
                      Positioned(
                        bottom: 2,
                        right: 0,
                        child: SvgPicture.asset(
                            'assets/polygon_chat_shape_primary.svg'),
                      ),
                    ],
                  )
                ],
              ))
        ],
      ),
    );
  }
}
