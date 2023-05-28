import 'package:flutter/material.dart'; //imports required packages

void main() {
  runApp(newMethod()); //to run the flutter app
}

ListApp newMethod() => ListApp();

class ListApp extends StatelessWidget { //class whose state doesnot change
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,  
      title: 'Item List',   
      theme: ThemeData(primarySwatch: Colors.teal),
      home: ListScreen(),
    );
  }
}
  
class ListScreen extends StatefulWidget {  //class whose state changes
  @override
  ScreenState createState() => ScreenState(); //to create new state object for each state
}

class ScreenState extends State<ListScreen> {
  List<Map<String, dynamic>> categories = [  //list of items
    {                                        //list contains two maps, each representing a different categories
      'title': 'Table',
      'description': 'A table to place your belongings.',
      'imageURL': 'https://cdn-icons-png.flaticon.com/128/2337/2337040.png',
    },
    {
      'title': 'Chair',
      'description': 'A comfortable chair.',
      'imageURL': 'https://cdn-icons-png.flaticon.com/128/8557/8557449.png',
    },
    {
      'title': 'Fan',
      'description': 'A reliable electric fan.',
      'imageURL': 'https://cdn-icons-png.flaticon.com/128/9654/9654966.png',
    },
    {
      'title': 'Bottle',
      'description': 'A large water bottle.',
      'imageURL': 'https://cdn-icons-png.flaticon.com/128/2745/2745060.png',
    },
    {
      'title': 'Bag',
      'description': 'A durable school bag.',
      'imageURL': 'https://cdn-icons-png.flaticon.com/128/3275/3275955.png',
    },
    {
      'title': 'Mat',
      'description': 'A comfortable mat.',
      'imageURL': 'https://cdn-icons-png.flaticon.com/128/2251/2251828.png',
    },
  ];

  String text = ''; //to allow the user to search using text

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> requiredItem = categories.where((category) { //to filter the list
      final title = category['title'].toString().toLowerCase(); //to convert into lowercase
      final description = category['description'].toString().toLowerCase();
      final search = text.toLowerCase();
      return title.contains(search) || description.contains(search);
    }).toList(); //to put filtered data into a new list

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const Text('Item List'),
            const SizedBox(width: 16),
            Expanded(
              child: TextField(
                onChanged: (value) {
                  setState(() {
                    text = value;
                  });
                },
                decoration:const InputDecoration(
                  hintText: 'Search',
                  hintStyle: TextStyle(color: Colors.white70),
                  prefixIcon: Icon(Icons.search, color: Colors.white70),
                  border: InputBorder.none,
                ),
                style: const TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
          ],
        ),
      ),
      body: ListView.builder(
        itemCount: requiredItem.length,
        itemBuilder: (BuildContext context, int index) {
          return Dismissible(
            key: UniqueKey(),
            direction: DismissDirection.startToEnd,
            onDismissed: (direction) {
              setState(() {
                categories.removeAt(index);
              });
            },
            background: Container(
              color: Colors.red,
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child:const Icon(Icons.delete, color: Colors.white),
            ),
            child: ListTile(
              leading: Image.network(
                requiredItem[index]['imageURL'],
                width: 48,
                height: 48,
              ),
              title: Text(requiredItem[index]['title']),
              subtitle: Text(requiredItem[index]['description']),
              onTap: () {
                // Handle category selection here
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showAddItem(context);
        },
        child:const Icon(Icons.add),
      ),
    );
  }

  void showAddItem(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String newTitle = '';
        String newDescription = '';
        String newImageUrl = '';

        return AlertDialog(
          title: const Text('Add Item'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                onChanged: (value) {
                  newTitle = value;
                },
                decoration: const InputDecoration(
                  labelText: 'Title',
                ),
              ),
              TextField(
                onChanged: (value) {
                  newDescription = value;
                },
                decoration: const InputDecoration(
                  labelText: 'Description',
                ),
              ),
              TextField(
                onChanged: (value) {
                  newImageUrl = value;
                },
                decoration: const InputDecoration(
                  labelText: 'Image URL',
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (newTitle.isNotEmpty && newDescription.isNotEmpty) {
                  setState(() {
                    categories.add({
                      'title': newTitle,
                      'description': newDescription,
                      'imageURL': newImageUrl,
                    });
                  });
                }
                Navigator.of(context).pop();
              },
              child: const Text('Add'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }
}
