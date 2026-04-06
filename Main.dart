import 'dart:io';

class Tarefa {
  int id;
  String titulo;
  String? descricao;
  bool concluida;

  Tarefa(this.id, this.titulo, {this.descricao, this.concluida = false});

  @override
  String toString() {
    return '[$id] ${concluida ? "[✔]" : "[ ]"} $titulo'
        '${descricao != null ? " - $descricao" : ""}';
  }
}

class GerenciadorDeTarefas {
  final List<Tarefa> _tarefas = [];
  int _contadorId = 1;

  void criarTarefa(String titulo, {String? descricao}) {
    _tarefas.add(Tarefa(_contadorId++, titulo, descricao: descricao));
    print("Tarefa criada!");
  }

  void listarTarefas() {
    if (_tarefas.isEmpty) {
      print("Nenhuma tarefa.");
      return;
    }
    for (var t in _tarefas) {
      print(t);
    }
  }

  void editarTarefa(int id, String titulo, {String? descricao}) {
    var t = _buscar(id);
    if (t != null) {
      t.titulo = titulo;
      t.descricao = descricao;
      print("Atualizada!");
    } else {
      print("Não encontrada.");
    }
  }

  void excluirTarefa(int id) {
    _tarefas.removeWhere((t) => t.id == id);
    print("Removida!");
  }

  void alternarStatus(int id) {
    var t = _buscar(id);
    if (t != null) {
      t.concluida = !t.concluida;
      print("Status alterado!");
    }
  }

  Tarefa? _buscar(int id) {
    for (var t in _tarefas) {
      if (t.id == id) return t;
    }
    return null;
  }
}

void main() {
  var gerenciador = GerenciadorDeTarefas();

  while (true) {
    print('\n1 Criar | 2 Listar | 3 Editar | 4 Excluir | 5 Concluir | 0 Sair');
    stdout.write('Opção: ');
    var op = stdin.readLineSync();

    switch (op) {
      case '1':
        stdout.write('Título: ');
        var titulo = stdin.readLineSync() ?? '';

        stdout.write('Descrição: ');
        var desc = stdin.readLineSync();

        gerenciador.criarTarefa(titulo, descricao: desc);
        break;

      case '2':
        gerenciador.listarTarefas();
        break;

      case '3':
        stdout.write('ID: ');
        var id = int.tryParse(stdin.readLineSync() ?? '');

        if (id != null) {
          stdout.write('Novo título: ');
          var titulo = stdin.readLineSync() ?? '';

          stdout.write('Nova descrição: ');
          var desc = stdin.readLineSync();

          gerenciador.editarTarefa(id, titulo, descricao: desc);
        }
        break;

      case '4':
        stdout.write('ID: ');
        var id = int.tryParse(stdin.readLineSync() ?? '');
        if (id != null) gerenciador.excluirTarefa(id);
        break;

      case '5':
        stdout.write('ID: ');
        var id = int.tryParse(stdin.readLineSync() ?? '');
        if (id != null) gerenciador.alternarStatus(id);
        break;

      case '0':
        print('Saindo...');
        return;

      default:
        print('Inválido!');
    }
  }
}






