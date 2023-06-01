algoritmo "semnome"
// Função :
// Autor :
// Data : 05/11/2020
// Seção de Declarações
var
opcao,x,y,z,nLinhas,nColunas,n,nII, parSelecionado,valorMinAtual,valorMaxAtual, colunaSelecionada,linhaSelecionada, totalNAssimilado, nParesUtilizados, fase, falhas, score, recorde, ultimapontuacao: inteiro
linha, coluna: vetor [1..2] de inteiro
geraIcognitas: vetor [1..7,1..12] de caractere
geraPares: vetor [1..7,1..12] de caractere
pares: vetor [1..42] de caractere
pontuador: vetor [1..4] de real
lacuna: caractere
tdsParesPreenchidos, geracaoFinalizada, parNUtilizadoEncontrado,tdsParesUtilizados, primeiraFiguraEscolhida, comparacaoFeita, mapaCompleto, desejaSair,segundaFiguraEscolhida,mostrarMapas: logico
paresFoiUsadoOuNao: vetor [1..42] de logico

procedimento Comeco
inicio
//NOTAS PARA O PROFESSOR LER, POR FAVOR LER
//Bom dia professor, eu gostaria de esclarecer algumas coisas que ocorrem com este software
//O software por algum motivo as vezes da um erro de acesso inválido de memória "Access violation at address xxxx in module"
//Este erro ocorre aleatoriamente, eu ja tentei verificar o código completamente e não consigo ver nada que aponte o ocorrimento
//Deste erro, então estou começando a ficar convicto de que a resolução deste erro esta fora do meu controle, fiz algumas pesquisas
//e algumas pessoas disseram que isto esta relacionado a versões modernas do windows, porém não tenho certeza, vale lembrar que este erro
//é um erro de c não de visualg que ocorre, espero que o senhor entenda caso este erro apareça
//Além disso, caso o senhor esteja usando a versão 2 do visualg, na hora de digitar os valores númericos, e você acidentalmente apertar
//Enter ou digitar uma letra, ele dara um erro do valor recebido não ser inteiro, mas se você der ok no erro você pode voltar ao visualg
//E digitar o valor correto novamente, assim não precisa-se recomeçar o programa inteira, so para deixar claro.

mostrarMapas <- verdadeiro
falhas <- 0
desejaSair <- falso
primeiraFiguraEscolhida <- falso
comparacaoFeita <- falso
score <- 0
fase <- 1
limpatela
Escreval("=============================")
Escreval("Bem vindo ao jogo da memória 2000!")
Escreval("1-Jogar")
Escreval("2-Instruções")
Escreval("3-Score")
Escreval("4-Créditos")
Escreval("=============================")
Leia(opcao)

escolha opcao
caso 1
   Jogar()
caso 2
   Instrucoes()
caso 3
   mostraScore
caso 4
   Creditos()
fimescolha
fimalgoritmo
fimprocedimento

procedimento MostrarMapa(nLinhas,nColunas: inteiro; dificuldade:caractere)

inicio
limpatela
Escreval("Dificuldade desta fase: ",dificuldade)
Escreval("Falhas: ", falhas)
Escreval("Seu score: ",score)
Escreva("  ")
para y de 1 ate nColunas faca
Escreva(y, "")
fimpara
Escreval()

//para x de 1 ate 7 faca
para x de 1 ate nLinhas faca
   Escreva(x, " ")
   para y de 1 ate 12 faca
      se (y < 10) entao
         Escreva(geraIcognitas[x,y]," ")
      senao
         se(y>9) entao
            Escreva(geraIcognitas[x,y],"  ")
         fimse
      fimse
   fimpara
   Escreval()
fimpara

