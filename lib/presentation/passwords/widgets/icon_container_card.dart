import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';

class IconContainerCard extends StatelessWidget {
  final IconData icon;
  final Function iconPressed;
  final List<IconData> iconList = [
    CommunityMaterialIcons.netflix,
    CommunityMaterialIcons.amazon,
    CommunityMaterialIcons.spotify,
    CommunityMaterialIcons.instagram,
    CommunityMaterialIcons.facebook,
    CommunityMaterialIcons.snapchat,
    CommunityMaterialIcons.twitter,
    CommunityMaterialIcons.email,
    CommunityMaterialIcons.shopping,
    CommunityMaterialIcons.web,
    CommunityMaterialIcons.school,
    CommunityMaterialIcons.laptop,
    CommunityMaterialIcons.bag_suitcase,
    CommunityMaterialIcons.airplane,
    CommunityMaterialIcons.run,
    // CommunityMaterialIcons.
  ];
  IconContainerCard({
    required this.icon,
    required this.iconPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final double mediaWidth = MediaQuery.of(context).size.width;
    final themeData = Theme.of(context);
    final double containerWidth = mediaWidth * 0.8;
    final double iconSize = 70;
    final int columnCount = (containerWidth / (iconSize + 40)).round();

    return Card(
      color: themeData.primaryColor,
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(40),
      ),
      child: Padding(
        padding: EdgeInsets.all(0),
        child: FractionallySizedBox(
          alignment: Alignment.center,
          heightFactor: 0.5,
          widthFactor: 0.8,
          child: GridView.count(
              physics: BouncingScrollPhysics(),
              crossAxisCount: columnCount,
              children: iconList.map((e) {
                return GestureDetector(
                  onTap: () => iconPressed(e),
                  child: Icon(
                    e,
                    size: iconSize,
                    shadows: icon == e
                        ? [Shadow(color: Colors.white, blurRadius: 20)]
                        : [],
                  ),
                );
              }).toList()),
        ),
      ),
    );
  }
}
