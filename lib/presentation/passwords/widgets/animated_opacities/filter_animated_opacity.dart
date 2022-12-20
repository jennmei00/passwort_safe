import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:password_safe/theme.dart';
import 'package:password_safe/presentation/passwords/globals.dart' as globals;

class FilterAnimatedOpacity extends StatefulWidget {
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
  State<FilterAnimatedOpacity> createState() => _FilterAnimatedOpacityState();
}

class _FilterAnimatedOpacityState extends State<FilterAnimatedOpacity> {
  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: widget._filterVisible ? 1 : 0,
      duration: Duration(milliseconds: 500),
      child: ClipPath(
        clipper: ShapeBorderClipper(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
        ),
        child: Container(
          width: 200,
          decoration: BoxDecoration(
            gradient: AppTheme.filterContainerBackgroundGradient,
            border: Border(
              bottom: widget.borderSide,
              top: widget.borderSide,
              right: widget.borderSide,
            ),
          ),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            IconButton(
              onPressed: !widget._filterVisible
                  ? null
                  : () {
                      setState(() {});
                      globals.filterTag.value = 1;
                    },
              iconSize: widget.tagIconSize,
              disabledColor: AppTheme.tagHeartColor,
              color: AppTheme.tagHeartColor,
              icon: Icon(CommunityMaterialIcons.heart, shadows: [
                if (globals.filterTag.value == 1) ...[
                  Shadow(color: HexColor('#AE2323'), blurRadius: 30)
                ],
              ]),
            ),
            IconButton(
              onPressed: !widget._filterVisible
                  ? null
                  : () {
                      setState(() {});
                      globals.filterTag.value = 2;
                    },
              iconSize: widget.tagIconSize,
              disabledColor: AppTheme.tagEmailColor,
              color: AppTheme.tagEmailColor,
              icon: Icon(
                CommunityMaterialIcons.email,
                shadows: [
                  if (globals.filterTag.value == 2) ...[
                    Shadow(color: HexColor('#BBAD66'), blurRadius: 30)
                  ],
                ],
              ),
            ),
            IconButton(
              onPressed: !widget._filterVisible
                  ? null
                  : () {
                      setState(() {});
                      globals.filterTag.value = 3;
                    },
              iconSize: widget.tagIconSize,
              disabledColor: AppTheme.tagWebColor,
              color: AppTheme.tagWebColor,
              icon: Icon(
                CommunityMaterialIcons.web,
                shadows: [
                  if (globals.filterTag.value == 3) ...[
                    Shadow(color: HexColor('#3555A8'), blurRadius: 30)
                  ],
                ],
              ),
            ),
            IconButton(
              onPressed: !widget._filterVisible
                  ? null
                  : () {
                      setState(() {});
                      globals.filterTag.value = 0;
                    },
              iconSize: widget.tagIconSize,
              color: HexColor('#FFFFFF'),
              icon: Icon(
                CommunityMaterialIcons.close_thick,
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
