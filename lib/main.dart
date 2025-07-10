import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: MyProject());
  }
}

class MyProject extends StatelessWidget {
  const MyProject({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Input Tekrar")),
      body: TextFormFieldKullanimi(),
    );
  }
}

class TextFormFieldKullanimi extends StatefulWidget {
  const TextFormFieldKullanimi({super.key});

  @override
  State<TextFormFieldKullanimi> createState() => _TextFormFieldKullanimiState();
}

class _TextFormFieldKullanimiState extends State<TextFormFieldKullanimi> {
  late final String _email, _password, _userName;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          // Valide işlemininin ne zmaan olacagını belirler.
          //autovalidateMode: AutovalidateMode.always, // always her çalışır ve hataları gösterir.
          autovalidateMode: AutovalidateMode.onUserInteraction, // Kullanıcı Form ile etkileşime girdiğinde hataları verir.
          child: Column(
            children: [
              TextFormField(
                onSaved: (newValue) {
                  _userName = newValue!;
                },
                // varsayılan degeri atar
                // initialValue:  "Osman HORASAN",
                decoration: InputDecoration(
                  errorStyle: TextStyle(color: Colors.deepOrangeAccent),
                  labelText: "Kullanıcı Adı",
                  hintText: "Username",
                ),
                validator: (value) {
                  if (value!.isEmpty) return "Kullanıcı adı boş geçilemez";
                  if (value!.length < 4) {
                    return "En az 4 karakter girmelisiniz.";
                  }
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                onSaved: (newValue) {
                  _email = newValue!;
                },
                // varsayılan degeri atar
                // initialValue:  "Osman HORASAN",
                decoration: InputDecoration(
                  errorStyle: TextStyle(color: Colors.deepOrangeAccent),
                  labelText: "Email",
                  hintText: "Email",
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Email Alanı Boş Geçilemez";
                  }
                  if (!EmailValidator.validate(value)) {
                    return "Geçersiz email adresi.";
                  }
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                onSaved: (newValue) {
                  _password = newValue!;
                },
                // varsayılan degeri atar
                // initialValue:  "Osman HORASAN",
                decoration: InputDecoration(
                  errorStyle: TextStyle(color: Colors.deepOrangeAccent),
                  labelText: "Şifre",
                  hintText: "Password",
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Şifre Alanı Boş Geçilemez";
                  }
                  if (value.length < 6) {
                    return "Şifre en az 6 karakter olmalı";
                  }
                },
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  bool _isValidate = _formKey.currentState!.validate();
                  if(_isValidate) {
                    _formKey.currentState!.save();
                    String result = "$_userName\n$_email\n$_password";

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(result))
                    );
                    _formKey.currentState!.reset(); // Save işlemi olduktan sonra formu temizler
                  }
                },
                child: Text("Onayla"),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: BorderSide(width: 1, color: Colors.green.shade200),
                  ),
                  backgroundColor: Colors.lightGreen,
                  foregroundColor: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


/*
class TextFieldWidgetKullanimi extends StatefulWidget {
  const TextFieldWidgetKullanimi({super.key});

  @override
  State<TextFieldWidgetKullanimi> createState() =>
      _TextFieldWidgetKullanimiState();
}

class _TextFieldWidgetKullanimiState extends State<TextFieldWidgetKullanimi> {
  late TextEditingController _emailController;

  late FocusNode _focusNode;

  int maxLineCount = 1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _emailController = TextEditingController(text: "ohorasanlar@gmail.com");  Geçerli bir deger girilmek istenirse
    _emailController = TextEditingController();
    _focusNode = FocusNode();

    _focusNode.addListener(
      () => {
        setState(() {
          maxLineCount = _focusNode.hasFocus ? 3 : 1;
        }),
      },
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    // TODO: implement dispose
    super.dispose(); // Burada daima en sonda olmalı çünkü kapanışı yapıyor.
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(18.0),
          child: TextField(
            focusNode: _focusNode,
            //Açılacak olan klavye türü
            keyboardType: TextInputType.emailAddress,

            //Klavyedeki(Android) ana butonunun ne olacağı
            textInputAction: TextInputAction.done,

            //Seçili gelme olayı
            //autofocus: true,
            //Satır sayısı
            maxLines: maxLineCount,
            //maxLines: 5,
            //Girilecek karakter sayısı (TC)
            //maxLength: 11,
            //İmleç rengi
            cursorColor: Colors.red,
            decoration: InputDecoration(
              //Kayan bilgi yazısı
              labelText: "Username",
              //İpucu
              hintText: "Kullanıcı adınızı giriniz",
              icon: Icon(Icons.add),
              //Sol tarafa eklenen icon
              prefix: Icon(Icons.person),
              //Sağ taraf iconu
              suffixIcon: Icon(Icons.cancel),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              //Arka plan rengi verme izni
              filled: true,
              fillColor: Colors.green.shade300,
            ),
            //Klavye ile yapılan her değişikliği algılar
            onChanged: (String gelenDeger) {},
            //Klavyedeki done tuşuna basınca çalışır ya da fiel dan çıkınca
            onSubmitted: (String gelenDeger) {},
          ),
        ),
        TextField(),
      ],
    );
  }
}

*/