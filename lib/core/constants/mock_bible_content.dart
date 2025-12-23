class MockBibleContent {
  static const String loren =
      "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam.";

  static List<String> getVerses(String book, int chapter) {
    if (book == 'Gênesis' && chapter == 1) {
      return [
        "No princípio criou Deus o céu e a terra.",
        "A terra, porém, estava sem forma e vazia; havia trevas sobre a face do abismo, e o Espírito de Deus pairava por sobre as águas.",
        "Disse Deus: Haja luz; e houve luz.",
        "Viu Deus que a luz era boa; e fez separação entre a luz e as trevas.",
        "Chamou Deus à luz Dia e às trevas, Noite. Houve tarde e manhã, o primeiro dia.",
        "E disse Deus: Haja firmamento no meio das águas e separação entre águas e águas.",
        "Fez, pois, Deus o firmamento e separação entre as águas debaixo do firmamento e as águas sobre o firmamento. E assim se fez.",
        "E chamou Deus ao firmamento Céus. Houve tarde e manhã, o segundo dia.",
        "Disse também Deus: Ajuntem-se as águas debaixo dos céus num só lugar, e apareça a porção seca. E assim se fez.",
        "À porção seca chamou Deus Terra e ao ajuntamento das águas, Mares. E viu Deus que isso era bom.",
        "E disse: Produza a terra relva, ervas que deem semente e árvores frutíferas que deem fruto segundo a sua espécie, cuja semente esteja nele, sobre a terra. E assim se fez.",
        "A terra, pois, produziu relva, ervas que davam semente segundo a sua espécie e árvores que davam fruto, cuja semente estava nele, conforme a sua espécie. E viu Deus que isso era bom.",
        "Houve tarde e manhã, o terceiro dia.",
        "Disse também Deus: Haja luzeiros no firmamento dos céus, para fazerem separação entre o dia e a noite; e sejam eles para sinais, para estações, para dias e anos.",
        "E sejam para luzeiros no firmamento dos céus, para alumiar a terra. E assim se fez.",
        "Fez Deus os dois grandes luzeiros: o maior para governar o dia, e o menor para governar a noite; e fez também as estrelas.",
        "E os colocou no firmamento dos céus para alumiarem a terra,",
        "para governarem o dia e a noite e fazerem separação entre a luz e as trevas. E viu Deus que isso era bom.",
        "Houve tarde e manhã, o quarto dia.",
        "Disse também Deus: Povoem-se as águas de enxames de seres viventes; e voem as aves sobre a terra, sob o firmamento dos céus.",
        "Criou, pois, Deus os grandes animais marinhos e todos os seres viventes que rastejam, os quais povoavam as águas, segundo as suas espécies; e todas as aves, segundo as suas espécies. E viu Deus que isso era bom.",
        "E Deus os abençoou, dizendo: Sede fecundos, multiplicai-vos e enchei as águas dos mares; e, na terra, se multipliquem as aves.",
        "Houve tarde e manhã, o quinto dia.",
        "Disse também Deus: Produza a terra seres viventes, conforme a sua espécie: animais domésticos, répteis e bestas-feras da terra, conforme a sua espécie. E assim se fez.",
        "E fez Deus as bestas-feras da terra, conforme a sua espécie, e o gado, conforme a sua espécie, e todo réptil da terra, conforme a sua espécie. E viu Deus que isso era bom.",
        "Também disse Deus: Façamos o homem à nossa imagem, conforme a nossa semelhança; tenha ele domínio sobre os peixes do mar, sobre as aves dos céus, sobre os animais domésticos, sobre toda a terra e sobre todos os répteis que rastejam pela terra.",
        "Criou Deus, pois, o homem à sua imagem, à imagem de Deus o criou; homem e mulher os criou.",
        "E Deus os abençoou e lhes disse: Sede fecundos, multiplicai-vos, enchei a terra e sujeitai-a; dominai sobre os peixes do mar, sobre as aves dos céus e sobre todo animal que rasteja pela terra.",
        "E disse Deus ainda: Eis que vos tenho dado todas as ervas que dão semente e se acham na superfície de toda a terra e todas as árvores em que há fruto que dê semente; isso vos será para mantimento.",
        "E a todos os animais da terra e a todas as aves dos céus e a todos os répteis da terra, em que há fôlego de vida, dou toda erva verde lhes será para mantimento. E assim se fez.",
        "Viu Deus tudo quanto fizera, e eis que era muito bom. Houve tarde e manhã, o sexto dia."
      ];
    } else if (book == 'Salmos' && chapter == 23) {
      return [
        "O Senhor é o meu pastor; nada me faltará.",
        "Ele me faz repousar em pastos verdejantes. Leva-me para junto das águas de descanso.",
        "Refrigera-me a alma. Guia-me pelas veredas da justiça por amor do seu nome.",
        "Ainda que eu ande pelo vale da sombra da morte, não temerei mal nenhum, porque tu estás comigo; o teu bordão e o teu cajado me consolam.",
        "Preparas-me uma mesa na presença dos meus adversários, unges-me a cabeça com óleo; o meu cálice transborda.",
        "Bondade e misericórdia certamente me seguirão todos os dias da minha vida; e habitarei na Casa do Senhor para todo o sempre."
      ];
    } else if (book == 'Mateus' && chapter == 28) {
      return [
        "No findar do sábado, ao entrar o primeiro dia da semana, Maria Madalena e a outra Maria foram ver o sepulcro.",
        "E eis que houve um grande terremoto; porque um anjo do Senhor desceu do céu, chegou-se, removeu a pedra e assentou-se sobre ela.",
        "O seu aspecto era como um relâmpago, e a sua veste, alva como a neve.",
        "E os guardas tremeram espavoridos e ficaram como se estivessem mortos.",
        "Mas o anjo, dirigindo-se às mulheres, disse: Não temais; porque sei que buscais Jesus, que foi crucificado.",
        "Ele não está aqui; ressuscitou, como tinha dito. Vinde ver onde ele jazia.",
        "Ide, pois, depressa e dizei aos seus discípulos que ele ressuscitou dos mortos e vai adiante de vós para a Galileia; ali o vereis. É como vos digo!",
        "E, retirando-se elas apressadamente do sepulcro, tomadas de medo e grande alegria, correram a anunciá-lo aos discípulos.",
        "E eis que Jesus veio ao encontro delas e disse: Salve! E elas, aproximando-se, abraçaram-lhe os pés e o adoraram.",
        "Então, Jesus lhes disse: Não temais! Ide avisar a meus irmãos que se dirijam à Galileia e lá me verão.",
        "Enquanto elas iam, eis que alguns da guarda foram à cidade e contaram aos principais sacerdotes tudo o que sucedera.",
        "Reunindo-se eles em conselho com os anciãos, deram grande soma de dinheiro aos soldados,",
        "recomendando-lhes: Dizei isto: Vieram de noite os discípulos dele e o roubaram enquanto dormíamos.",
        "Caso isto chegue ao conhecimento do governador, nós o persuadiremos e vos poremos em segurança.",
        "Eles, recebendo o dinheiro, fizeram como estavam instruídos. Esta versão divulgou-se entre os judeus até ao dia de hoje.",
        "Seguiram os onze discípulos para a Galileia, para o monte que Jesus lhes designara.",
        "E, quando o viram, o adoraram; mas alguns duvidaram.",
        "Jesus, aproximando-se, falou-lhes, dizendo: Toda a autoridade me foi dada no céu e na terra.",
        "Ide, portanto, fazei discípulos de todas as nações, batizando-os em nome do Pai, e do Filho, e do Espírito Santo;",
        "ensinando-os a guardar todas as coisas que vos tenho ordenado. E eis que estou convosco todos os dias até à consumação do século."
      ];
    } else if (book == 'João' && chapter == 3) {
      return [
        "Havia, entre os fariseus, um homem chamado Nicodemos, um dos principais dos judeus.",
        "Este, de noite, foi ter com Jesus e lhe disse: Rabi, sabemos que és Mestre vindo da parte de Deus; porque ninguém pode fazer estes sinais que tu fazes, se Deus não estiver com ele.",
        "A isto, respondeu Jesus: Em verdade, em verdade te digo que, se alguém não nascer de novo, não pode ver o reino de Deus.",
        "Perguntou-lhe Nicodemos: Como pode um homem nascer, sendo velho? Pode, porventura, voltar ao ventre materno e nascer segunda vez?",
        "Respondeu Jesus: Em verdade, em verdade te digo: quem não nascer da água e do Espírito não pode entrar no reino de Deus.",
        "O que é nascido da carne é carne; e o que é nascido do Espírito é espírito.",
        "Não te admires de eu te dizer: importa-vos nascer de novo.",
        "O vento sopra onde quer, ouves a sua voz, mas não sabes donde vem, nem para onde vai; assim é todo o que é nascido do Espírito.",
        "Então, lhe perguntou Nicodemos: Como pode suceder isto?",
        "Acudiu Jesus: Tu és mestre em Israel e não compreendes estas coisas?",
        "Em verdade, em verdade te digo que nós dizemos o que sabemos e testificamos o que vimos; contudo, não aceitais o nosso testemunho.",
        "Se, tratando de coisas terrenas, não me credes, como crereis, se vos falar das celestiais?",
        "Ora, ninguém subiu ao céu, senão aquele que de lá desceu, a saber, o Filho do Homem [que está no céu].",
        "E do modo por que Moisés levantou a serpente no deserto, assim importa que o Filho do Homem seja levantado,",
        "para que todo o que nele crê tenha a vida eterna.",
        "Porque Deus amou ao mundo de tal maneira que deu o seu Filho unigênito, para que todo o que nele crê não pereça, mas tenha a vida eterna.",
        "Porquanto Deus enviou o seu Filho ao mundo, não para que julgasse o mundo, mas para que o mundo fosse salvo por ele.",
        "Quem nele crê não é julgado; o que não crê já está julgado, porquanto não crê no nome do unigênito Filho de Deus.",
        "O julgamento é este: que a luz veio ao mundo, e os homens amaram mais as trevas do que a luz; porque as suas obras eram más.",
        "Pois todo aquele que pratica o mal aborrece a luz e não se chega para a luz, a fim de não serem arguidas as suas obras.",
        "Quem pratica a verdade aproxima-se da luz, a fim de que seja manifesto que as suas obras são feitas em Deus.",
        "Depois disto, foi Jesus com os seus discípulos para a terra da Judeia; ali permaneceu com eles e batizava.",
        "Ora, João estava também batizando em Enom, perto de Salim, porque havia ali muitas águas, e para lá concorriam e eram batizados.",
        "Pois João ainda não tinha sido encarcerado.",
        "Houve então uma discussão entre os discípulos de João e um judeu a respeito da purificação.",
        "E foram ter com João e lhe disseram: Mestre, aquele que estava contigo além do Jordão, do qual tens dado testemunho, está batizando, e todos lhe saem ao encontro.",
        "Respondeu João: O homem não pode receber coisa alguma se do céu não lhe for dada.",
        "Vós mesmos sois testemunhas de que disse: eu não sou o Cristo, mas fui enviado como seu precursor.",
        "O que tem a noiva é o noivo; o amigo do noivo que está presente e o ouve muito se regozija por causa da voz do noivo. Pois esta alegria já se cumpriu em mim.",
        "Convém que ele cresça e que eu diminua.",
        "Quem vem das alturas certamente está acima de todos; quem vem da terra é terreno e fala da terra; quem veio do céu está acima de todos",
        "e testifica o que viu e ouviu; contudo, ninguém aceita o seu testemunho.",
        "Aquele que aceita o seu testemunho, esse confirma que Deus é verdadeiro.",
        "Pois o enviado de Deus fala as palavras de Deus, porque Deus não dá o Espírito por medida.",
        "O Pai ama ao Filho e tudo confiou às suas mãos.",
        "Por isso, quem crê no Filho tem a vida eterna; o que, todavia, se mantém rebelde contra o Filho não verá a vida, mas sobre ele permanece a ira de Deus."
      ];
    }

    // Fallback for demo
    return List.generate(
      10,
      (index) =>
          "Versículo ${index + 1} de $book $chapter. Este é um texto simulado para preencher os capítulos que não receberam a carga real de dados nesta demonstração.",
    );
  }

  static bool containsQuery(String book, String query) {
    if (book == 'Gênesis') {
        return getVerses('Gênesis', 1).any((v) => v.toLowerCase().contains(query.toLowerCase()));
    } else if (book == 'Salmos') {
      return getVerses('Salmos', 23).any((v) => v.toLowerCase().contains(query.toLowerCase()));
    } else if (book == 'João') {
        return getVerses('João', 3).any((v) => v.toLowerCase().contains(query.toLowerCase()));
    }
    return book.toLowerCase().contains(query.toLowerCase());
  }
}
