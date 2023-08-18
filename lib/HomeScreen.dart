import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:video_app/DataModel.dart';

import 'ApiServices.dart';
import 'file.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ApiServices get service => GetIt.I<ApiServices>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text('Video Player Screen'),
          centerTitle: true,
          elevation: 0.0,
          backgroundColor: Color(0xFFF48FB1),
        ),
        body: Column(
          children: [
            Text(
              'List of videos',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.black45,
                fontSize: 20,
              ),
            ),
            Expanded(
              child: FutureBuilder<List<DataModel>>(
                future: service.getVideosAPI(),
                builder: (context, response) {
                  if (response.hasData) {
                    print('object list view');
                    return ListView.builder(
                        shrinkWrap: true,
                        itemCount: response.data!.length,
                        itemBuilder: (context, index) {
                          final item = response.data![index];
                          return Stack(
                            alignment: Alignment.center,
                            children: [
                              Image.network(
                                item.thumbnailUrl!,
                                fit: BoxFit.cover,
                                errorBuilder: (BuildContext context,
                                    Object exception, StackTrace? stackTrace) {
                                  return CircularProgressIndicator();
                                },
                                loadingBuilder: (BuildContext context,
                                    Widget child,
                                    ImageChunkEvent? loadingProgress) {
                                  if (loadingProgress == null) {
                                    return child;
                                  }
                                  return Center(
                                    child: CircularProgressIndicator(
                                      color: Colors.black,
                                      value:
                                          loadingProgress.expectedTotalBytes !=
                                                  null
                                              ? loadingProgress
                                                      .cumulativeBytesLoaded /
                                                  loadingProgress
                                                      .expectedTotalBytes!
                                              : null,
                                    ),
                                  );
                                },
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => VideoScreen(
                                        videoUrl: item.videoUrl!,
                                      ),
                                    ),
                                  );
                                },
                                child: const CircleAvatar(
                                  radius: 30,
                                  backgroundColor: Colors.black45,
                                  child: Icon(
                                    Icons.play_arrow,
                                    size: 40,
                                    color: Colors.red,
                                  ),
                                ),
                              )
                            ],
                          );
                        });
                  } else if (response.hasError) {
                    print('object error ' +
                        response.data.toString() +
                        '  ' +
                        response.connectionState.toString() +
                        '  ' +
                        response.stackTrace.toString() +
                        '  ' +
                        response.error.toString());
                    return Text(response.error.toString());
                  }

                  return Center(
                    child: Text('Data loading, Please wait.....'),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
