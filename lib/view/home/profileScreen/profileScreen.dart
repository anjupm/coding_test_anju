import 'package:coding_test/common/ui/Ui.dart';
import 'package:coding_test/storage/storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.pink.shade700,
        title: Text("Profile",
          style: GoogleFonts.openSans(
              fontSize: 17,
              color: Colors.white,
              letterSpacing: 1.2,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 100),
            Container(
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.only(left: 15, right: 15),
              decoration: Ui.getBoxDecoration(),
              child: Column(
                children: [
                  const UserInfo(
                    title: "Owner's Name",
                    text: "name",
                    icon: Icons.person,
                  ),
                  const UserInfo(
                    title: "Location",
                    text: "location",
                    icon: Icons.description,
                  ),
                  const UserInfo(
                      title: "Address",
                      text: "address",
                      icon: Icons.location_on),
                  const UserInfo(
                    title: "Phone No",
                    text: "phone",
                    icon: Icons.call,
                  ),
                  GestureDetector(
                    child: Container(
                      margin: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                          color: Colors.pink.shade700,
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      height: 40,
                      width: 150,
                      child: Center(
                        child: Text("Logout",
                          style: GoogleFonts.openSans(
                              color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: ((context) {
                            return AlertDialog(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              title: const Text('Logout',
                                  style: TextStyle(color: Colors.black)),
                              content: const Text(
                                  'Do you want to logout from this account?'),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop(false);
                                  },
                                  child: Text('No', style: TextStyle(color: Colors.pink.shade700),),
                                ),
                                TextButton(
                                  onPressed: () async {
                                    //logout operations
                                    LocalStorage localStorage = LocalStorage();
                                    await localStorage.deleteToken().whenComplete(() {
                                      Navigator.of(context).pushNamedAndRemoveUntil("/registerPage", (route) => false);
                                    });
                                  },
                                  child: Text('Yes', style: TextStyle(color: Colors.pink.shade700),),
                                ),
                              ],
                            );
                          }));
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}



class UserInfo extends StatelessWidget {
  const UserInfo({
    Key? key,
    required this.text,
    required this.title,
    required this.icon,
  }) : super(key: key);

  final String title;
  final String text;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10, bottom: 10),
      padding: const EdgeInsets.all(20),
      decoration: Ui.getBoxDecorationProfile(),
      child: Row(
        children: [
          Icon(
            icon,
            color: Colors.pink.shade700,
            size: 30,
          ),
          SizedBox(width: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: GoogleFonts.quicksand(
                    fontWeight: FontWeight.w700, fontSize: 14),
              ),
              SizedBox(
                width: 250,
                child: Text(
                  text,
                  style: GoogleFonts.openSans(
                      fontWeight: FontWeight.w500, fontSize: 12),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}