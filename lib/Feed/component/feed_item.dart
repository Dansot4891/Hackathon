import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:wagle_front/Feed/model/feed_model.dart';

class FeedItem extends ConsumerStatefulWidget {
  final String id;
  final String name;
  final String content;
  final int like;

  const FeedItem({
    super.key,
    required this.id,
    required this.name,
    required this.content,
    required this.like,
  });

  factory FeedItem.fromJson({required FeedItemModel model}) {
    return FeedItem(
        id: model.id,
        name: model.name,
        content: model.content,
        like: model.like);
  }

  @override
  ConsumerState<FeedItem> createState() => _FeedMainState();
}

class _FeedMainState extends ConsumerState<FeedItem> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Container(
      width: width * 0.9,
      height: height * 0.16,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey),
      ),
      child: InkWell(
        onTap: () {
          context.push('/course/${widget.id}');
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              _renderLeading(width * 0.25, widget.id),
              const SizedBox(
                width: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                      width: width * 0.5, child: _renderTitle(widget.name)),
                  const Spacer(),
                  _renderSubTitle(widget.content),
                  const Spacer(),
                  SizedBox(
                    width: width * 0.5,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: () {},
                          child: Container(
                            width: 70,
                            height: 35,
                            decoration: BoxDecoration(
                                border: Border.all(width: 1),
                                borderRadius: BorderRadius.circular(8)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.thumb_up),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(widget.like.toString()),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

Widget _renderLeading(double width, String id) {
  return const Text(
    '\u{1f60D}',
    style: TextStyle(fontSize: 100),
  );
}

Widget _renderTitle(String title) {
  return RichText(
    maxLines: 3,
    text: TextSpan(
        text: title,
        style: const TextStyle(
            color: Colors.black, fontWeight: FontWeight.w500, fontSize: 18)),
    overflow: TextOverflow.ellipsis,
  );
}

Widget _renderSubTitle(String subTitle) {
  return Text(
    subTitle,
    overflow: TextOverflow.ellipsis,
  );
}
