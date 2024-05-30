import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:proximity_delivery/pages/page_map.dart';
import 'package:rate_in_stars/rate_in_stars.dart';

class ProfilPage extends StatefulWidget {
  const ProfilPage({super.key});

  @override
  State<ProfilPage> createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: null,
        actions: [
          IconButton(
            onPressed: (){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const MapPageDesign())
            );
          }, 
            icon: const Icon(Icons.map_rounded)
          )
        ],
        centerTitle: true,
        title: const Text(
          "Profil",
          style: TextStyle(
            fontWeight: FontWeight.w700,
            letterSpacing: 0.25,
            color: Color.fromRGBO(0, 0, 0, 1)
          )
        )
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 10,
              ),
              child: Container(
              width: 150,
              height: 150,
              decoration: const BoxDecoration(
                color: Colors.transparent
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(75),
                child: const Image(image: AssetImage('assets/icons/ImageProfil.png'))
              )
            ),
            ),
            const Padding(
              padding: EdgeInsets.only(
                top: 10
              ),
              child: Text(
                "Emma MARTIN",
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 25,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 10
              ),
              child: RatingStars(
                rating: 3.5,
                editable: false,
                iconSize: 40,
                color: const Color.fromRGBO(255, 216, 20, 1),
              )
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 15,
              ),
              child: 
            
Card.outlined(
                          color: const Color.fromRGBO(255, 216, 20, .0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              const ListTile(
                                //Icon(Icons.album),
                                title: Text(
                                  "Adresse:",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700 
                                  ),
                                ),
                                subtitle: Text("123 Rue de l'Université, 34000 Montpellier, France"),
                              ),
                              const ListTile(
                                //Icon(Icons.album),
                                title: Text(
                                  "Email:",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700 
                                  ),
                                ),
                                subtitle: Text("emma.martin@gmail.com"),
                              ),
                              const ListTile(
                                //Icon(Icons.album),
                                title: Text(
                                  "Téléphone:",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700 
                                  ),
                                ),
                                subtitle: Text("+33 57 70 30 28"),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  const SizedBox(width: 8),
                                  IconButton(
                                    icon: Icon(Icons.edit_rounded),
                                    onPressed: () {
                                      
                                      /* ... */
                                    },
                                  ),
                                  const SizedBox(width: 8),
                                ],
                              ),
                            ],
                          ),
                        )
        ),
          ],
        ),
      )
    );
  }
}