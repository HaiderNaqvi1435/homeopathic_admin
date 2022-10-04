import 'package:flutter/material.dart';
import 'package:homeopathic_admin/Core/DataProviders/DataProvider.dart';
import 'package:homeopathic_admin/UI/Homeopathic/addBlog.dart';
import 'package:provider/provider.dart';

class HomeoBlogs extends StatefulWidget {
  HomeoBlogs({Key? key}) : super(key: key);

  @override
  State<HomeoBlogs> createState() => _HomeoBlogsState();
}

class _HomeoBlogsState extends State<HomeoBlogs> {
  @override
  Widget build(BuildContext context) {
    return Consumer<DataProvider>(
      builder: (context, data, child) => Scaffold(
        appBar: AppBar(
          title: Text("Blogs"),
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: data.remedylist.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Text(data.remedylist[index].remedy!),
                    subtitle: Text(data.remedylist[index].materia!),
                  );
                },
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NewBlog(),
                  ));
            },
            child: Icon(Icons.add)),
      ),
    );
  }
}
