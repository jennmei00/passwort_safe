library passwort_safe.globals;

import 'package:flutter/cupertino.dart';

//*query for the search
ValueNotifier<String> searchQuery = ValueNotifier('');

//* filterTag
//* 0: no filter
//* 1: heart tag
//* 2: mail tag
//* 3: web tag
ValueNotifier<int> filterTag = ValueNotifier(0);

int passwordLength = 0;
int showPasswordLength = 0;