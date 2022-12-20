import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:password_safe/presentation/passwords/widgets/animated_opacities/filter_animated_opacity.dart';
import 'package:password_safe/presentation/passwords/widgets/animated_opacities/search_animated_opacity.dart';
import 'package:password_safe/presentation/passwords/globals.dart' as globals;

class FilterSearchLine extends StatefulWidget {
  const FilterSearchLine({
    Key? key,
  }) : super(key: key);

  @override
  State<FilterSearchLine> createState() => _FilterSearchLineState();
}

class _FilterSearchLineState extends State<FilterSearchLine> {
  final double containerSize = 50;
  final double iconSize = 50;
  final double tagIconSize = 30;
  final double filterContainerSizeWidth = 190;
  final double filterContainerSizeHeight = 50;
  final BorderSide borderSide = BorderSide(color: Colors.white, width: 2);

  bool _searchFieldVisible = false;
  bool _filterVisible = false;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    print(_searchFieldVisible);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        IconButton(
          padding: EdgeInsets.all(0),
          onPressed: () {
            setState(() {
              _filterVisible = !_filterVisible;
              if (_filterVisible) {
                _searchFieldVisible = false;
              }
            });
          },
          iconSize: iconSize,
          icon: Icon(
            _filterVisible
                ? CommunityMaterialIcons.filter
                : CommunityMaterialIcons.filter_outline,
          ),
        ),
        Expanded(
            child: Stack(
          alignment: Alignment.center,
          children: _searchFieldVisible
              ? [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: FilterAnimatedOpacity(
                        filterVisible: _filterVisible,
                        borderSide: borderSide,
                        tagIconSize: tagIconSize),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: SearchAnimatedOpacity(
                        searchFieldVisible: _searchFieldVisible,
                        borderSide: borderSide,
                        tagIconSize: tagIconSize),
                  ),
                ]
              : [
                  Align(
                    alignment: Alignment.centerRight,
                    child: SearchAnimatedOpacity(
                        searchFieldVisible: _searchFieldVisible,
                        borderSide: borderSide,
                        tagIconSize: tagIconSize),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: FilterAnimatedOpacity(
                        filterVisible: _filterVisible,
                        borderSide: borderSide,
                        tagIconSize: tagIconSize),
                  ),
                ],
        )),
        IconButton(
          padding: EdgeInsets.all(0),
          onPressed: () {
            setState(() {
              _searchFieldVisible = !_searchFieldVisible;
              if (_searchFieldVisible) {
                _filterVisible = false;
              }
            });
          },
          iconSize: iconSize,
          icon: Icon(
            CommunityMaterialIcons.magnify,
          ),
        ),
      ],
    );
  }
}
