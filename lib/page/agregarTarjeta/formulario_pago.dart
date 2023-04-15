import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';


class FormCard extends StatefulWidget {
  const FormCard({Key? key}) : super(key: key);

  @override
  _FormCardState createState () => _FormCardState();
  
}

class _FormCardState extends State<FormCard> {
  var cardMask = MaskTextInputFormatter(mask: '#### #### #### ####', filter: { "#": RegExp(r'[0-9]') });
  var dateMask = MaskTextInputFormatter(mask: '##/##', filter: { "#": RegExp(r'[0-9]') });
  var codeMask = MaskTextInputFormatter(mask: '###', filter: { "#": RegExp(r'[0-9]') });


  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      
      child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,        
          children: [
          const Text(
                'INGRESE SUS DATOS',
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold,fontStyle: FontStyle.italic,
                  ),
                ),
                
          Image.network(
            'https://d31dn7nfpuwjnm.cloudfront.net/images/valoraciones/0034/7801/diferencia-tarjeta-credito-debito.png?1565359275'
            ),
      const SizedBox(
        height: 30),
        _inputNombre(),
        const SizedBox(
          height: 30
          ),
        _inputCard(),
        const SizedBox(
          height: 30
          ),
        Row(
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.5,
              child: _inputDate(),
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.5, 
              child: _inputCode(),
            ),           
          ],
        ),
        Container(
          margin: const EdgeInsets.all(15),
          width: MediaQuery.of(context).size.width - 30,
          child: ElevatedButton(onPressed: () {},                   style: TextButton.styleFrom(
            primary: Color.fromARGB(255, 0, 0, 0),
            backgroundColor: Colors.yellow), child: const Text("PAGAR")
            )
          )
        ],
      ),
    );
  }

  Container _inputNombre() {
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color:  Colors.grey)),
        padding: const EdgeInsets.symmetric(horizontal: 15),
        margin: const EdgeInsets.symmetric(horizontal:  15),
        child: TextFormField(
          style: const TextStyle(fontSize: 20),
          decoration: const InputDecoration(
            hintText: "Su Nombre",
            border: InputBorder.none
          ),
        )
      );
    }

    Container _inputCard() {
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color:  Colors.grey)),
        padding: const EdgeInsets.symmetric(horizontal: 15),
        margin: const EdgeInsets.symmetric(horizontal:  15),
        child: TextFormField(
          inputFormatters: [cardMask],
          keyboardType: TextInputType.number,
          style: const TextStyle(fontSize: 20),
          decoration: const InputDecoration(
            hintText: "0000 0000 0000 0000",
            border: InputBorder.none
          ),
        )
      );
    }

      Container _inputDate() {
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color:  Colors.grey)),
        padding: const EdgeInsets.symmetric(horizontal: 15),
        margin: const EdgeInsets.symmetric(horizontal:  15),
        child: TextFormField(
          keyboardType: TextInputType.number,
          inputFormatters: [dateMask],
          style: const TextStyle(fontSize: 20),
          decoration: const InputDecoration(
            hintText: "01/24",
            border: InputBorder.none
          ),
        )
      );
    }

      Container _inputCode() {
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color:  Colors.grey)),
        padding: const EdgeInsets.symmetric(horizontal: 15),
        margin: const EdgeInsets.symmetric(horizontal:  15),
        child: TextFormField(
          keyboardType: TextInputType.number,
          inputFormatters: [codeMask],
          style: const TextStyle(fontSize: 20),
          decoration: const InputDecoration(
            hintText: "000",
            border: InputBorder.none
          ),
        )
     );
  }
}