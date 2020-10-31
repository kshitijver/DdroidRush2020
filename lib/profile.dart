import 'package:flutter/material.dart';
import 'image_handling.dart';
import 'fireauth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'add_trip.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:photo_view/photo_view.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:social_share/social_share.dart';
import 'package:flutter/src/widgets/framework.dart';

class ProfilePage extends StatefulWidget {
  final User curr;
  ProfilePage({this.curr});
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final handler = image_handler();
  Image userimage;
  String name;
  final _fire = fireauth();
  User curr;
  CollectionReference trips = FirebaseFirestore.instance.collection('Trips');
  CollectionReference photonos =
      FirebaseFirestore.instance.collection('PhotoNumber');
  var list = List<ListTile>();
  var images = List<GestureDetector>();
  int totexp = 0;
  int tripnumber = 0;
  var ret = List<String>();
  image_handler _img = image_handler();
  PickedFile _imageFile;
  File file;
  bool uploaded = false;
  String phototitle;
  Image userimg; int nophoto=0; int nophoto1=0;
  int mode = 1;
  String uid; String dest; String date;
  Color colorselected = Colors.black;
  Color unselected = Colors.grey;
  Map<String,dynamic> data;
  firebase_storage.StorageReference ref =
      firebase_storage.FirebaseStorage.instance.ref().child('destinations');
  firebase_storage.StorageMetadata metadata;
  CollectionReference photon = FirebaseFirestore.instance.collection('PhotoNumber');
  @override
  void initState() {
    curr = widget.curr;
    String uid=curr.uid;
    print(uid);
    FirebaseFirestore.instance
        .collection('PhotoNumber').doc('$uid')
        .get()
        .then((DocumentSnapshot docSnapshot)
            {
              print(docSnapshot.data());
              nophoto=docSnapshot.data()['number'];
              for(int i=1;i<=nophoto;i++)
              {
                Image m;
                uid=curr.uid;
                handler?.getImage(context, 'TripPhotos/$uid\_$i.png')?.then((value)
                {
                  m=value;
                  images.add(GestureDetector(
                    child: PhotoView(
                      imageProvider: m.image,
                    ),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) {
                        return DetailScreen(display: m,);
                      }));
                    },
                  ));
                });
              }
            }
            );
    uid = curr.uid;
    print(curr.email);
    String em=curr.email;

    handler?.getImage(context, 'ProfilePictures/$em.png')?.then((userimg) {
      setState(() {
        userimage = userimg;
      });
    });
    if (userimage == null) {
      userimage = Image.asset('assets/images/avatar.png');
    }
    super.initState();
  }

  @override
  void didChangeDependencies() {
    FirebaseFirestore.instance
        .collection('Trips')
        .where('uid', isEqualTo: curr.uid)
        .get()
        .then((QuerySnapshot querySnapshot) => {
              querySnapshot.docs.forEach((doc) {
                print(doc['Expenditure'.toString()]);
                dest=doc['Destination'];
                date=doc['Date'];
                list.add(ListTile(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                  leading: Container(
                    padding: EdgeInsets.only(right: 12.0, top: 4.0),
                    decoration: new BoxDecoration(
                        border: new Border(
                            right: new BorderSide(
                                width: 1.0, color: Colors.white24))),
                    child:
                        Icon(Icons.settings_backup_restore, color: Colors.grey),
                  ),
                  title: Text(doc['Destination']),
                  subtitle: Row(
                    children: [
                      Text(doc['Date']),
                      Spacer(),
                      Text("\$" + doc['Expenditure'].toString())
                    ],
                  ),
                  trailing: PopupMenuButton(
                      icon: Icon(
                        Icons.more_vert,
                        color: Colors.black,
                      ),
                      itemBuilder: (context) => [
                            PopupMenuItem(
                              child: Padding(
                                padding: EdgeInsets.all(2.0),
                                child: Text('Delete trip'),
                              ),
                              value: 1,
                            ),
                        PopupMenuItem(
                          child: Padding(
                            padding: EdgeInsets.all(2.0),
                            child: Text('Share to Whatsapp'),
                          ),
                          value: 2,
                        )
                          ],
                      onSelected: ((value) async {
                        if (value == 1) {
                          setState(() async {
                            await trips
                                .doc(doc['Destination'] + doc['Date'])
                                .delete();
                          });
                        }
                        if(value ==2)
                          {
                            await SocialShare.shareWhatsapp("I went on a trip to $dest on $date");
                          }
                      })),
                ));
                setState(() {
                  totexp = totexp + doc['Expenditure'];
                  tripnumber++;
                  print(totexp);
                });
              })
            });
    metadata = firebase_storage.StorageMetadata(
      customMetadata: <String, String>{
        'userId': uid,
      },
    );

    super.didChangeDependencies();
  }


  uploadimage() async {
    if (uploaded == true) {
      try {
        print("try block triggered");
        nophoto1=nophoto+1;
        uid=curr.uid;
        print("Nophoto is $nophoto1");
        await photon.doc('$uid')
            .set({
          'uid': uid,
          'number': nophoto1// 42
        });
        uid=curr.uid;
        await _img.startUploadMeta(file, 'TripPhotos/$uid\_$nophoto1.png', metadata);
        Navigator.pop(context);
      } catch (e) {
        Fluttertoast.showToast(
            msg: e.message,
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 3,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 12.0);
      }
    } else {
      print("else block");
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget mode1 = Column(
      children: list,
    );
    Widget mode2 = CustomScrollView(
      shrinkWrap: true,
      primary: false,
      slivers: <Widget>[
        SliverPadding(
          padding: const EdgeInsets.all(3.0),
          sliver: SliverGrid.count(
              mainAxisSpacing: 1, //horizontal space
              crossAxisSpacing: 1, //vertical space
              crossAxisCount: 3, //number of images for a row
              children: images
          ),
        ),
      ],
    );
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.black,
          child: Icon(Icons.photo),
          onPressed: () async {
            setState(() async {
              showModalBottomSheet(
                  context: context,
                  builder: (BuildContext bc) {
                    return Container(
                      child: new Wrap(
                        children: <Widget>[
                          new ListTile(
                              leading: new Icon(Icons.camera_alt),
                              title: new Text('Upload from Camera'),
                              onTap: () async {
                                _imageFile =
                                    await _img.pickImage(ImageSource.camera);
                                file = await _img.cropImage(_imageFile);
                                setState(() {
                                  userimg = Image.file(file);
                                  uploaded = true;
                                  print(uploaded);
                                });
                                uploadimage();
                              }),
                          new ListTile(
                            leading: new Icon(Icons.photo),
                            title: new Text('Upload from Gallery'),
                            onTap: () async {
                              _imageFile =
                                  await _img.pickImage(ImageSource.gallery);
                              file = await _img.cropImage(_imageFile);
                              setState(() {
                                userimg = Image.file(file);
                                uploaded = true;
                              });
                              uploadimage();
                            },
                          ),
                        ],
                      ),
                    );
                  });
            });
            if (bool == true) print("bool true");
            await uploadimage();
          }),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.black,
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: <Widget>[
          PopupMenuButton(
            icon: Icon(
              Icons.more_vert,
              color: Colors.black,
            ),
            itemBuilder: (context) => [
              PopupMenuItem(
                child: Padding(
                  padding: EdgeInsets.all(2.0),
                  child: Text('Create new trip'),
                ),
                value: 1,
              ),
              PopupMenuItem(
                child: Padding(
                  padding: EdgeInsets.all(2.0),
                  child: Text('Sign Out'),
                ),
                value: 2,
              )
            ],
            onSelected: ((value) async {
              if (value == 2) {
                _fire.out();
                Phoenix.rebirth(context);
              }
              if (value == 1) {
                ret = await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MySpecialCard(
                              curr: curr,
                            )));
                list.add(ListTile(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                  leading: Container(
                    padding: EdgeInsets.only(right: 12.0, top: 4.0),
                    decoration: new BoxDecoration(
                        border: new Border(
                            right: new BorderSide(
                                width: 1.0, color: Colors.white24))),
                    child:
                        Icon(Icons.settings_backup_restore, color: Colors.grey),
                  ),
                  title: Text(ret[0]),
                  subtitle: Row(
                    children: [Text(ret[1]), Spacer(), Text("\$" + ret[2])],
                  ),
                ));
                setState(() {
                  print("setstate called");
                });
              }
            }),
          )
        ],
      ),
      body: ListView(
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Hero(
                tag: 'tag',
                child: Container(
                  height: 125.0,
                  width: 125.0,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(62.5),
                      image: DecorationImage(
                          fit: BoxFit.cover, image: userimage?.image)),
                ),
              ),
              SizedBox(height: 25.0),
              Text(
                curr?.displayName == null
                    ? 'Abhishek Agrawal'
                    : curr?.displayName,
                style: TextStyle(
                    fontFamily: 'Circular',
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 4.0),
              Text(
                curr?.email == null ? 'abhishekagr06@gmail.com' : curr?.email,
                style: TextStyle(fontFamily: 'Circular', color: Colors.grey),
              ),
              Padding(
                padding: EdgeInsets.all(30.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          '\$$totexp',
                          style: TextStyle(
                              fontFamily: 'Circular',
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 5.0),
                        Text(
                          'SPENT',
                          style: TextStyle(
                              fontFamily: 'Circular', color: Colors.grey),
                        )
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          tripnumber.toString(),
                          style: TextStyle(
                              fontFamily: 'Circular',
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 5.0),
                        Text(
                          'TRIPS',
                          style: TextStyle(
                              fontFamily: 'Circular', color: Colors.grey),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(
                        Icons.menu,
                        color: mode == 1 ? colorselected : unselected,
                      ),
                      onPressed: () {
                        setState(() {
                          mode = 1;
                        });
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.table_chart,
                          color: mode == 2 ? colorselected : unselected),
                      onPressed: () {
                        setState(() {
                          mode = 2;
                        });
                      },
                    )
                  ],
                ),
              ),
              mode == 1 ? mode1 : mode2,
            ],
          )
        ],
      ),
    );
  }
}

class DetailScreen extends StatelessWidget {
  final Image display;
  DetailScreen({this.display});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        child: Center(
          child: Hero(
            tag: 'imageHero',
            child: PhotoView(
                imageProvider: display.image),
          ),
        ),
        onTap: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}
