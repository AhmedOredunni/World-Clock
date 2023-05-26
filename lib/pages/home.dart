import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  Map data = {};

  @override
  Widget build(BuildContext context) {

    // Get the arguments passed to the route
    data = data.isNotEmpty ? data : ModalRoute.of(context)!.settings.arguments as Map;
    print(data);

    //set background
    String bgImage = data['isDayTime'] ? 'day.png' : 'night.png';
    Color? bgColor;
    if (data['isDayTime']) {
      bgColor = Colors.blue;
    } else {
      bgColor = Colors.indigo[700];
    }
    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/$bgImage'),
              fit: BoxFit.cover
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 120.0, 0, 0),
            child: Column(
              children: [
                ElevatedButton.icon(
                    onPressed: () async {
                      dynamic result = await Navigator.pushNamed(context, '/location');
                      setState(() {
                        data = {
                          'time': result['time'],
                          'location': result['location'],
                          'isDayTime': result['isDayTime'],
                          'flag':result['flag']
                        };
                      });
                    },
                    icon: const Icon(
                      Icons.edit_location
                    ),
                    label: const Text('Edit Location')
                ),
                const SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                        data['location'],
                      style: const TextStyle(
                        fontSize: 28.0,
                        letterSpacing: 2.0,
                        color: Colors.white
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20,),
                Text(
                  data['time'],
                  style: const TextStyle(
                    fontSize: 66.0,
                    color: Colors.white
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
