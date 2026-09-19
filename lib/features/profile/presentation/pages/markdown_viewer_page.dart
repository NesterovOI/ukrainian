import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:ukrainian/core/theme/theme.dart';

///Віджет для читання файлвів в стилі markdown

class MarkdownViewerPage extends StatelessWidget {
  final String title;
  final String filePath;

  const MarkdownViewerPage({
    super.key,
    required this.title,
    required this.filePath,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title), centerTitle: true),
      body: FutureBuilder<String>(
        future: rootBundle.loadString(filePath),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Text(AppStrings.errorLoading + snapshot.error.toString()),
            );
          }

          return Markdown(
            data: snapshot.data ?? '',
            onTapLink: (text, href, title) async {
              if (href != null) {
                final uri = Uri.parse(href);
                if (await canLaunchUrl(uri)) {
                  await launchUrl(uri);
                }
              }
            },
          );
        },
      ),
    );
  }
}
