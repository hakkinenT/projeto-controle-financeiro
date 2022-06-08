import '/models/models.dart';

const Person person = Person(
    email: 'email@hotmail.com', name: 'João', userId: 'ifjngkleg9eu9r399');

List<Income> incomes = [
  const Income(
      description: 'Salário', value: 2000, type: Type.fixed, person: person),
  const Income(
      description: 'Rendimento FIIs',
      value: 240,
      type: Type.variable,
      person: person),
  const Income(
      description: 'Rendimento de Ações',
      value: 3000,
      type: Type.variable,
      person: person),
  const Income(
      description: 'Aluguel Apartamento',
      value: 540,
      type: Type.fixed,
      person: person),
];
