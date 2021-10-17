
class Persona {
  String name = 'name_not_set';
  String desc = 'desc_not_set';
  List<String> personality = <String>['not_set'];
  List<String> topics = <String>['no topic'];
  String svgAsset = 'not_set';

  Persona(this.name, this.desc, this.personality, this.topics, this.svgAsset);

  static Map<String, Persona> get _allPersona => {
    'Antivacina': Persona('Antivacina',
        'São pessoas que defendem que os imunizantes não protegem contras as doenças e ainda colocam a saúde em risco.',
        ['Cético', 'Egocêntrico', 'Conspiracionista'],
        ['Ciência', 'Bem estar', 'Saúde'],
        'assets/images/bodyAntivax.svg'),
    'Bonosaro': Persona('Bonosaro',
        'Atual presidente do Brasil e militar aposentado. Político da extrema direita.',
        ['Asertividade', 'Radical', 'Agressividade'],
        ['Política', 'Economia', 'Imigrantes'],
        'assets/images/bodyBonosaro.svg'),
    'Eron Must': Persona('Eron Must',
        'Empreendedor e filantropo. Bilionário.',
        ['Influência', 'Realização', 'Originalidade'],
        ['Tecnologia', 'Inovação', 'Ciência'],
        'assets/images/bodyEronMust.svg'),
    'Lulo': Persona('Lulo',
        'Ex-presidente do Brasil e ex-sindicalista. Político da esquerda.',
        ['Entusiasmo', 'Determinado', 'Cooperação'],
        ['Política', 'Economia','Meio Ambiente'],
        'assets/images/bodyLulo.svg'),
    'Salvio': Persona('Salvio',
        'Apresentador de televisão e empresário brasileiro, com mais de sessenta anos de carreira.',
        ['Espontaneidade', 'Alegria', 'Popularidade'],
        ['Pop & Arte', 'Negócios', 'Carreira'],
        'assets/images/bodySalvio.svg'),
    'Tia do zap': Persona('Tia do Zap',
        'Aquela pessoa que acredita em tudo que lê e espalha fake news.',
        ['Imprudente', 'Ansiosa', 'Solidäo'],
        ['Pop & Arte', 'Política', 'Educação'],
        'assets/images/bodyTiaDoZap.svg'),
    'Tump': Persona('Tump',
        'Ex-presidente dos EUA, do partido republicano.',
        ['Resistência', 'Orgulho', 'Espontaneidade'],
        ['Política', 'Mundo', 'Economia'],
        'assets/images/bodyTump.svg'),
    'Vegana': Persona('Vegana',
        'Não consome e não usa produto de origem animal.',
        ['Consciência', 'Liberdade', 'Prudência'],
        ['Meio Ambiente', 'Saúde', 'Bem estar'],
        'assets/images/bodyVegan.svg')
  };

  static Persona getPersona(String name) {
    Persona? p = _allPersona[name];
    // TODO: Log error in case p is null?
    return p ?? Persona('No name', 'No desc', ['No traits'], ['No topics'], 'assets/images/Random.svg');
  }
}
