import 'package:flutter/material.dart';
import 'dataClasses.dart';

class ItemAdder extends StatefulWidget{
  List<Category> categories;
  late Function addItem;

  ItemAdder({super.key, required this.categories, required this.addItem});

  @override
  State<ItemAdder> createState() => _ItemAdderState();
}

class _ItemAdderState extends State<ItemAdder> {
  double sizeBox = 15;
  late TextEditingController controller;
  late TextEditingController controller2;
  Category? _value;
  String name = 'Unknown task';
  String description = 'No description provided';
  Category category = Category(title: 'Home', color: Colors.greenAccent);

  @override
  void initState(){
    super.initState();
    controller = TextEditingController();
    controller2 = TextEditingController();
  }

  @override
  void dispose(){
    controller.dispose();
    controller2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context){

    return Center(
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.black87,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: Colors.white, // Border color
            width: 2.0, // Border width
          ),),
        width: MediaQuery.of(context).size.width * 0.7,
        height: MediaQuery.of(context).size.height * 0.5,

        child: ListView(
          children: [
            const Text('Name:',
                style: TextStyle(fontSize: 25, color: Colors.white, decoration: TextDecoration.none, fontFamily: 'Roboto',)),
            //SizedBox(height: sizeBox),
            /*const Text('Category:',
                  style: TextStyle(fontSize: 20, color: Colors.white, decoration: TextDecoration.none, fontFamily: 'Roboto', fontWeight: FontWeight.normal)),*/
            SizedBox(height: sizeBox),
            Card(
              color: Colors.black87,
              child: TextField(
                cursorColor: Colors.greenAccent,
                style: const TextStyle(color: Colors.white),
                controller: controller,
                onChanged: (String value){
                  name = controller.text;
                },
              ),
            ),
            SizedBox(height: sizeBox),
            const Text('Category:',
                style: TextStyle(fontSize: 25, color: Colors.white, decoration: TextDecoration.none, fontFamily: 'Roboto',)),
            Card(
              color: Colors.black87,
              child: DropdownButton(
                dropdownColor: Colors.grey,
                  items: widget.categories.map((Category item){
                return DropdownMenuItem(
                    value: item,
                    child: Text(item.title, style:const TextStyle(color: Colors.white))
                );
              }).toList(),
                  onChanged: (Category? newCategory){
                    setState(() {
                      _value = newCategory!;
                      category = newCategory!;
                    });
                  },
                  value: _value),
            ),
            SizedBox(height: sizeBox),
            const Text('Description:',
                style: TextStyle(fontSize: 25, color: Colors.white, decoration: TextDecoration.none, fontFamily: 'Roboto',)),
            //SizedBox(height: sizeBox),
            /*const Text('Category:',
                  style: TextStyle(fontSize: 20, color: Colors.white, decoration: TextDecoration.none, fontFamily: 'Roboto', fontWeight: FontWeight.normal)),*/
            SizedBox(height: sizeBox),
            Card(
              color: Colors.black87,
              child: TextField(
                cursorColor: Colors.greenAccent,
                style: const TextStyle(color: Colors.white),
                controller: controller2,
                onChanged: (String value){
                  description = controller2.text;
                },
              ),
            ),
            SizedBox(height:  sizeBox),
            FloatingActionButton(onPressed: (){widget.addItem(name, description, category);},
                  heroTag: 'adder',
                  child: const Text('Add'),
              ),
          ],
        ),
      ),
    );
  }
}