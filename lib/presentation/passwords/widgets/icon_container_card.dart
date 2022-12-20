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
    final themeData = Theme.of(context);
    final double containerHeight = 220;
    final double containerWidth = 500;
    final double iconSize = 70;
    double mediaWidth = MediaQuery.of(context).size.width;
    int columnCount = (containerWidth / (iconSize + 40)).round();

    return Card(
      color: themeData.primaryColor,
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(40),
      ),
      // child: Text('Test'),
      // child: Column(
      //   children: iconList
      //       .map((e) => Icon(
      //             e,
      //             size: iconSize,
      //           ))
      //       .toList(),
      // ),
      child: Padding(
        padding: EdgeInsets.all(20),
        child: ConstrainedBox(
          constraints: new BoxConstraints(
            minHeight: containerHeight,
            minWidth: containerWidth,
            maxHeight: containerHeight + 20,
            maxWidth: containerWidth + 20,
          ),

          // height: containerHeight,
          // width: containerWidth,
          child: GridView.count(
              crossAxisCount: columnCount,
              childAspectRatio: (containerWidth / containerHeight),
              mainAxisSpacing: 50,
              crossAxisSpacing: 20,
              // crossAxisCount: 3,
              // crossAxisSpacing: 10,
              children: iconList.map((e) {
                return GestureDetector(
                  onTap: () => iconPressed(e),
                  // iconSize: iconSize,
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
