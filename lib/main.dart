import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(


      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<FirebaseApp>  _initializeFirebase() async
  {
    FirebaseApp firebaseApp = await Firebase.initializeApp();
    return firebaseApp;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _initializeFirebase(),
        builder: (context , snapshot)
          {
            if (snapshot.connectionState == ConnectionState.done){
              return LoginScreen();
            }
            return  Center(
              child: CircularProgressIndicator(),
            );
          },

      ),
    );
  }
}
class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  Future<User?> loginUsingEmailPassword({ required String email,required String password, required BuildContext context  }) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    try {
      UserCredential userCredential =  await auth.signInWithEmailAndPassword(email: email, password: password);
      user = userCredential.user;
    } on FirebaseAuthException catch(e) {
      if (e.code == "user-not-found") {
        print("No user Found for that email");
        Fluttertoast.showToast(msg: "Invalid email or password",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM
        );
      }
    }

    return user;
  }

 var _emailController = TextEditingController();
  var _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return   Padding(
        padding: EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Gujjar Automobiles',
            style: TextStyle(
              color: Colors.black,
              fontSize: 28.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'Welcome ',
            style: TextStyle(
              color: Colors.black,
              fontSize: 44.0,
              fontWeight: FontWeight.bold,
            ),
          ),

          SizedBox(
            height: 44.0,

          ),

          TextField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              hintText: 'Enter Your Email',
              prefixIcon: Icon(Icons.mail, color: Colors.black,)

            ),
          ),

          SizedBox(
            height: 26.0,
          ),

          TextField(
            controller: _passwordController,
           obscureText: true,
            decoration: InputDecoration(
                hintText: 'Enter Your Password',
                prefixIcon: Icon(Icons.lock, color: Colors.black,)

            ),
          ),

          SizedBox(
            height: 12.0,
          ),

          Text(
            "Don't Remember Your Password?",
            style: TextStyle(
              color: Colors.blue,
            ),
          ),
         SizedBox(
           height: 88.0,
         ),

          Container(
            width: double.infinity,
            child: RawMaterialButton(
              fillColor: Color(0xff0069fe),
                elevation: 0.0,
                padding: EdgeInsets.symmetric(vertical: 20.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                onPressed: () async {
                User? user = await loginUsingEmailPassword(email: _emailController.text, password: _passwordController.text, context: context);

                print(user);

                if (user != null){
                   Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => HomeScreen()));
                }
                else
                  {
                Fluttertoast.showToast(msg: "Invalid email or password",
                toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM
                    );
                  }


                },
            child: Text('Login',
            style: TextStyle(fontSize: 18.0,
            color: Colors.white),),),

          ),

        ],
      ),



    );
  }
}

// class ProfileScreen extends StatefulWidget {
//   const ProfileScreen({Key? key}) : super(key: key);
//
//   @override
//   State<ProfileScreen> createState() => _ProfileScreenState();
// }
//
// class _ProfileScreenState extends State<ProfileScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Text("Hi"),
//       ),
//     );
//   }
// }

class HomeScreen extends StatelessWidget {
  final List<String> carBrands = [    'Lamborghini',    'Ferrari' ,'Bugatti' , 'Koenigsegg' , 'Pagani' ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Car Brands'),
      ),
      body: Container(
        child: ListView.builder(
          itemCount: carBrands.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(carBrands[index]),
              onTap: () {
                if (index == 0) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          Lamborghini(),
                    ),
                  );
                }
                else if(index==1){
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          Ferrari(),
                    ),
                  );
                }
                else if(index==2){
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>Bugatti(),
                    ),
                  );
                }
                else if(index==3){
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>Koenigsegg(),
                    ),
                  );
                }
                else if(index==4){
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>Pagani(),
                    ),
                  );
                }
              },
            );
          },
        ),
      ),
    );
  }
}

