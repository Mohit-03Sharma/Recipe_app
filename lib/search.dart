import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:food_recipe_app/model.dart';

import 'package:http/http.dart';
import 'package:url_launcher/url_launcher.dart';

class Search extends StatefulWidget {
  String query = "";
  Search(this.query, {super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  bool isLoading = true;
  List<RecipeModel> recipeList = <RecipeModel>[];
  TextEditingController searchController = TextEditingController();

  getRecipe(String query) async {
    String url =
        "https://api.edamam.com/search?q=$query&app_id=bf06027c&app_key=f94b9573d8ff7aa0b350ac9d88bbb90d&from=0&to=6&calories=591-722&health=alcohol-free";
    Response response = await get(Uri.parse(url));
    Map data = jsonDecode(response.body);
    // print(data);
    data["hits"].forEach((element) {
      RecipeModel recipeModel = RecipeModel();
      recipeModel = RecipeModel.fromMap(element["recipe"]);
      recipeList.add(recipeModel);
      setState(() {
        isLoading = false;
      });
      log(recipeList.toString());
    });
    recipeList.forEach((recipe) {
      print(recipe.appLabel);
    });
  }

  Future<void> _launchUrl(_url) async {
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }

  @override
  void initState() {
    super.initState();
    getRecipe(widget.query);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: [
      Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
          colors: [
            Color(0xff213A50),
            Color(0xff071938),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        )),
      ),

      /*
       InkWell - Tap,DoubleTap etc.
       hover - color
       tap - splash 
       
       GestureDetector
        swipe etc.


       Card - elevation , backgroundColor etc.

       ClipRRect -  frame , round rectangle

       ClipPath - custom frames/clips

       positioned - Stack - topLeft , topDown, left ....

       */
      SingleChildScrollView(
        child: Column(
          children: [
            SafeArea(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                margin: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        if ((searchController.text).replaceAll(" ", "") == "") {
                          print("Blank Search");
                        } else {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      (Search(searchController.text))));
                        }
                      },
                      child: Container(
                        child: Icon(
                          Icons.search,
                          color: Colors.blueAccent,
                        ),
                        margin: EdgeInsets.fromLTRB(3, 0, 7, 0),
                      ),
                    ),
                    Expanded(
                        child: TextField(
                      controller: searchController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Search any Recipe",
                      ),
                    )),
                  ],
                ),
              ),
            ),
            Container(
              child: isLoading
                  ? Container(
                      margin: EdgeInsets.only(top: 150),
                      child: CircularProgressIndicator())
                  : ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: recipeList.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) =>
                            //             RecipeView(recipeList[index].appUrl)));
                            final Uri _url =
                                Uri.parse(recipeList[index].appUrl);
                            _launchUrl(_url);
                          },
                          child: Card(
                            margin: EdgeInsets.all(10),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            elevation: 0.0,
                            child: Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.network(
                                    recipeList[index].appImgUrl,
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                    height: 320,
                                  ),
                                ),
                                Positioned(
                                    left: 0,
                                    bottom: 0,
                                    right: 0,
                                    child: Container(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 5, horizontal: 10),
                                        decoration: BoxDecoration(
                                          color: Colors.black26,
                                        ),
                                        child: Text(
                                          recipeList[index].appLabel,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20),
                                        ))),
                                Positioned(
                                    right: 5,
                                    height: 40,
                                    width: 80,
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(10),
                                            bottomLeft: Radius.circular(10),
                                          )),
                                      child: Center(
                                        child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons
                                                    .local_fire_department_sharp,
                                                size: 15,
                                              ),
                                              Text(
                                                recipeList[index]
                                                    .appCalories
                                                    .toString()
                                                    .substring(0, 6),
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ]),
                                      ),
                                    ))
                              ],
                            ),
                          ),
                        );
                      }),
            )
          ],
        ),
      ),
    ]));
  }
}
