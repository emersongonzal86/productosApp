import 'package:flutter/material.dart';
import 'package:productos_app/services/services.dart';

import 'package:provider/provider.dart';

import 'package:productos_app/ui/input_decorations.dart';
import 'package:productos_app/providers/login_form_provider.dart';
import 'package:productos_app/widgets/widgets.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: AuthBackground(
            child: SingleChildScrollView(
                child: Column(
      children: [
        const SizedBox(height: 250),
        CardContainer(
          child: Column(children: [
            const SizedBox(height: 10),
            Text(
              'Login',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 30),
            ChangeNotifierProvider(
                create: (_) => LoginFormProvider(), child: _LoginForm())
          ]),
        ),
        SizedBox(height: 50),
        TextButton(
          onPressed: () => Navigator.pushReplacementNamed(context, 'register'),
          style: ButtonStyle(
              overlayColor:
                  MaterialStateProperty.all(Colors.indigo.withOpacity(0.1)),
              shape: MaterialStateProperty.all(StadiumBorder())),
          child: Text(
            'Crear nueva cuenta',
            style: TextStyle(fontSize: 18,  color:Colors.black87),
          ),
        ),
        SizedBox(height: 50),
      ],
    ))));
  }
}

class _LoginForm extends StatelessWidget {
  const _LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    final loginForm = Provider.of<LoginFormProvider>(context);

    return Container(
      child: Form(
        //TODO: mantener la referencia al KEY

        key: loginForm.formKey,

        autovalidateMode: AutovalidateMode.onUserInteraction,

        child: Column(
          children: [
            TextFormField(
              autocorrect: false,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecorations.authInputDecoration(
                  hintText: 'jhon.doe@gmail.com',
                  labelText: 'Correo electrónico',
                  prefixIcon: Icons.alternate_email_sharp),
              onChanged: (value) => loginForm.email = value,
              validator: (value) {
                String pattern =
                    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                RegExp regExp = new RegExp(pattern);
                return regExp.hasMatch(value ?? '')
                    ? null
                    : 'Correo electrónico no válido';
              },
            ),
            SizedBox(height: 30),
            TextFormField(
              autocorrect: false,
              obscureText: true,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecorations.authInputDecoration(
                  hintText: '*******',
                  labelText: 'Contraseña',
                  prefixIcon: Icons.lock_outlined),
              onChanged: (value) => loginForm.password = value,
              validator: (value) {
                return (value != null && value.length >= 6)
                    ? null
                    : 'La contraseña debe tener al menos 6 caracteres';
              },
            ),
            SizedBox(height: 30),
            MaterialButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              disabledColor: Colors.grey,
              elevation: 0,
              color: Colors.deepPurple,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                child: Text(loginForm.isLoading ? 'Cargando...' : 'Ingresar',
                    style: TextStyle(color: Colors.white)),
              ),

              //para desactivar el boton el onPressed debe ser null
              onPressed: loginForm.isLoading
                  ? null
                  : () async {
                      //oculta el teclado
                    FocusScope.of(context).unfocus();
                      final authService =
                          Provider.of<AuthService>(context, listen: false);

                      if (!loginForm.isValidForm()) return;

                      loginForm.isLoading = true;

                      //await Future.delayed(Duration(seconds: 2));

                      //TODO: validar si el login es correcto

                      final String? errorMessage = await authService.login(
                          loginForm.email, loginForm.password);

                      if (errorMessage == null) {
                        Navigator.pushReplacementNamed(context, 'home');
                      } else {
                        //TODO: Mostrar error en pantalla

                        print(errorMessage);
                        loginForm.isLoading = false;
                      }
                    },
            )
          ],
        ),
      ),
    );
  }
}
