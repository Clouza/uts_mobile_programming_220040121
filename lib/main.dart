import 'package:flutter/material.dart';

void main() {
  runApp(const AnimalApp());
}

class AnimalApp extends StatelessWidget {
  const AnimalApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: AnimalHomePage(),
    );
  }
}

class Animal {
  final String speciesName;
  final String indonesianName;
  final String description;
  final String imageUrl;

  Animal({
    required this.speciesName,
    required this.indonesianName,
    required this.description,
    required this.imageUrl,
  });
}

class AnimalHomePage extends StatefulWidget {
  const AnimalHomePage({super.key});

  @override
  _AnimalHomePageState createState() => _AnimalHomePageState();
}

class _AnimalHomePageState extends State<AnimalHomePage> {
  final List<Animal> _animals = [
    Animal(
      speciesName: "Panthera leo",
      indonesianName: "Singa",
      description: "Hewan pemangsa besar yang hidup di sabana.",
      imageUrl: "https://via.placeholder.com/150",
    ),
    Animal(
      speciesName: "Elephas maximus",
      indonesianName: "Gajah",
      description: "Hewan darat terbesar dengan belalai yang panjang.",
      imageUrl: "https://via.placeholder.com/150",
    ),
  ];

  void _addAnimal(Animal animal) {
    setState(() {
      _animals.add(animal);
    });
  }

  void _updateAnimal(int index, Animal updatedAnimal) {
    setState(() {
      _animals[index] = updatedAnimal;
    });
  }

  void _deleteAnimal(int index) {
    setState(() {
      _animals.removeAt(index);
    });
  }

  void _showAnimalForm([int? index]) {
    final isEditing = index != null;
    final animal = isEditing ? _animals[index!] : null;

    final speciesController = TextEditingController(text: animal?.speciesName);
    final indonesianNameController =
        TextEditingController(text: animal?.indonesianName);
    final descriptionController =
        TextEditingController(text: animal?.description);
    final imageController = TextEditingController(text: animal?.imageUrl);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(isEditing ? "Edit Animal" : "Add Animal"),
        content: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: speciesController,
                decoration: const InputDecoration(labelText: "Nama Spesies"),
              ),
              TextField(
                controller: indonesianNameController,
                decoration: const InputDecoration(labelText: "Nama Indonesia"),
              ),
              TextField(
                controller: descriptionController,
                decoration: const InputDecoration(labelText: "Deskripsi"),
              ),
              TextField(
                controller: imageController,
                decoration: const InputDecoration(labelText: "URL Gambar"),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              final newAnimal = Animal(
                speciesName: speciesController.text,
                indonesianName: indonesianNameController.text,
                description: descriptionController.text,
                imageUrl: imageController.text,
              );

              if (isEditing) {
                _updateAnimal(index!, newAnimal);
              } else {
                _addAnimal(newAnimal);
              }
              Navigator.pop(context);
            },
            child: Text(isEditing ? "Update" : "Add"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Animal Manager"),
      ),
      body: ListView.builder(
        itemCount: _animals.length,
        itemBuilder: (context, index) {
          final animal = _animals[index];
          return Card(
            child: ListTile(
              leading: Image.network(animal.imageUrl, width: 50, height: 50),
              title: Text(animal.indonesianName),
              subtitle: Text(animal.description),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () => _showAnimalForm(index),
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () => _deleteAnimal(index),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAnimalForm(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
