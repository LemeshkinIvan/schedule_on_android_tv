import 'package:flutter/cupertino.dart';

abstract class Modal {
  void buildModal(BuildContext context);

  Widget buildContent(BuildContext context);
}
