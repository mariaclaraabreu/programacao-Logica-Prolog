% Questao 1

pai(ivo,eva).
pai(gil,rai).
pai(gil,clo).
pai(gil,ary).
pai(rai,noe).
pai(ary,gal).
mae(ana,eva).
mae(bia,rai).
mae(bia,clo).
mae(bia,ary).
mae(eva,noe).
mae(lia,gal).
homem(ivo).
homem(gil).
homem(rai).
homem(ary).
homem(noe).
mulher(ana).
mulher(bia).
mulher(eva).
mulher(clo).
mulher(lia).
mulher(gal).

gerou(X,Y) :- pai(X,Y) ; mae(X,Y).

filho(X,Y) :- gerou(Y,X) , homem(X).
filha(X,Y) :- gerou(Y,X) , mulher(X).
irmao(X,Y) :- gerou(Z,X) , gerou(Z,Y) , X =\= Y , homem(X).
irma(X,Y)  :- gerou(Z,X) , gerou(Z,Y) , X =\= Y , mulher(X).
tio(X,Y)   :- irmao(X,Z) , gerou(Z,Y).
tia(X,Y)   :- irma(X,Z)  , gerou(Z,Y).
primo(X,Y) :- filho(X,Z) , tio(Z,Y).
primo(X,Y) :- filho(X,Z) , tia(Z,Y).
prima(X,Y) :- filha(X,Z) , tio(Z,Y).
prima(X,Y) :- filha(X,Z) , tia(Z,Y).
avô(X,Y)   :- pai(X,Z)   , gerou(Z,Y).
avó(X,Y)   :- mae(X,Z)   , gerou(Z,Y).

% Questao 2

feliz(X) :- filho(_,X) ; filha(_,X).
casal(X,Y) :- filho(Z,X),filho(Z,Y),X \= Y.
casal(X,Y) :- filha(Z,X),filha(Z,Y),X \= Y.

% Questao 3

%país(Nome,Área,População)
país(brasil, 9, 130).
país(china ,12,1800).
país(eua   , 9, 230).
país(india , 3, 450).

densidade(X,Y) :- país(X,A,P), Y is P/A.

% Qual a densidade demografica de cada um dos países?
% ?- densidade(X,Y).

% A Índia é mais populosa do que a China?
% ?- país(india,_,X) , país(china,_,Y) , X > Y.

% Questao 4

% filme(Título,Gênero,Ano,Duracao)
filme('Uma linda mulher',romance ,1990,119).
filme('Sexto sentido'   ,suspense,2001,108).
filme('A cor púrpura'   ,drama   ,1985,152).
filme('Copacabana'      ,comédia ,2001, 92).
filme('E o vento levou' ,drama   ,1939,233).
filme('Carrington'      ,romance ,1995,130).

filmeClassico(X) :- filme(X,_,A,_) , A =< 1985.
filmeLongo(X)    :- filme(X,_,_,D) , D > 150.

% Questao 5

func(1,'André'  ,1000).
func(2,'Bruno'  ,1200).
func(3,'Carlos' , 903).
func(4,'Diego'  ,2500).
func(5,'Eduardo',1800).
func(6,'Flavio' ,1100).

dep(1,'Carla' ).
dep(3,'Rute'  ).
dep(3,'Diana' ).
dep(4,'Maria' ).
dep(4,'Daniel').
dep(5,'Paulo' ).

% Quem são os dependentes de Carlos?
% ?- func(C,'Carlos',_) , dep(C,X).

% Quem tem salário entre R$1500 e R$3000?
% ?- func(_,N,S) , S > 1500 , S < 3000.

% Quem não tem dependentes e ganha menos de R$1200?
% ?- func(C,N,S) , S < 1200 , \+ dep(C,_).

% Quem depende de funcionário que ganha mais de R$1700?
% ?- func(C,_,S) , S > 1700 , dep(C,N).

% Questao 6

academia('Ana' ,fem ,23,1.55,56.0).
academia('Bia' ,fem ,19,1.71,61.3).
academia('Luke',masc,22,1.80,70.5).
academia('Lia' ,fem ,17,1.85,57.3).
academia('Eva' ,fem ,28,1.75,68.7).
academia('Rob' ,masc,25,1.72,68.9).

% Quais as mulheres com mais de 20 anos de idade?
% ?- academia(N,fem,I,_,_) , I > 20.

% Quem tem pelo menos 1.70m de altura e menos de 65kg?
% ?- academia(N,_,_,A,M) , A >= 1.7 , M < 65.

% Quais são os possíveis casais onde o homem é mais alto do que a mulher?
% ?- academia(H,masc,_,AH,_) , academia(M,fem,_,AM,_) , AH > AM.

% Questao 7

joga(ana,volei   ).
joga(bia,tenis   ).
joga(cid,basquete).
joga(eva,volei   ).
joga(leo,tenis   ).

% Não há como desenhar a árvore aqui, mas a explicação seria essa...

