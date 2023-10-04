import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/auth/screens/detail_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final db = FirebaseFirestore.instance;
  User user = FirebaseAuth.instance.currentUser!;

  List docs = [];

  Future _getUsers() async {
    return await db.collection('users').get().then(
      (querySnapshot) {
        print("Successfully completed");
        docs = querySnapshot.docs;
      },
      onError: (e) => print("Error completing: $e"),
    );
  }

  void _navigateToDetail(data) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => DetailScreen(data: data),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          user.email!,
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
            },
            icon: const Icon(
              Icons.logout,
            ),
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: FutureBuilder(
                future: _getUsers(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return ListView.builder(
                      itemCount: docs.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(docs[index].id),
                          trailing: IconButton(
                            onPressed: () =>
                                _navigateToDetail(docs[index].data()),
                            icon: const Icon(
                              Icons.arrow_forward,
                            ),
                          ),
                        );
                      },
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: Colors.red,
                      ),
                    );
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
