import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:password_safe/theme.dart';
import 'package:password_safe/presentation/passwords/globals.dart' as globals;

class SearchAnimatedOpacity extends StatelessWidget {
  SearchAnimatedOpacity({
    Key? key,
    required bool searchFieldVisible,
    required this.borderSide,
    required this.tagIconSize,
  })  : _searchFieldVisible = searchFieldVisible,
        super(key: key);

  final bool _searchFieldVisible;
  final BorderSide borderSide;
  final double tagIconSize;
  final TextEditingController searchController =
      TextEditingController(text: globals.searchQuery.value);

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
        child: FractionallySizedBox(
          widthFactor: 0.9,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 8),
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
                  cursorColor: Theme.of(context).colorScheme.secondary,
                  controller: searchController,
                  enabled: _searchFieldVisible,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Suche...',
                  ),
                  style: TextStyle(fontSize: 20),
                  onChanged: (value) {
                    globals.searchQuery.value = value;
                    globals.filterTag.value = 0;
                  },
                ),
              ),
              IconButton(
                onPressed: () {
                  searchController.text = '';
                  globals.searchQuery.value = '';
                },
                icon: Icon(
                  CommunityMaterialIcons.close_thick,
                  size: tagIconSize,
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