% Item a
% ?- joga(P,X), joga(leo,X), P \= leo.
% joga(P,X) encaixa com o primeiro fato joga(ana,volei). Logo P = ana, X = volei. A consulta vira:
% ? joga(leo,volei), ana \= leo.
% não existe o fato joga(leo,volei). Volta uma consulta.
% joga(P,X) encaixa com o segundo fato joga(bia,tennis). Logo P = bia, X = tenis. A consulta vira:
% ?- joga(leo,tennis), bia \= leo.
% existe o fato joga(leo,tennis). A consulta vira:
% ?- bia \= leo. Retornando true. Apertando ponto-e-vírgula, busca-se novas solução.
% Note que a primeira pergunta encaixa com qualquer fato, isso faz descer na busca, mas só na segunda é que veremos se a consulta encaixa com o fato pedido.

% Item b
% ?- joga(leo,X), joga(P,X), P \= leo.
% joga(leo,X) encaixa apenas com o fato joga(leo,tenis). Logo X = tenis. A consulta vira:
% ?- joga(P,tenis), P \= leo.
% joga(P,tenis) encaixa com o segundo fato joga(bia,tenis). Logo, P = bia. A consulta vira:
% ?- bia \= leo. Retornando true. Apertando ponto-e-vírgula, volta-se a última consulta e...
% joga(P,tenis) encaixa com o último fato joga(leo,tennis). Logo P = leo. A consulta vira:
% ?- leo \= leo. Retornando false. 
% Note que a primeira pergunta já filtra mais as soluções, porque apenas as pessoas que jogam tênis serão consultadas depois.


% Questao 8

prod(_,0,0).
prod(X,1,X).
prod(X,Y,Z) :- Y2 is Y-1, prod(X,Y2,Z2) , Z is Z2 + X.

% Questao 9

ultimo([X],X).
ultimo([_|As],B) :- ultimo(As,B).

tamanho([],0).
tamanho([_|As],N) :- tamanho(As,M) , N is M+1.

soma([],0).
soma([A|As],S) :- soma(As,S2), S is A+S2.

maximo([A],A).
maximo([A|As],A) :- maximo(As,M), A >= M.
maximo([A|As],M) :- maximo(As,M), A < M.

% Questao 10

d(0,zero).
d(1,um).
d(2,dois).
d(3,tres).
d(4,quatro).
d(5,cinco).
d(6,seis).
d(7,sete).
d(8,oito).
d(9,nove).

texto([],[]).
texto([A|As],[B|Bs]) :- d(A,B) , texto(As,Bs).

% Questao 11

estrada(a,b,25).
estrada(a,d,23).
estrada(b,c,19).
estrada(b,e,32).
estrada(c,d,14).
estrada(c,f,28).
estrada(d,f,30).
estrada(e,f,26).

distancia(A,B,D) :- estrada(A,B,D).
distancia(A,B,D) :- estrada(A,C,D1),distancia(C,B,D2), D is D1+D2.

rota(A,B,[A,B]) :- estrada(A,B,_).
rota(A,B,[A|As]) :- estrada(A,C,_),rota(C,B,As).

% Questao 12

%carro(Dono,Nome,dataCompra(Dia,Mes,Ano),Km,placa(Cidade,Letras,Numeros)).

% ?- carro(X,_,dataCompra(_,_,2001),_,placa(russas,_,_)).
% Nome das pessoas que compraram carros em Russas no ano de 2001

%Questao 13

% Nomes dos livros e autores dos autores nascidos no Reino Unido.

% Questao 14

removeUltimo([A],[]).
removeUltimo([A|As],[A|Bs]) :- removeUltimo(As,Bs).

% Questao 15

%governou(X,I,F) ↔ O presidente X governou o Brasil do ano I ao ano F.
governou(fernandoCollor  ,1990,1992).
governou(itamarFranco    ,1992,1995).
governou(fernandoHenrique,1995,2003).
governou(lula            ,2003,2011).

sucessor(X,Y) :- governou(Y,A,_), governou(X,_,A).

% Questao 16

%animal(Especie,Nome).
animal(dragao,balerion).
animal(dragao,drogon  ).
animal(lobo  ,fantasma).
animal(cavalo,prata   ).
%castelo(Nome).
castelo(winterfell     ).
castelo(rochedoCasterly).
%vivo(X) ↔ X está certamente vivo.
vivo(jonSnow ).
vivo(daenerys).
vivo(drogon  ).

%morto(X) ↔ X está certamente morto.
morto(aegon ).
morto(nedStark).
morto(balerion).
morto(prata ).
%possui(X,Y) ↔ Pessoa X possui Y.
possui(aegon         ,balerion ).
possui(jonSnow       ,fantasma ).
possui(daenerys      ,drogon ).
possui(daenerys      ,prata ).
possui(nedStark      ,winterfell ).
possui(tywinLannister,rochedoCasterly).


%Item a
guardiao(X) :- possui(X,Y), castelo(Y).

%Item b
% ?- possui(X,Y), animal(dragao,Y).

%Item c
% ?- possui(X,Y), animal(_,Y), \+ vivo(Y), \+ morto(Y).

%Questao 17































