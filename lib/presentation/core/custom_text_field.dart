import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:password_safe/theme.dart';

class CustomTextField extends StatelessWidget {
  final bool enabled;
  final String label;
  final Function? validator;
  final TextEditingController controller;
  const CustomTextField({
    this.enabled = true,
    required this.label,
    this.validator = null,
    required this.controller,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // final themeData = Theme.of(context);
    final double textFieldWidth = 260;
    final double textFieldHeight = 40;
    final double linkIconSize = 30;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Text(label),
          Container(
            height: textFieldHeight,
            // width: textFieldWidth,
            decoration: BoxDecoration(
                gradient: AppTheme.textFieldGradient,
                borderRadius: BorderRadius.all(Radius.circular(20))),
            // child: Row(
            //   children: [
            // if (label == 'VERKNÜPFUNG')
            //   Padding(
            //     padding: const EdgeInsets.only(left: 5.0),
            //     child: Icon(CommunityMaterialIcons.link_variant_plus, size: linkIconSize,),
            //   ),
            // Expanded(
            child: Container(
              // color: Colors.green,
              child: Stack(
                children: [
                  (label == 'VERKNÜPFUNG')
                      ? Container(
                          padding: EdgeInsets.only(left: 2),
                          alignment: Alignment.centerLeft,
                          child: Icon(CommunityMaterialIcons.link_variant_plus),
                        )
                      : SizedBox(),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    child: TextFormField(
                      enabled: enabled,
                      // style: themeData,
                      validator: validator == null
                          ? null
                          : (value) => validator!(value),
                      textAlign: TextAlign.center,
                      controller: controller,

                      decoration: InputDecoration(
                        // suffixIcon: this.enabled
                        //     ? null
                        //     : (label == 'PASSWORT')
                        //         ? Icon(
                        //             CommunityMaterialIcons.eye,
                        //             size: linkIconSize,
                        //           )
                        //         : null,
                        // prefixIcon: (label == 'VERKNÜPFUNG')
                        //     ? Icon(
                        //         CommunityMaterialIcons.link_variant_plus,
                        //         size: linkIconSize,
                        //       )
                        //     : null,
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            //   ),F
            // ],
            // ),
          ),
        ],
      ),
    );
  }
}
