import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';

class CustomListViewItem extends StatelessWidget {
  final String title;
  final String subTitle;
  final void Function()? onPressed;
  final QueryArtworkWidget queryArtworkWidget;
  const CustomListViewItem(
      {super.key,
      required this.title,
      required this.subTitle,
      required this.onPressed,
      required this.queryArtworkWidget});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: IconButton(onPressed: onPressed, icon: queryArtworkWidget),
      title: Text(title),
      subtitle: Text(subTitle),
      trailing: const Icon(
        Icons.more_horiz,
        color: Colors.grey,
      ),
    );
  }
}
