class Preguntas {
  List<List<DataPreguntas>>? datos;
  int? total;

  Preguntas();

  Preguntas.fromJson(Map<String, dynamic> json) {
    total = json['Cantidad'];

    List<DataPreguntas> Matricula = [];
    List<DataPreguntas> admision = [];
    if (json['Datos'] != null) {
      datos = [];
      json['Datos'].forEach((v) {
        if(v['info']['Categoria']=="Matricula"){
          Matricula.add(new DataPreguntas.fromJson(v));
        }else {
          admision.add(new DataPreguntas.fromJson(v));
        }
      });
    }
    datos?.add(Matricula);
    datos?.add(admision);
    datos!.forEach((v) {
      v.forEach((e) {
        print(e.Pregunta);
      });
    });
  }

}

class DataPreguntas {
  String? Pregunta;
  String? Respuesta;
  String? IMG;
  List<dynamic>? Enlaces;
  String? Categoria;
  int? id;

  DataPreguntas(
      {this.Pregunta, this.Respuesta, this.IMG, this.Enlaces, this.Categoria});

  DataPreguntas.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    Pregunta = json['info']['Pregunta'];
    Respuesta = json['info']['Respuesta'];
    IMG = json['info']['IMG'];
    Enlaces = json['info']['Enlaces'];
    Categoria = json['info']['Categoria'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['Pregunta'] = Pregunta;
    data['Respuesta'] = Respuesta;
    data['IMG'] = IMG;
    data['Enlaces'] = Enlaces;
    data['Categoria'] = Categoria;
    return data;
  }
}
