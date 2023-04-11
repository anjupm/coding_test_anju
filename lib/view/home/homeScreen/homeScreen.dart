import 'package:cached_network_image/cached_network_image.dart';
import 'package:coding_test/repository/home/notifier/homepage.notifier.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final homeData = Provider.of<HomePageNotifier>(context, listen: false);

    return FutureBuilder(
      future: homeData.getAllDatas(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return homeData.homePageModel.data.isNotEmpty
              ? Scaffold(
                  backgroundColor: Colors.white,
                  appBar: AppBar(
                    elevation: 0,
                    automaticallyImplyLeading: false,
                    backgroundColor: Colors.pink.shade700,
                    title: Text(
                      "Home",
                      style: GoogleFonts.openSans(
                          fontSize: 16,
                          color: Colors.white,
                          letterSpacing: 1.2,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  body: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Consumer<HomePageNotifier>(builder: (context, data, _) {
                          return ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: homeData.homePageModel.data.length,
                            itemBuilder: (context, index) {
                              return Container(
                                margin: const EdgeInsets.only(
                                    left: 20, right: 20, top: 10, bottom: 10),
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10)),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.grey.withOpacity(0.2),
                                        blurRadius: 10,
                                        offset: const Offset(0, 5)),
                                  ],
                                  border: Border.all(
                                      color: Colors.grey.withOpacity(0.05)),
                                ),
                                child: Row(
                                  children: [
                                    ClipRRect(
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        bottomLeft: Radius.circular(10),
                                      ),
                                      child: SizedBox(
                                        width: 120,
                                        height: 120,
                                        child: Image.network(homeData.homePageModel.data[index].avatar, fit: BoxFit.cover),
                                      ),
                                    ),
                                    const SizedBox(width: 18),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "${homeData.homePageModel.data[index].firstName} ${homeData.homePageModel.data[index].lastName}",
                                            style: GoogleFonts.montserrat(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          const SizedBox(height: 15),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              const Icon(Icons.email, size: 20),
                                              const SizedBox(width: 5),
                                              Expanded(
                                                child: Text(
                                                  homeData.homePageModel
                                                      .data[index].email,
                                                  style: const TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 13),
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 10),
                                        ],
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        homeData.deleteItem(index: index);
                                      },
                                      child: const Padding(
                                        padding: EdgeInsets.all(10.0),
                                        child: Icon(
                                          Icons.delete,
                                          color: Colors.black,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              );
                            },
                          );
                        }),
                      ],
                    ),
                  ),
                )
              : const Center(child: Text("No items"));
        } else if (snapshot.hasError) {
          return const Center(
            child: Text("Something went wrong"),
          );
        }
        return Center(
            child: CircularProgressIndicator(color: Colors.pink.shade700));
      },
    );
  }
}