se (mostrarMapas = verdadeiro) entao
   Escreval("  ")
   Escreva("  ")
   para y de 1 ate nColunas faca
      Escreva(y, "")
   fimpara
   Escreval()

   //para x de 1 ate 7 faca
      para x de 1 ate nLinhas faca
         Escreva(x, " ")
         para y de 1 ate 12 faca
            se (y < 10) entao
               Escreva(geraPares[x,y]," ")
            senao
               se(y > 9) entao
                  Escreva(geraPares[x,y],"  ")
               fimse
            fimse
         fimpara
         Escreval()
      fimpara
   fimse



   se (desejaSair = verdadeiro) entao
      Escreval("Deseja continuar jogando ou quer recolher sua pontuação?")
      Escreval("Digite 1 para continuar jogando")
      Escreval("Digite 2 para sair e recolher a pontuação")
      Leia(lacuna)
      escolha lacuna
      caso "1"
         desejaSair <- falso
         MostrarMapa(nLinhas,nColunas,dificuldade)
      caso "2"
         creditosFinais()
      fimescolha
   fimse
   se((primeiraFiguraEscolhida = verdadeiro) ou (segundaFiguraEscolhida = verdadeiro)) entao
      Escreval("Primeira figura selecionada: ", geraPares[linha[1],coluna[1]])
   fimse
   se (segundaFiguraEscolhida = verdadeiro) entao
      Escreval("Segunda figura selecionado: ", geraPares[linha[2],coluna[2]])
   fimse

   se (comparacaoFeita = verdadeiro) entao
      comparacaoFeita <- falso
      segundaFiguraEscolhida <- falso
      se (geraIcognitas[linha[1],coluna[1]] = geraIcognitas[linha[2],coluna[2]]) entao
         Escreval ("Acertou, as figuras são iguais!")
         somaScore(nLinhas,nColunas)
         Leia(lacuna)
         analisaMapaCompleto(nLinhas,nColunas)
      fimse
      se (geraIcognitas[linha[1],coluna[1]] <> geraIcognitas[linha[2],coluna[2]]) entao
         Escreval("Errou, as figuras são diferentes!")
         falhas <- falhas + 1
         Leia(lacuna)
         geraIcognitas[linha[1],coluna[1]] <- "."
         geraIcognitas[linha[2],coluna[2]] <- "."
      fimse

      MostrarMapa(nLinhas,nColunas, dificuldade)
   fimse

   escolha primeiraFiguraEscolhida
   caso falso
      Escreval("Digite a linha da primeira figura")
      Leia(linha[1])
      Escreval("Digite a coluna da primeira figura")
      Leia(coluna[1])

   caso verdadeiro
      Escreval("Digite a linha da segunda figura")
      Leia(linha[2])
      Escreval("Digite a coluna da segunda figura")
      Leia(coluna[2])
   fimescolha

   mudaValoresIcognita(nLinhas,nColunas,dificuldade)

fimalgoritmo
fimprocedimento

procedimento mudaValoresIcognita(nLinhas,nColunas:inteiro; dificuldade: caractere)
inicio

escolha primeiraFiguraEscolhida
caso falso
   se ((linha[1] > nLinhas) ou (coluna[1] > nColunas) ou (linha[1] < 1) ou (coluna[1] < 1)) entao
      Escreval("Você selecionou uma posição inexistente! selecione novamente")
      leia(lacuna)
      MostrarMapa(nLinhas,nColunas, dificuldade)
   fimse
   se ((geraIcognitas[linha[1],coluna[1]]) <> (".")) entao
      Escreval("Esta figura ja foi acertada! escolha outra figura")
      leia(lacuna)
      MostrarMapa(nLinhas,nColunas, dificuldade)
   fimse
   geraIcognitas[linha[1],coluna[1]] <- geraPares[linha[1],coluna[1]]
   primeiraFiguraEscolhida <- verdadeiro
   MostrarMapa(nLinhas,nColunas, dificuldade)
caso verdadeiro
   se ((linha[2] > nLinhas) ou (coluna[2] > nColunas) ou (linha[2] < 1) ou (coluna[2] < 1)) entao
      primeiraFiguraEscolhida <- verdadeiro
      Escreval("Você selecionou uma posição inexistente! selecione novamente")
      leia(lacuna)
      MostrarMapa(nLinhas,nColunas, dificuldade)
   fimse

   se ((linha[1] = linha[2]) e (coluna[1] = coluna[2])) entao
      primeiraFiguraEscolhida <- verdadeiro
      Escreval("Você escolheu a mesma figura! escolha outra")
      leia(lacuna)
      MostrarMapa(nLinhas,nColunas, dificuldade)
   fimse
   se ((geraIcognitas[linha[2],coluna[2]]) <> (".")) entao
      primeiraFiguraEscolhida <- verdadeiro
      Escreval("Esta figura ja foi acertada! escolha outra figura")
      leia(lacuna)

      MostrarMapa(nLinhas,nColunas, dificuldade)
   fimse
   segundaFiguraEscolhida <- verdadeiro
   geraIcognitas[linha[2],coluna[2]] <- geraPares[linha[2],coluna[2]]
   comparacaoFeita <- verdadeiro
   primeiraFiguraEscolhida <- falso
   MostrarMapa(nLinhas,nColunas, dificuldade)
