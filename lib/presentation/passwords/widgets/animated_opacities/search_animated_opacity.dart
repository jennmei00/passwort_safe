import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:password_safe/theme.dart';

class SearchAnimatedOpacity extends StatelessWidget {
  const SearchAnimatedOpacity({
    Key? key,
    required bool searchFieldVisible,
    required this.filterContainerSizeWidth,
    required this.filterContainerSizeHeight,
    required this.borderSide,
    required this.tagIconSize,
  })  : _searchFieldVisible = searchFieldVisible,
        super(key: key);

  final bool _searchFieldVisible;
  final double filterContainerSizeWidth;
  final double filterContainerSizeHeight;
  final BorderSide borderSide;
  final double tagIconSize;

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: _searchFieldVisible ? 1 : 0,
      duration: Duration(milliseconds: 500),
      child: ClipPath(
        clipper: ShapeBorderClipper(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
        ),
        child: Container(
          width: filterContainerSizeWidth,
          height: filterContainerSizeHeight,
          decoration: BoxDecoration(
            gradient: AppTheme.searchContainerBackgroundGradient,
            border: Border(
              bottom: borderSide,
              top: borderSide,
              left: borderSide,
            ),
          ),
          child: Row(children: [
            Expanded(
              child: TextFormField(
                enabled: _searchFieldVisible,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  label: Text('Search ...'),
                ),
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(
                CommunityMaterialIcons.close_thick,
                size: tagIconSize,
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
