import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:password_safe/theme.dart';

class FilterAnimatedOpacity extends StatelessWidget {
  const FilterAnimatedOpacity({
    Key? key,
    required bool filterVisible,
    required this.borderSide,
    required this.tagIconSize,
  })  : _filterVisible = filterVisible,
        super(key: key);

  final bool _filterVisible;
  final BorderSide borderSide;
  final double tagIconSize;

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: _filterVisible ? 1 : 0,
      duration: Duration(milliseconds: 500),
      child: ClipPath(
        clipper: ShapeBorderClipper(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
        ),
        child: FractionallySizedBox(
          widthFactor: 0.9,
          child: Container(
            
            decoration: BoxDecoration(
              gradient: AppTheme.filterContainerBackgroundGradient,
              border: Border(
                bottom: borderSide,
                top: borderSide,
                right: borderSide,
              ),
            ),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    onPressed: !_filterVisible ? null : () {},
                    iconSize: tagIconSize,
                    color: HexColor('#AE2323'),
                    icon: Icon(
                      CommunityMaterialIcons.heart,
                      shadows: [
                        Shadow(color: HexColor('#AE2323'), blurRadius: 30)
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: !_filterVisible ? null : () {},
                    iconSize: tagIconSize,
                    color: HexColor('#BBAD66'),
                    icon: Icon(
                      CommunityMaterialIcons.email,
                      // shadows: [
                      //   Shadow(color: HexColor('#BBAD66'), blurRadius: 30)
                      // ],
                    ),
                  ),
                  IconButton(
                    onPressed: !_filterVisible ? null : () {},
                    iconSize: tagIconSize,
                    color: HexColor('#3555A8'),
                    icon: Icon(
                      CommunityMaterialIcons.web,
                      // shadows: [
                      //   Shadow(color: HexColor('#3555A8'), blurRadius: 30)
                      // ],
                    ),
                  ),
                  IconButton(
                    onPressed: !_filterVisible ? null : () {},
                    iconSize: tagIconSize,
                    color: HexColor('#FFFFFF'),
                    icon: Icon(
                      CommunityMaterialIcons.close_thick,
                    ),
                  ),
                ]),
          ),
        ),
      ),
    );
  }
}