fimescolha

fimprocedimento

procedimento somaScore (nLinhas,nColunas:inteiro)
inicio
pontuador[1] <- ((nLinhas * nColunas) / 2)
pontuador[2] <- ((nLinhas * nColunas) / 2) + ((nLinhas * nColunas) / 4)
pontuador[3] <- ((nLinhas * nColunas) / 2) + ((nLinhas * nColunas) / 4) + ((nLinhas * nColunas) / 8)
se (falhas <= pontuador[1])  entao
   score <- score + 100
fimse
se ((pontuador[1] < falhas) e (falhas <= pontuador[2]))  entao
   score <- score + 75
fimse
se ((pontuador[2] < falhas) e (falhas <= pontuador[3]))  entao
   score <- score + 50
fimse
se (pontuador[3] < falhas)  entao
   score <- score + 25
fimse
fimprocedimento

procedimento analisaMapaCompleto(nLinhas,nColunas:inteiro)
inicio
mapaCompleto <- verdadeiro
para x de 1 ate nLinhas faca
   para y de 1 ate nColunas faca
      se (geraIcognitas[x,y] = ".") entao
         mapaCompleto <- falso
      //senao
      fimse
   fimpara
fimpara
se (mapaCompleto = verdadeiro) entao
   fase <- fase + 1
   escolheFase()
fimse

fimprocedimento

procedimento assimilaValoresDeMatrizes(nLinhas,nColunas: inteiro)
inicio
para x de 1 ate 7 faca
   para y de 1 ate 12 faca
      geraIcognitas[x,y] <- ""
   fimpara
fimpara
para x de 1 ate nLinhas faca
   para y de 1 ate nColunas faca
      geraIcognitas[x,y] <- "."
   fimpara
fimpara
fimprocedimento


procedimento GerarMapa(nLinhas,nColunas: inteiro; dificuldade: caractere)
inicio
Escreval("Gerando mapa...")
tdsParesPreenchidos <- falso
geracaoFinalizada <- falso
totalNAssimilado <- 0
tdsParesUtilizados <- falso
nParesUtilizados <- 0
para x de 1 ate 42 faca
   paresFoiUsadoOuNao[x] <- falso
fimpara

para x de 1 ate 7 faca
   para y de 1 ate 12 faca
      geraPares[x,y] <- ""
   fimpara
fimpara

enquanto (tdsParesPreenchidos = falso) faca
   tdsParesPreenchidos <- verdadeiro
   para x de 1 ate nLinhas faca
      para y de 1 ate nColunas faca
         se (geraPares[x,y] = "") entao
            tdsParesPreenchidos <- falso

            parNUtilizadoEncontrado <- falso
            enquanto ((parNUtilizadoEncontrado = falso) e (tdsParesUtilizados = falso)) faca
               parSelecionado <- randi(42)+1
               escolha paresFoiUsadoOuNao[parSelecionado]
               caso falso
                  paresFoiUsadoOuNao[parSelecionado] <- verdadeiro
                  parNUtilizadoEncontrado <- verdadeiro
                  nParesUtilizados <- nParesUtilizados + 1
                  se (nParesUtilizados = 42) entao
                     tdsParesUtilizados <- verdadeiro
                  fimse
               caso verdadeiro
                  parNUtilizadoEncontrado <- falso
               fimescolha
            fimenquanto

            y <- 0
            enquanto ((y < 2) e (geracaoFinalizada = falso)) faca

               linhaSelecionada <- randi(nLinhas)+1
               colunaSelecionada <- randi(nColunas)+1

               se (geraPares[linhaSelecionada,colunaSelecionada] = "") entao
                  geraPares[linhaSelecionada,colunaSelecionada] <- pares[parSelecionado]

                  y <- y + 1
                  totalNAssimilado <- totalNAssimilado + 1
                  se (totalNAssimilado = nLinhas*nColunas) entao
                     geracaoFinalizada <- verdadeiro
                  fimse
               fimse
            fimenquanto
         fimse
      fimpara
   fimpara