class Lamborghini extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cars Dealership'),
      ),
      body: ListView(
        children: [
          CarItem(
            name: 'Lamborghini Veneno',
            image: 'assets/car1.jpeg',
            price: '\$10,000,000',
            details: 'Engine => 6.5L V12, 60°, MPI'
                'Power output => 769 horsepower'
                'Transmission => automatic-manual hybrid',
          ),
          CarItem(
            name: 'Lamorghini Aventador',
            image: 'assets/car2.jpeg',
            price: '\$700,000',
            details: 'Engine => 6.5L V12, 60°, MPI'
                'Power output => 769 horsepower'
                'Transmission => automatic-manual hybrid',
          ),
          CarItem(
            name: 'Lamborghini Huracan',
            image: 'assets/car3.jpeg',
            price: '\$350,000',
            details: 'Engine => 5.0 L V10, 90°, MP'
                'Power output => 602 hp'
                'Transmission => 7-speed dual clutch transmission',
          ),
        ],
      ),
    );
  }
}
class Ferrari extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cars Dealership'),
      ),
      body: ListView(
        children: [
          CarItem(
            name: 'Ferrari 458',
            image: 'assets/car4.jpeg',
            price: '\$500,000',
            details: 'Engine => 4.5 L Ferrari F136 F V8'
                'Power output =>  562 hp at 9,000 RPM'
                'Transmission => 7-speed dual-clutch automatic',
          ),
          CarItem(
            name: 'Ferrari F40',
            image: 'assets/car5.jpeg',
            price: '\$4,000,000',
            details: 'Engine => 2.9L twin-turbo V8'
                'Power output => 471 hp and 426 lb-ft of torque.'
                'Transmission => Manual transmission',
          ),
          CarItem(
            name: 'Ferrari LaFerrari',
            image: 'assets/car6.jpeg',
            price: '\$7,000,000',
            details: 'Engine => 6.3 L F140 FE V12'
                'Power output => 708 kW (950 hp; 963 PS)'
                'Transmission => 7-speed dual-clutch automatic',

          ),
        ],
      ),
    );
  }
}

class Bugatti extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cars Dealership'),
      ),
      body: ListView(
        children: [
          CarItem(
            name: 'Bugatti Veyron',
            image: 'assets/car7.jpeg',
            price: '\$1,500,000',
            details: 'Engine => 8-liter W16 engine'
                'Power output => 736 kW (987 hp; 1,001 PS), and generates 1,250 N⋅m (922 lbf⋅ft) of torque.'
                'Transmission => 7-speed dual-clutch gearbox',
          ),
          CarItem(
            name: 'Bugatti Chiron',
            image: 'assets/car8.jpeg',
            price: '\$4,000,000',
            details: 'Engine => quad-turbocharged 8 l W16'
                'Power output => 1,500 hp'
                'Transmission => 7-speed dual-clutch automatic',
          ),
          CarItem(
            name: 'Bugatti LaVoitureDeNoire',
            image: 'assets/car9.jpeg',
            price: '\$7,000,000',
            details: 'Engine => 8.0L Quad Turbocharged W16'
                'Power output => 1,500 hp'
                'Transmission => 7-speed dual-clutch automatic',

          ),
        ],
      ),
    );
  }
}

class Koenigsegg extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cars Dealership'),
      ),
      body: ListView(
        children: [
          CarItem(
            name: 'Koenigsegg Agera',
            image: 'assets/car10.jpeg',
            price: '\$2,500,000',
            details: 'Engine => 5.0 L V8'
                'Power Output => 1140 hp at 7100 rpm –  7500 rpm.'
                'Transmission => 7-speed dual-clutch 1 input shaft transmission with paddle-shift Electronic differential',
          ),
          CarItem(
            name: 'Koenigsegg Regera',
            image: 'assets/car11.jpeg',
            price: '\$3,000,000',
            details: 'Engine => 5.0 L twin-turbocharged V8'
                'Power Output => 1,500 hp'
                'Transmission => 7-speed dual-clutch 1 input shaft transmission with paddle-shift Electronic differential',
          ),
          CarItem(
            name: 'Koenigsegg Jesko',
            image: 'assets/car12.jpeg',
            price: '\$7,000,000',
            details: 'Engine => 5.0 L twin-turbocharged V8'
                'Power Output => 1140 hp at 7100 rpm – redline @ 7500 rpm.'
                'Transmission => 7-speed dual-clutch 1 input shaft transmission with paddle-shift Electronic differential',

          ),
        ],
      ),
    );
  }
}

class Pagani extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cars Dealership'),
      ),
      body: ListView(
        children: [
          CarItem(
            name: 'Pagani Huayra',
            image: 'assets/car13.jpeg',
            price: '\$3,500,000',
            details: 'Engine => 5.980 L (364.9 cu in) twin-turbocharged Mercedes-AMG V12.'
                'Power Output => 864 PS (635 kW; 852 hp).'
                'Transmission => 7-speed Xtrac manual 7-speed Xtrac automated manual.',
          ),
          CarItem(
            name: 'Pagani Zonda',
            image: 'assets/car14.jpeg',
            price: '\$7,000,000',
            details: 'Engine => 5.980 L (364.9 cu in) twin-turbocharged Mercedes-AMG V12.'
                'Power Output => 864 PS (635 kW; 852 hp).'
                'Transmission => 7-speed Xtrac manual 7-speed Xtrac automated manual.',
          ),
          CarItem(
            name: 'Pagani Utopia',
            image: 'assets/car15.jpeg',
            price: '\$5,000,000',
            details: 'Engine => 5.980 L (364.9 cu in) twin-turbocharged Mercedes-AMG V12.'
                'Power Output => 864 PS (635 kW; 852 hp).'
                'Transmission => 7-speed Xtrac manual 7-speed Xtrac automated manual.',

          ),
        ],
      ),
    );
  }
}

