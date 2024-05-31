import 'package:seller_app/const/const.dart';
import 'package:seller_app/widgets/normal_text.dart';

Widget customTextFiled({label, hint, controller, isDesc = false}) {
  return TextFormField(
    style: const TextStyle(color: white),
    controller: controller,
    maxLines: isDesc ? 4 : 1,
    decoration: InputDecoration(
        isDense: true,
        label: normalText(text: label),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(color: white)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(color: white)),
        hintText: hint,
        hintStyle: TextStyle(
          color: lightGrey.withOpacity(.33),
        )),
  );
}

class CustomTextFieldHide extends StatefulWidget {
  final String? label;
  final String? hint;
  final TextEditingController? controller;
  final bool isDesc;

  const CustomTextFieldHide(
      {super.key, this.label, this.hint, this.controller, this.isDesc = false});

  @override
  _CustomTextFieldHideState createState() => _CustomTextFieldHideState();
}

class _CustomTextFieldHideState extends State<CustomTextFieldHide> {
  bool _isObscured = true;

  @override
  void initState() {
    super.initState();
    _isObscured = !widget.isDesc;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: const TextStyle(color: Colors.white),
      controller: widget.controller,
      maxLines: widget.isDesc ? 4 : 1,
      obscureText: !widget.isDesc && _isObscured,
      decoration: InputDecoration(
        isDense: true,
        label: Text(
          widget.label ?? '',
          style: const TextStyle(color: Colors.white),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(color: Colors.white),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(color: Colors.white),
        ),
        hintText: widget.hint,
        hintStyle: TextStyle(color: Colors.grey.withOpacity(.33)),
        suffixIcon: widget.isDesc
            ? null
            : IconButton(
                icon: Icon(
                  _isObscured ? Icons.visibility : Icons.visibility_off,
                  color: Colors.grey,
                ),
                onPressed: () {
                  setState(() {
                    _isObscured = !_isObscured;
                  });
                },
              ),
      ),
    );
  }
}
