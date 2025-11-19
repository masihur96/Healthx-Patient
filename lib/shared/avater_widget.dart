import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

Widget getAvatarWidget(String avatar, String firstName, String lastName) {
  final isSvg =
      avatar.toLowerCase().endsWith(".svg") || avatar.contains("/svg");

  if (avatar.isEmpty) {
    return Text(
      firstName.isEmpty || lastName.isEmpty
          ? "N/A"
          : '${firstName[0]}${lastName[0]}',
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
    );
  } else if (isSvg) {
    return ClipOval(
      child: SvgPicture.network(
        avatar,
        fit: BoxFit.cover,
        placeholderBuilder: (_) =>
            const Center(child: CircularProgressIndicator(strokeWidth: 1.5)),
      ),
    );
  } else {
    print("Avatar::$avatar");
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
      ),
      child: ClipOval(
        child: CachedNetworkImage(
          imageUrl: avatar,
          height: 200,
          width: 200,
          fit: BoxFit.cover,
          placeholder: (context, url) => Center(
            child: CircularProgressIndicator(strokeWidth: 2),
          ),
          errorWidget: (context, url, error) => Icon(Icons.person, size: 30),
        ),
      ),
    );
  }
}
