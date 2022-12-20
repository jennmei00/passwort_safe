library passwort_safe.globals;

import 'package:flutter/cupertino.dart';

///query for the search
// String? searchQuery;
ValueNotifier<String> searchQuery = ValueNotifier('');

///filterTag
///0: no filter
///1: heart tag
///2: mail tag
///3: web tag
// int? filterTag;
ValueNotifier<int> filterTag = ValueNotifier(0);

// Color getColorOfTag(Icon icon) {
//   return Color(2);
// }
