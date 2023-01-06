// ignore_for_file: constant_identifier_names

enum PageEnum {
  start,
  region_selection,
  terms_of_use,
  terms_of_use_denial,
  first_menu,
  main_menu,
  sub_pay,
  support,
  test,
  start_test,
  empty,
}

/* extension PageEnumExtension on PageEnum { */
/*   String get snakeName => nameF(this); */
/**/
/*   String nameF(PageEnum value) { */
/*     print(value.name); */
/*     final a = RegExp(r'(.+)([A-Z])(.+)').allMatches(value.name); */
/**/
/*     var matchCount = 0; */
/*     for (var match in a) { */
/*       matchCount += 1; */
/*       print('Match $matchCount: ${value.name.substring(match.start, match.end)}'); */
/**/
/*       /* print( */ */
/*       /*     "${match.group(0)}-${match.group(1)?.toLowerCase()}${match.group(2)}"); */ */
/*     } */
/**/
/*     return ""; */
/*   } */
/* } */
