import 'package:flutter/material.dart';



class qrpage extends StatelessWidget {
  const qrpage ({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material app',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('NOVASPORT'),
          backgroundColor: Colors.yellow,
          
        ),
        
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
             const Text(
                'QR GENERADO',
                  style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold,  fontStyle: FontStyle.italic,
                  ),
                ),
              SizedBox(
                height: 250,
                width: 250,
                child: Image.network(
                  'http://t3.gstatic.com/licensed-image?q=tbn:ANd9GcSh-wrQu254qFaRcoYktJ5QmUhmuUedlbeMaQeaozAVD4lh4ICsGdBNubZ8UlMvWjKC'
                )
              ),
               const Text(
                '¡Tiene 24 hrs para realizar el pago en el oxxo mas cercano!',
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                    fontSize: 15.0, 
                    color: Colors.black
                  ),
                  
                ),
                 ElevatedButton(
                onPressed: () {
                  print("Button pressed");
                   borderRadius: BorderRadius.circular(25.0);
                },
                style: TextButton.styleFrom(
                  primary: Color.fromARGB(255, 0, 0, 0),
                  backgroundColor:  Colors.yellow),
                  child: const Text("OK")
              ),
            ],
          )
        ),
      ),
    );
  }
}
