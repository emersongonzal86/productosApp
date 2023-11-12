import 'package:flutter/material.dart';
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
            _LoginForm()
          ]),
        ),
        SizedBox(height: 50),
        Text(
          'Crear nueva cuenta',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        )
      ],
    ))));
  }
}

class _LoginForm extends StatelessWidget {
  const _LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Form(
        //TODO: mantener la referencia al KEY
        child: Column(
          children: [
            TextFormField(
              autocorrect: false,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.deepPurple),
                  ),
                  focusedBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.deepPurple, width: 2)),
                  hintText: 'jhon.doe@gmail.com',
                  labelText: 'Correo electrónico',
                  labelStyle: TextStyle(color: Colors.grey),
                  prefixIcon: Icon(Icons.alternate_email_sharp,
                      color: Colors.deepPurple)),
            )
          ],
        ),
      ),
    );
  }
}
