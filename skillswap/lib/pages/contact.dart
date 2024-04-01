import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:lottie/lottie.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Contact Page',
    home: ContactPage(),
  ));
}

class ContactPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          'Contact',
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
      ),
      body: ContactForm(),
    );
  }
}

class ContactForm extends StatelessWidget {
  final String email = 'your@email.com';
  final String linkedinUrl = 'https://www.linkedin.com/in/yourprofile/';
  final String githubUrl = 'https://github.com/yourusername';
  final String telegramUsername = 'your_telegram_username';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Lottie.network(
            'https://lottie.host/5064ead5-9e7e-4edd-893c-af3d833abee6/54EmMthFTf.json',
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(10),
            ),
            child: ListTile(
              leading: Icon(Icons.person),
              title: Text('LinkedIn'),
              subtitle: Text('linkedin.com/in/yourprofile'),
              onTap: () => _launchURL(linkedinUrl),
              trailing: Icon(Icons.navigate_next),
            ),
          ),
          SizedBox(height: 20.0),
          Container(
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(10),
            ),
            child: ListTile(
              leading: Icon(Icons.email),
              title: Text('Send Email'),
              subtitle: Text(email),
              onTap: () => _sendEmail(email),
              trailing: Icon(Icons.navigate_next),
            ),
          ),
          SizedBox(height: 20.0),
          Container(
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(10),
            ),
            child: ListTile(
              leading: Icon(Icons.code),
              title: Text('GitHub'),
              subtitle: Text('github.com/yourusername'),
              onTap: () => _launchURL(githubUrl),
              trailing: Icon(Icons.navigate_next),
            ),
          ),
          SizedBox(height: 20.0),
          Container(
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(10),
            ),
            child: ListTile(
              leading: Icon(Icons.message),
              title: Text('Telegram'),
              subtitle: Text('@$telegramUsername'),
              onTap: () => _launchURL('https://t.me/$telegramUsername'),
              trailing: Icon(Icons.navigate_next),
            ),
          ),
        ],
      ),
    );
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _sendEmail(String email) async {
    final Uri params = Uri(
      scheme: 'mailto',
      path: email,
      query: 'subject=Hello&body=How are you?',
    );
    final String mailtoUrl = params.toString();

    if (await canLaunch(mailtoUrl)) {
      await launch(mailtoUrl);
    } else {
      throw 'Could not launch $mailtoUrl';
    }
  }
}
