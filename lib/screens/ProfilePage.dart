import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(color: Colors.black,),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(25),
                child: InkWell(
                  onTap: (){},
                  child: CircleAvatar(
                    radius: 100,
                    //backgroundImage: image != null ? FileImage(image): NetworkImage("null"),
                  ),
                ),
              ),
              Container(
                height: 150,
                width: 150,
                margin: const EdgeInsets.only(right: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage('assets/images/avatar.png'),
                    )),
              ),
              SizedBox(height: 20),
              Text(
                'Menendez NELSON',
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(height: 20),
              Positioned(
                bottom: 0,
                child: Container(
                  color: Colors.black54,
                  width: MediaQuery.of(context).size.width,
                  padding:
                  EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Text(
                            '50',
                            style: TextStyle(color: Colors.white, fontSize: 35),
                          ),
                          SizedBox(height: 5,),
                          Text(
                            'Titre Stat 1',
                            style: TextStyle(color: Colors.white),
                          )
                        ],
                      ),
                      SizedBox(
                        width: 50,
                      ),Column(
                        children: [
                          Text(
                            '4.8',
                            style: TextStyle(color: Colors.white, fontSize: 35),
                          ),
                          SizedBox(height: 5,),
                          Text(
                            'Titre Stat 2',
                            style: TextStyle(color: Colors.white),
                          )
                        ],
                      ),
                      SizedBox(
                        width: 50,
                      ),Column(
                        children: [
                          Text(
                            '35',
                            style: TextStyle(color: Colors.white, fontSize: 35),
                          ),
                          SizedBox(height: 5,),
                          Text(
                            'Titre Stat 3',
                            style: TextStyle(color: Colors.white),
                          )
                        ],
                      ),
                    ],
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
