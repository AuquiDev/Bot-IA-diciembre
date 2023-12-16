import '../helpers/exports.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              Text(
                "Flutter AI, Register",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              getTextfieldModel(
                  _controllerEmail, "Email", false, TextInputType.emailAddress),
              getTextfieldModel(_controllerPassword, "Password", true, null),
              OutlinedButton(
                  onPressed: () async {
                    Navigator.pop(context);
                  },
                  child: Text("Si ya tienes una cuenta, Ingresa")),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.greenAccent),
                  onPressed: () async {
                    getLoadingModal(context);
                    //ACTION
                    List response = await RegisterControllers()
                        .register(_controllerEmail, _controllerPassword);
                    Navigator.pop(context);

                    if (response[0]) {
                      Navigator.pushNamed(context, "/principal");
                    } else {
                      QuickAlert.show(
                          context: context,
                          type: QuickAlertType.error,
                          text: response[1]);
                    }
                  },
                  child: Text(
                    "Registrate",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ))
            ],
          ),
        ),
      )),
    );
  }
}
