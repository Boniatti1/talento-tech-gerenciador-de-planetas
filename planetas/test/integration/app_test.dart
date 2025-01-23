import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:planetas/main.dart' as app;
import 'package:flutter/material.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() async {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
    String dbPath = await databaseFactory.getDatabasesPath();
    await deleteDatabase(dbPath);
  });


  testWidgets(
      'Deve adicionar um planeta, exibí-lo na lista, permitir atualização e exclusão',
      (WidgetTester tester) async {
    // Inicia a aplicação
    app.main();
    await tester.pumpAndSettle();

    // Interage com o botão de adicionar
    final addButton = find.byIcon(Icons.add);
    await tester.tap(addButton);
    await tester.pumpAndSettle();

    // Campos de texto para interação
    final nameField = find.ancestor(
      of: find.text('Nome'),
      matching: find.byType(TextFormField),
    );

    final descriptionField = find.ancestor(
      of: find.text('Descrição'),
      matching: find.byType(TextFormField),
    );

    final diameterField = find.ancestor(
      of: find.text('Diâmetro em km'),
      matching: find.byType(TextFormField),
    );

    final distanceField = find.ancestor(
      of: find.text('Distância do Sol em U.A.'),
      matching: find.byType(TextFormField),
    );

    await tester.pumpAndSettle();

    // Insere os dados
    await tester.enterText(nameField, "Marte");
    await tester.enterText(descriptionField, "Planeta vermelho");
    await tester.enterText(diameterField, "6800");
    await tester.enterText(distanceField, "1.5");

    // Salva o planeta
    final saveButton = find.text('Salvar');
    await tester.tap(saveButton);
    await tester.pumpAndSettle();

    // Verifica se o planeta aparece na lista
    expect(find.text('Planeta vermelho'), findsOneWidget);
    expect(find.text('Marte'), findsOneWidget);
    expect(find.text('6800.0 km'), findsOneWidget);
    expect(find.text('1.5 U.A.'), findsOneWidget);

    // Clica no planeta para atualizar
    final planet = find.text('Marte');
    await tester.tap(planet);
    await tester.pumpAndSettle();

    final nameUpdateField = find.ancestor(
      of: find.text('Nome'),
      matching: find.byType(TextFormField),
    );

    final descriptionUpdateField = find.ancestor(
      of: find.text('Descrição'),
      matching: find.byType(TextFormField),
    );

    final distanceUpdateField = find.ancestor(
      of: find.text('Distância do Sol em U.A.'),
      matching: find.byType(TextFormField),
    );

    final diameterUpdateField = find.ancestor(
      of: find.text('Diâmetro em km'),
      matching: find.byType(TextFormField),
    );

    // Atualiza os dados
    await tester.enterText(nameUpdateField, "Teste");
    await tester.enterText(descriptionUpdateField, "teste");
    await tester.enterText(distanceUpdateField, "1.3");
    await tester.enterText(diameterUpdateField, "3000");

    final updateSaveButton = find.text('Salvar');
    await tester.tap(updateSaveButton);
    await tester.pumpAndSettle();

    // Verifica se foi atualizado
    expect(find.text('Teste'), findsOneWidget);
    expect(find.text('teste'), findsOneWidget);
    expect(find.text('1.3 U.A.'), findsOneWidget);
    expect(find.text('3000.0 km'), findsOneWidget);

    // Entra no planeta atualizado para exclusão
    final planetUpdated = find.text('Teste');
    await tester.tap(planetUpdated);
    await tester.pumpAndSettle();

    final exclude = find.byIcon(Icons.delete_outline);
    await tester.tap(exclude);   
    await tester.pumpAndSettle();
    
    final confirm = find.text("Excluir");
    await tester.tap(confirm);
    await tester.pumpAndSettle();

    // Verifica se foi exluído
    expect(find.text('Teste'), findsNothing);

  });
}
