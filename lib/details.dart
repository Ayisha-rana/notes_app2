import 'package:flutter/material.dart';
class Details extends StatelessWidget {
  const Details({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffF6ECC9),
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        },
            icon: Icon(Icons.arrow_back_ios)),
        actions: [
          IconButton(onPressed: (){},
              icon: Icon(Icons.edit)),
          SizedBox(width: 7,),
          IconButton(onPressed: (){},
              icon: Icon(Icons.delete),color: Colors.redAccent,)
        ],
      ),
      backgroundColor: Color(0xffF6ECC9),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Container(

              height: 250,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.white54

              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.asset(
                  'assets/images/musicz.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 45,),
            Align(alignment: Alignment.centerLeft,
                child: Text('Title',style:TextStyle(fontSize: 19),)),
            SizedBox(height: 30,),
        Align(alignment: Alignment.centerLeft,
          child: Text('Description',style:TextStyle(fontSize: 16,color:Colors.grey) ),),
          ],
        ),
      ),
    );
  }
}
