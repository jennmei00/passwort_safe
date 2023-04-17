import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';

class IconContainerCard extends StatelessWidget {
  final IconData icon;
  final Function iconPressed;
  final List<IconData> socialMediaIconList = [
    CommunityMaterialIcons.netflix,
    CommunityMaterialIcons.spotify,
    CommunityMaterialIcons.instagram,
    CommunityMaterialIcons.facebook,
    CommunityMaterialIcons.snapchat,
    CommunityMaterialIcons.twitter,
    CommunityMaterialIcons.youtube,
  ];

  final List<IconData> shoppingIconList = [
    CommunityMaterialIcons.amazon,
    CommunityMaterialIcons.shopping,
    CommunityMaterialIcons.purse,
  ];

  final List<IconData> bankingIconList = [
    CommunityMaterialIcons.cash,
    CommunityMaterialIcons.bank,
    CommunityMaterialIcons.piggy_bank,
    CommunityMaterialIcons.account_cash,
    CommunityMaterialIcons.credit_card,
  ];

  final List<IconData> othersIconList = [
    CommunityMaterialIcons.email,
    CommunityMaterialIcons.web,
    CommunityMaterialIcons.school,
    CommunityMaterialIcons.laptop,
    CommunityMaterialIcons.bag_suitcase,
    CommunityMaterialIcons.airplane,
    CommunityMaterialIcons.run,
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
    final double iconSize = 50;
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
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10),
                Text(
                  '       Soziale Medien',
                  style: TextStyle(fontSize: 16),
                ),
                Divider(
                  thickness: 2,
                  endIndent: 30,
                  indent: 30,
                ),
                GridView.count(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    crossAxisCount: columnCount,
                    children: socialMediaIconList.map((e) {
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
                SizedBox(height: 10),
                Text(
                  '       Shopping',
                  style: TextStyle(fontSize: 16),
                ),
                Divider(
                  thickness: 2,
                  endIndent: 30,
                  indent: 30,
                ),
                GridView.count(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    crossAxisCount: columnCount,
                    children: shoppingIconList.map((e) {
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
                SizedBox(height: 10),
                Text(
                  '       Banking',
                  style: TextStyle(fontSize: 16),
                ),
                Divider(
                  thickness: 2,
                  endIndent: 30,
                  indent: 30,
                ),
                GridView.count(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    crossAxisCount: columnCount,
                    children: bankingIconList.map((e) {
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
                SizedBox(height: 10),
                Text(
                  '       Sonstiges',
                  style: TextStyle(fontSize: 16),
                ),
                Divider(
                  thickness: 2,
                  endIndent: 30,
                  indent: 30,
                ),
                GridView.count(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    crossAxisCount: columnCount,
                    children: othersIconList.map((e) {
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
