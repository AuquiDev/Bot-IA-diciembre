import "../helpers/exports.dart";
//MODEL FOR TEXT FIELD
SizedBox getTextfieldModel(TextEditingController controller, String hintText,
    bool obscure, TextInputType? type) {
  return SizedBox(
    width: double.infinity,
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: controller,
        obscureText: obscure,
        keyboardType: type,
        decoration: InputDecoration(hintText: hintText),
      ),
    ),
  );
}
