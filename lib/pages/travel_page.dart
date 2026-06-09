import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Attraction {
  final String name;
  final String description;
  final String imageUrl;
  final double dx;
  final double dy;
  final double lat;
  final double lng;

  Attraction({
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.dx,
    required this.dy,
    required this.lat,
    required this.lng,
  });
}

final List<Attraction> attractions = [
  Attraction(
    name: 'Eiffel Tower',
    description:
        'The Eiffel Tower is a wrought-iron lattice tower on the Champ de Mars in Paris.',
    imageUrl: 'https://picsum.photos/seed/eiffel/400/300',
    dx: 0.38,
    dy: 0.45,
    lat: 48.8584,
    lng: 2.2945,
  ),
  Attraction(
    name: 'Louvre Museum',
    description:
        'The Louvre is the world\'s most-visited art museum, located in Paris.',
    imageUrl: 'https://picsum.photos/seed/louvre/400/300',
    dx: 0.42,
    dy: 0.38,
    lat: 48.8606,
    lng: 2.3376,
  ),
  Attraction(
    name: 'Mont Saint-Michel',
    description: 'A tidal island and mainland commune in Normandy, France.',
    imageUrl: 'https://picsum.photos/seed/mont/400/300',
    dx: 0.22,
    dy: 0.28,
    lat: 48.6361,
    lng: -1.5115,
  ),
  Attraction(
    name: 'Palace of Versailles',
    description:
        'A royal château in Versailles, known for its Hall of Mirrors.',
    imageUrl: 'https://picsum.photos/seed/versailles/400/300',
    dx: 0.40,
    dy: 0.48,
    lat: 48.8049,
    lng: 2.1204,
  ),
];

class TravelPage extends StatefulWidget {
  const TravelPage({super.key});

  @override
  State<TravelPage> createState() => _TravelPageState();
}

class _TravelPageState extends State<TravelPage> {
  void _showAttractionDialog(Attraction attraction) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        insetPadding: EdgeInsets.all(20),
        child: SizedBox(
          width: double.maxFinite,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(16),
                      child: LongPressDraggable<String>(
                        data: attraction.name,
                        feedback: Material(
                          child: Padding(
                            padding: EdgeInsets.all(8),
                            child: Text(
                              attraction.name,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        child: Text(
                          attraction.name,
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.close),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (ctx) => Dialog(
                        insetPadding: EdgeInsets.zero,
                        child: Stack(
                          children: [
                            InteractiveViewer(
                              child: Image.network(
                                attraction.imageUrl,
                                fit: BoxFit.contain,
                              ),
                            ),
                            Positioned(
                              top: 8,
                              right: 8,
                              child: IconButton(
                                icon: Icon(Icons.close, color: Colors.white),
                                onPressed: () => Navigator.of(ctx).pop(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  child: Image.network(
                    attraction.imageUrl,
                    width: double.infinity,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(16),
                  child: Text(
                    attraction.description,
                    style: TextStyle(fontSize: 14),
                  ),
                ),
                Center(
                  child: TextButton(
                    onPressed: () async {
                      final url = Uri.parse(
                        'https://www.google.com/maps/search/?api=1&query=${attraction.lat},${attraction.lng}',
                      );
                      await launchUrl(
                        url,
                        mode: LaunchMode.externalApplication,
                      );
                    },
                    child: Text(
                      'Go Now!',
                      style: TextStyle(
                        color: Colors.blue,
                        decoration: TextDecoration.underline,
                        decorationColor: Colors.blue,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Popular Locations',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final mapWidth = constraints.maxWidth;
          final mapHeight = constraints.maxHeight;

          return InteractiveViewer(
            minScale: 1.0,
            maxScale: 5.0,
            child: SizedBox(
              width: mapWidth,
              height: mapHeight,
              child: Stack(
                children: [
                  Image.asset(
                    'assets/france_map.png',
                    width: mapWidth,
                    height: mapHeight,
                    fit: BoxFit.cover,
                  ),
                  ...attractions.map((attraction) {
                    return Positioned(
                      left: attraction.dx * mapWidth - 16,
                      top: attraction.dy * mapHeight - 16,
                      child: GestureDetector(
                        onTap: () => _showAttractionDialog(attraction),
                        child: Icon(
                          Icons.location_on,
                          color: Colors.red,
                          size: 32,
                        ),
                      ),
                    );
                  }),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}