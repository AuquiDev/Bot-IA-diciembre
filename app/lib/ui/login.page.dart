import '../helpers/exports.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
                "Flutter AI Assistant",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              getTextfieldModel(
                  _controllerEmail, "Email", false, TextInputType.emailAddress),
              getTextfieldModel(_controllerPassword, "Password", true, null),
              OutlinedButton(
                  onPressed: () async {
                    Navigator.pushNamed(context, "/register");
                  },
                  child: Text("Si no tienes una cuenta, Registrate")),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.greenAccent),
                  onPressed: () async {
                    getLoadingModal(context);
                    //ACTION
                    var response = await LoginControllers()
                        .login(_controllerEmail, _controllerPassword);
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
                    "Ingresar",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ))
            ],
          ),
        ),
      )),
    );
  }
}
