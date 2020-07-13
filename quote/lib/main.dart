import 'package:flutter/material.dart';
import 'quote.dart';
import 'quote_card.dart';

void main() => runApp(MaterialApp(
      home: QuoteList(),
    ));

class QuoteList extends StatefulWidget {
  @override
  _QuoteListState createState() => _QuoteListState();
}

class _QuoteListState extends State<QuoteList> {
  List<Quote> quotes = [
    Quote(text: 'So many books, so little time.', author: 'ronak'),
    Quote(
        text: 'Be yourself; everyone else is already taken.',
        author: 'Sahil jain'),
    Quote(
        text: 'A room without books is like a body without a soul.',
        author: 'yash soni'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('New Awesome Quotes'),
          backgroundColor: Colors.red[400],
          centerTitle: true,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: quotes
              .map(
                (quote) => QuoteCard(
                  quote: quote,
                  delete: () {
                    setState(() {
                      quotes.remove(quote);
                    });
                  },
                ),
              )
              .toList(),
        ));
  }
}
