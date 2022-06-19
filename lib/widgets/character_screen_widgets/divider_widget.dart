import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../presentation/color_manager.dart';

class DividerWidget extends StatelessWidget {
  const DividerWidget({Key? key, required this.color}) : super(key: key);
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Divider(
                                    thickness: 1,
                                    color: ColorManager.black,
                                    indent: 0,
                                    endIndent: 0,
                                    height: 0,
                                  );
  }
}