fimenquanto

MostrarMapa(nLinhas, nColunas, dificuldade)


fimprocedimento

procedimento escolheFase()
inicio
falhas <- 0
escolha fase
caso 1
   GerarMapa(4,6, "Fácil")
caso 2
   desejaSair <- verdadeiro
   assimilaValoresDeMatrizes(5,8)
   GerarMapa(5,8, "Médio")
caso 3
   desejaSair <- verdadeiro
   assimilaValoresDeMatrizes(6,10)
   GerarMapa(6,10, "Dificil")
caso 4
   desejaSair <- verdadeiro
   assimilaValoresDeMatrizes(7,12)
   GerarMapa(7,12, "Dificílimo")
caso 5
   creditosFinais()
fimescolha
fimprocedimento

procedimento creditosFinais()
inicio
limpatela
ultimapontuacao <- score
Escreval("===Fim de jogo!!!===")
Escreval("Seu score total foi de: ", score)
se (score > recorde) entao
   recorde <- score
   Escreval("Você bateu um novo recorde de ",recorde," pontos")
fimse
Escreval("Aperte enter para voltar ao menu.")
Leia(lacuna)
Comeco()
fimprocedimento


procedimento assimiladorDePares()
inicio
n <- 0
para nII de 65 ate 90 faca
   n <- n + 1
   pares[n] <- Carac(nII)
fimpara

para nII de 48 ate 57 faca
   n <- n + 1
   pares[n] <- Carac(nII)
fimpara
pares[37] <- "$"
pares[38] <- "&"
pares[39] <- "%"
pares[40] <- "@"
pares[41] <- "#"
pares[42] <- "="
fimprocedimento

procedimento Jogar
inicio
limpatela
assimiladorDePares
assimilaValoresDeMatrizes(4,6)
escolheFase()
fimprocedimento

procedimento Instrucoes
inicio
limpatela
Escreval("=================================================================")
Escreval ("O jogo se baseia em um jogo de memória, o jogador deve escolher")
Escreval ("duas posições diferente no mapa,com essas posições contendo")
Escreval ("diferentes figuras, se as figuras forem semelhantes, o jogador")
Escreval ("marca uma quantidade de pontos dependendo da quantidade de falhas")
Escreval ("dele, e as duas figuras selecionadas ficam permanentemente viradas")
Escreval ("até o jogador completar a fase, se ele errar as figuras são")
Escreval ("viradas para baixo novamente e ele ganha uma falha a mais no")
Escreval("contador.")
Escreval("")
Escreval("Dependendo da quantidade de falhas que o jogador tem naquela fase")
Escreval("ele pode marcar menos pontos, a fase acaba quando todas as figuras")
Escreval("forem viradas pra cima, e então o jogador é levado a uma fase com")
Escreval("uma dificuldade maior, a cada nova fase o jogador tem a opção de")
Escreval("parar de jogar e recolher a pontuação atual dele para o score, o")
Escreval("jogo acaba ou quando o jogador completa todas as fases, ou quando")
Escreval("ele seleciona a opção de parar de jogar. As figuras podem variar")
Escreval("de letras para números até símbolos.")
Escreval("=================================================================")
Escreval ("Digite 1 para voltar")
Leia(opcao)
se (opcao = 1) entao
   Comeco
fimse
fimprocedimento

procedimento mostraScore
inicio
limpatela
Escreval ("Sua última pontuação: ",ultimapontuacao)
Escreval ("Seu recorde: ",recorde)
Escreval ("Digite 1 para voltar")
Leia(opcao)
se (opcao = 1) entao
   Comeco
fimse
fimprocedimento

procedimento Creditos
inicio
limpatela
Escreval ("Lucas Arthur Campesatto Mella")
Escreval ("ESOFT 2020 2º Semestre")
Escreval ("RA: 20072665-2")
Escreval ("Digite 1 para voltar")
Leia(opcao)
se (opcao = 1) entao
   Comeco
fimse
fimprocedimento


inicio
Comeco()
fimalgoritmo
