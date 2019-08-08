import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:outline_material_icons/outline_material_icons.dart';
import 'message_widget.dart';

class LicenseWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Licença'), centerTitle: true),
        body: Center(
            child: SingleChildScrollView(
                child: FutureBuilder<String>(
                    future:
                        rootBundle.loadString('assets/docs/license.txt'),
                    builder: (BuildContext context,
                        AsyncSnapshot<String> snapshot) {
                      if (snapshot.hasError)
                        return MessageWidget(
                            'Erro ao carregar conteúdo',
                            OMIcons.errorOutline);
                      else
                        return Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(snapshot.data ?? '',
                              textAlign: TextAlign.justify),
                        );
                    }))));
  }
}