import '../models/models.dart';

const Person person = Person(
    email: 'email@hotmail.com', name: 'João', userId: 'ifjngkleg9eu9r399');

List<Expenses> expenses = [
  Expenses(
      description: 'Conta de luz',
      value: 230,
      category: Category.essential,
      type: Type.fixed,
      person: person,
      expirationDate: DateTime(2022, 05, 01)),
  Expenses(
      description: 'Conta de água',
      value: 100,
      category: Category.essential,
      type: Type.fixed,
      person: person,
      expirationDate: DateTime(2022, 05, 01)),
  Expenses(
      description: 'Netflix',
      value: 29.90,
      category: Category.nonEssential,
      type: Type.fixed,
      person: person,
      expirationDate: DateTime(2022, 05, 01)),
  Expenses(
      description: 'Internet',
      value: 190,
      category: Category.essential,
      type: Type.fixed,
      person: person,
      expirationDate: DateTime(2022, 05, 01)),
  Expenses(
      description: 'TV a cabo',
      value: 200,
      category: Category.nonEssential,
      type: Type.fixed,
      person: person,
      expirationDate: DateTime(2022, 05, 01)),
  Expenses(
      description: 'Conserto do ar condicionado',
      value: 100,
      category: Category.essential,
      type: Type.variable,
      person: person,
      expirationDate: DateTime(2022, 05, 01)),
  Expenses(
      description: 'Pintura da casa',
      value: 1000,
      category: Category.essential,
      type: Type.variable,
      person: person,
      expirationDate: DateTime(2022, 05, 01)),
];
