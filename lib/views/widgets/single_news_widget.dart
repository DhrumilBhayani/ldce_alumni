import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ldce_alumni/core/jumping_dots.dart';
import 'package:ldce_alumni/core/text.dart';
import 'package:ldce_alumni/views/news/single_news_screen.dart';
// import 'package:flutx/flutx.dart';

class SingleNewsWidget extends StatelessWidget {
  final String? imageUrl, date, title, shortDescription, description;
  const SingleNewsWidget(
      {@required this.imageUrl,
      this.title,
      this.date,
      this.shortDescription,
      this.description,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => SingleNewsScreen(
                      title: title!,
                      imageUrl: imageUrl!,
                      date: date!,
                      shortDescription: shortDescription!,
                      description: description!,
                    )));
      },
      child: Container(
        margin: EdgeInsets.only(top: 24),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                borderRadius: BorderRadius.all(Radius.circular(12)),
                child: imageUrl != ''
                    ? CachedNetworkImage(
                        progressIndicatorBuilder: (context, url, downloadProgress) => Container(
                            margin: EdgeInsets.only(top: 0, bottom: 0),
                            child: Container(
                                height: 10,
                                width: 10,
                                child: JumpingDots(
                                  color: theme.colorScheme.primary,
                                  numberOfDots: 4,
                                ))),
                        imageUrl: 'https://' + imageUrl!,
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover)
                    : Image.asset(
                        './assets/images/ld.jpg',
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      )),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FxText.b2(date!, color: theme.colorScheme.onBackground, fontWeight: 600, xMuted: true),
                  const SizedBox(
                    height: 4,
                  ),
                  FxText.b1(title!, color: theme.colorScheme.onBackground, fontWeight: 600),
                  const SizedBox(
                    height: 8,
                  ),
                  FxText.b2(
                    shortDescription!,
                    color: theme.colorScheme.onBackground,
                    fontSize: 13,
                    xMuted: true,
                    overflow: TextOverflow.ellipsis,
                  ),

                  // Row(
                  //   children: [
                  //     Expanded(
                  //         child: FxText.b2(date,
                  //             color: theme.colorScheme.onBackground,
                  //             fontSize: 11,
                  //             xMuted: true)),
                  //     Container(
                  //       decoration: BoxDecoration(
                  //           color:
                  //               theme.colorScheme.onBackground.withAlpha(100),
                  //           shape: BoxShape.circle),
                  //       width: 4,
                  //       height: 4,
                  //     ),
                  //     SizedBox(
                  //       width: 4,
                  //     ),

                  //   ],
                  // )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
