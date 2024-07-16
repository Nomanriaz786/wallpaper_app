//Muhammad Noman Riaz
//21-Arid-4010

import 'dart:convert';
import 'package:api_project/setwallpaper.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Wallpapers extends StatefulWidget {
  const Wallpapers({super.key});

  @override
  State<Wallpapers> createState() => _WallpapersState();
}

class _WallpapersState extends State<Wallpapers> {
  List imageLinks = [];
  int pages = 1;
  @override
  void initState() {
    super.initState();
    setState(() {
      fetchapi();
    });
  }

  fetchapi() async {
    await http.get(Uri.parse('https://api.pexels.com/v1/curated?per_page=80'),
        headers: {
          'Authorization':
              '8d3mWGE4K84jeoM7QmeTwIlZZAiEllOSKuGrsVyZ0MRsLYj38yukTpzq'
        }).then((value) {
      Map result = jsonDecode(value.body);
      setState(() {
        imageLinks = result['photos'];
        print(imageLinks.length);
      });
    });
  }

  loadingmore() async {
    setState(() {
      pages += 1;
    });
    await http.get(
        Uri.parse('https://api.pexels.com/v1/curated?page=$pages&per_page=80'),
        headers: {
          'Authorization':
              '8d3mWGE4K84jeoM7QmeTwIlZZAiEllOSKuGrsVyZ0MRsLYj38yukTpzq'
        }).then((value) {
      Map result = jsonDecode(value.body);
      setState(() {
        imageLinks.addAll(result['photos']);
        print(imageLinks.length);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Container(
                    child: GridView.builder(
                        itemCount: imageLinks.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          mainAxisSpacing: 2,
                          crossAxisSpacing: 2,
                        ),
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      SetWallPaper(
                                    imageLink: imageLinks[index]['src']['large2X'],
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              color: Colors.blueAccent,
                              child: Image.network(
                                imageLinks[index]['src']['large'],
                                fit: BoxFit.cover,
                              ),
                            ),
                          );
                        })),
              ),
              InkWell(
                onTap: () {
                  loadingmore();
                },
                child: Container(
                  height: 40,
                  width: double.infinity,
                  color: Colors.black,
                  child: const Center(
                    child: Text(
                      'More Loading !!',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