class CarItem extends StatelessWidget {
  final String? name;
  final String? image;
  final String? price;
  final String? details;

  CarItem({this.name,this.image,this.price,this.details});


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 150,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(image.toString()),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              name.toString(),
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              price.toString(),
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
          ),
          SizedBox(height: 8),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => CarDetailsPage(
                    name: name,
                    image: image,
                    price: price,
                    details: details,
                  ),
                ),
              );
            },
            child: Text('Details'),
          ),
        ],
      ),
    );
  }
}
class CarDetailsPage extends StatelessWidget {
  final String? name;
  final String? image;
  final String? price;
  final String? details;

  CarDetailsPage({this.name, this.image, this.price,this.details});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(name.toString()),
        ),
        body: Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 200,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(image.toString()),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: 16),
              Text(
                name.toString(),
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                price.toString(),
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Description:',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                details.toString(),
                style: TextStyle(
                  fontSize: 14,
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => CarManufacturingScreen(

                      ),
                    ),
                  );
                },
                child: Text('Addons'),
              ),
            ],
          ),
        )
    );
  }
}


class CarManufacturingScreen extends StatefulWidget {
  @override
  _CarManufacturingScreenState createState() => _CarManufacturingScreenState();
}

class _CarManufacturingScreenState extends State<CarManufacturingScreen> {
  late int _selectedStep = 0;
  int color=0;
  late final List<Step> _steps = [Step(title: Text('Select Car Model'),      content: Container(        height: 100,        child: DropdownButton(          items: [DropdownMenuItem(              child: Text('Model 1'),              value: 1,            ),            DropdownMenuItem(              child: Text('Model 2'),              value: 2,            ),            DropdownMenuItem(              child: Text('Model 3'),              value: 3,            ),          ],
    onChanged: (value) {
      setState(() {
        _selectedStep = value!;
      });
    },
  ),
  ),
  ),
    Step(
      title: Text('Choose Color'),
      content: Container(
        height: 100,
        child: DropdownButton(
          items: [
            DropdownMenuItem(
              child: Text('Red'),
              value: 1,
            ),
            DropdownMenuItem(
              child: Text('Blue'),
              value: 2,
            ),
            DropdownMenuItem(
              child: Text('Green'),
              value: 3,
            ),
          ],
          onChanged: (value) {
            setState(() {
              color = value!;
            });
          },
        ),
      ),
    ),
    Step(
      title: Text('Add Accessories'),
      content: Container(
        height: 200,
        child: Column(
          children: [
            CheckboxListTile(
              value: false,
              title: Text('Sunroof'), onChanged: (bool? value) {
              if(value==true)
              {
                value=false;
              }
              else
              {
                value=true;
              }
            },
            ),
            CheckboxListTile(
              value: false,
              title: Text('Rearview Camera'), onChanged: (bool? value) {  },
            ),
            CheckboxListTile(
              value: false,
              title: Text('Leather Seats'), onChanged: (bool? value) {  },
            ),
          ],
        ),
      ),
    ),
    Step(
      title: Text('Review and Confirm'),
      content: Container(
        height: 100,
        child: Column(
          children: [
            Text('Selected Model: Model $_selectedStep'),
            Text('Selected Color: Color $_selectedStep'),
            Text('Selected Accessories: N/A'),
          ],
        ),
      ),
    ),
  ];
  static const snackBar = SnackBar(
    content: Text('Congratulation! You have successfully placed order '),
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Car Manufacturing'),
      ),
      body: Container(
        child: Stepper(
          currentStep: _selectedStep,
          steps: _steps,
          type: StepperType.vertical,
          onStepContinue: () {
            setState(() {
              if(_selectedStep==3) {
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => HomeScreen(),
                  ),
                );
              }

              else{
                _selectedStep += 1;
              }
            });
          },
          onStepCancel: () {
            setState(() {
              if(_selectedStep==0){
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => HomeScreen(),
                  ),
                );
              }
              else{
                _selectedStep -= 1;
              }
            });
          },
          onStepTapped: (step) {
            setState(() {
              _selectedStep = step;
            });
          },
        ),
      ),
    );
  }
}

