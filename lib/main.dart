import 'package:flutter/material.dart';
import 'widgets/route.dart';
import 'widgets/dataClasses.dart';
import 'widgets/detailedContainer.dart';
import 'widgets/itemAdder.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.greenAccent),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'To Do List'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}



class _MyHomePageState extends State<MyHomePage> {
  List<Task> tasks = [];
  List<Category> categories = [
    Category(title: 'Home', color: Colors.greenAccent),
    Category(title: 'Work', color: Colors.lightGreen),
    Category(title: 'Studies', color: Colors.orangeAccent)
  ];
  int isDoneCount = 0;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: Text(widget.title,
        style: const TextStyle(color: Colors.white)),
        actions: [
          FloatingActionButton(onPressed: (){
            showMenu(context: context,
                color: Colors.grey[500],
                items: [
                  PopupMenuItem(child: Column(
                    children:[
                      Row(children:[
                        const Expanded(child: Text('Not Done', style: TextStyle(color: Colors.white))),
                        const Spacer(),
                        Expanded(child: Text((tasks.length-isDoneCount).toString(), style: const TextStyle(color: Colors.white))),
                      ]),
                      Row(children:[
                        const Expanded(child: Text('Done', style: TextStyle(color: Colors.white))),
                        const Spacer(),
                        Expanded(child: Text(isDoneCount.toString(), style: const TextStyle(color: Colors.white))),
                      ]),
                  ]
                  )),
                ],
                position: RelativeRect.fromLTRB(1, MediaQuery.of(context).size.height*0.1,  0, 0 )
            );
          },
            shape: const CircleBorder(),
            heroTag: 'tasks',
            child: Text(tasks.length.toString()),
          ),
        ],
      ),
      body: Stack(
        children:[ Center(
          child: Container(
            padding: const EdgeInsets.all(10),
            color: Colors.black87,
            child: ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border:  Border.all(color: tasks[index].isDone == true ? Colors.green : Colors.black),
                        borderRadius:  BorderRadius.circular(15),
                      ),
                      child: ListTile(
                        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
                        tileColor: Colors.black,
                        title: Text(tasks[index].name, style: const TextStyle(color: Colors.white)),
                        subtitle: Text(tasks[index].category.title, style: const TextStyle(color: Colors.white)),
                        onTap: (){
                          Navigator.of(context).push(MyPageRoute(builder: (BuildContext context){
                            return DetailedContainer(
                                task: tasks[index],
                                removeItem: (){
                                  setState(() {
                                    tasks.removeAt(index);
                                  });
                                Navigator.pop(context);
                                }
                            );
                          }));
                        },
                        leading: Checkbox(
                          checkColor: Colors.white,
                          value: tasks[index].isDone,
                          onChanged: (bool? value) {
                            setState(() {
                              tasks[index].isDone= value!;
                              tasks[index].isDone == true ? isDoneCount++ : isDoneCount--;
                            });
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 15)
                  ],
                );
              },
            ),
            ),
          ),
          Positioned(
          bottom: 40,
          left: MediaQuery.of(context).size.width * 0.38,
            child: FloatingActionButton.large(
              heroTag: 'add',
            onPressed: (){
              setState(() {
                Navigator.of(context).push(MyPageRoute(builder: (BuildContext context){
                  return ItemAdder(
                    categories: categories,
                    addItem: (newTaskName, newTaskDescription, newTaskCategory) {
                      setState(() {
                        tasks.add(Task(name: newTaskName, description: newTaskDescription, category: newTaskCategory));
                      });
                      Navigator.pop(context);
                    },
                  );
                }));
              });
            },
            shape: const CircleBorder(),
            elevation: 6,
            child: const Icon(Icons.add),
            ),),
        ]
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

