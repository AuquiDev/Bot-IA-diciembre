import '../helpers/exports.dart';

getRoutes() {
  String routeLogin = "/login";
  String routeRegister = "/register";
  String routePrincipal = "/principal";

  return {
    routeLogin: (context) => LoginPage(),
    routeRegister: (context) => RegisterPage(),
    routePrincipal: (context) => PrincipalPage()
  };
}
