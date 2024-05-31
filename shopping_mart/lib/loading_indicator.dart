import 'package:shopping_mart/consts/consts.dart';

Widget loadingIndicator() {
  return CircularProgressIndicator(
    valueColor: AlwaysStoppedAnimation(redcolor),
  );
}
