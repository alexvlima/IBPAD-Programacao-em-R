###   LISTA 1 ###

# 1. Crie tr?s vari?veis no R com as tr?s formas diferentes de criar objetos que voc? aprendeu:
x <- 5
assign ("y",4)
z=10

# . Verifique se as vari?veis foram criadas. Crie uma quarta vari?vel concatenando as tr?s vari?veis.
ls()
"x" %in% ls()
exists("x")
a <- c(x,y,z)

# . Remova apenas as tr?s primeiras vari?veis do ambiente de trabalho com apenas um comando.
rm(x,y,z)
ls(pattern = "[^a]")
ls()[ls() != "a"]
ls()

# 2. Crie vari?veis de classes numeric, integer, complex, character e logical com tamanhos diferentes (maiores do que 1):
x <- c(1,2,3,4) #Num?rico
y <- c(90L,2L,5L,4L) #Inteiro
z <- c(5i,3i+5,20+5i,3i+2) #Complexo
delta <- c("Alexandre","Lorena","Pedro","Ana") #Texto (String - Char)
lambda <- c(TRUE,FALSE,TRUE,TRUE) #L?gico

# Verifique se as vari?veis est?o no ambiente de trabalho. Veja a estrutura, classe e tamanho dessas vari?veis
list(x,y,z,delta,lambda)

str(x)
str(y)
str(z)
str(delta)
str(lambda)

class(x)
class(y)
class(z)
class(delta)
class(lambda)

# Fazer tudo de uma vez
sapply(mget(ls()), class)
sapply(mget(c("x","y","z","delta","lambda")), class)

length(x)
length(y)
length(z)
length(delta)
length(lambda)

sapply(mget(ls()), length)
sapply(mget(c("x","y","z","delta","lambda")), length)

# Fun??o para ter a classe e o tamanho
cl <- function(x) list(class(x), length(x))
cl("x")

# Aplique as fun??es is.xxxx e as fun??es as.xxxx aos objetos e verifique seu comportamento
is.numeric(x); is.character(x); is.integer(x); is.complex(x); is.logical(x)
is.numeric(y); is.character(y); is.integer(y); is.complex(y); is.logical(y)
is.numeric(z); is.character(z); is.integer(z); is.complex(z); is.logical(z)
is.numeric(delta); is.character(delta); is.integer(delta); is.complex(delta); is.logical(delta)
is.numeric(lambda); is.character(lambda); is.integer(lambda); is.complex(lambda); is.logical(lambda)

as.integer(x)
as.complex(y)
as.character(z)
as.numeric(delta)
as.numeric(lambda)

# Crie um vetor num?rico e e d? nome a cada um dos elementos como "obs1", "obs2", . . . . utilizando a
# fun??o names(). Utilize a fun??o paste() para criar os nomes (olhe a ajuda em ?paste). Fa?a alguns
# subsets do vetor usando os nomes.

vetor_num <- c(10,13,15,20,50)
names(vetor_num) <- c("obs1","obs2","obs3","obs4","obs5")
vetor_num

help(paste) #pode ser ?paste

# paste("obs",c(1:5), sep = "") - paste0 ? uma fun??o de conveni?ncia que j? traz o separador igual a vazio 
names(vetor_num) <- paste0("obs",c(1:5))
vetor_num

vetor_num["obs1"]
vetor_num[c("obs1","obs2")]

# Salve a vari?vel num?rica como x.rds usando a fun??o saveRDS() e como x.rda usando a função
# save(). Tente ler a ajuda das fun??es para entender como funcionam (?saveRDS e ?save). A se??o de
?saveRDS()
saveRDS(vetor_num, "vetor_num.rds")

?save
save(vetor_num, file = "vetor_num.rda")

# exemplo pode ser ?til. N?o se preocupe, aprenderemos essas fun??es com mais detalhes em outra aula,
# o objetivo ? exercitar o uso da ajuda do R.

# Remova todas vari?veis do ambiente de trabalho com apenas um comando.
?rm
rm(list = ls())

# . Carregue novamente a vari?vel num?rica usando a fun??o load() no arquivo x.rda. Agora carregue
# usando a fun??o readRDS() no arquivo x.rds. Voc? notou alguma diferen?a entre essas duas formas de
# carregar a vari?vel?
load("vetor_num.rda")
readRDS("vetor_num.rds")
#Sim. A fun??o readRDS apenas l? a vari?vel, mas n?o carrega para para a sua ?rea de trabalho.  

# 3. Verifique as classes, estruturas, tamanho e o resultado da fun??o summary() nos seguintes vetores:
x1 <- 1:10
x2 <- rnorm(10) #rnorm(10,0,1) - m?dia zero e dp 1 ? o padr?o
x3 <- c("a", "b", "c")
x4 <- c(T, F, T)
x5 <- c(1, "a", 2)
x6 <- c(1, TRUE, 0)
x7 <- c(1, 2, 3, 4L)
x8 <- c(1L, 2, TRUE, "a")

summary(x1)
summary(x2)
summary(x3)
summary(x4)
summary(x5)
summary(x6)
summary(x7)
summary(x8)

# 4. Construa os seguintes vetores com 100 observa??es de uma normal(0,1):
set.seed(1)
x <- rnorm(100)
y <- rnorm(100)

# . Qual ? o primeiro elemento de x? Qual o terceiro elemento de y?
x[1]
y[3]

# . Delete os 10 primeiros elementos de x e de y.
x <- x[-c(1:10)]
y <- y[-c(1:10)]
x ; y 

# Qual ? 56th elemento de x? Ele ? maior do que 56th elemento de y?
x[56]
x[56] > y[56] #FALSE

# Qual ? a m?dia de x? Qual a diferen?a da m?dia de x com a m?dia de y?
mean(x)
mean(x) - mean(y)

# Qual ? o desvio-padr?o de x? Qual a vari?ncia de y?
sd(x)
sd(y)^2 #var(y)

# Qual ? a correla??o de x e y?
cor(x,y)

# Qual a soma, produt?rio, soma acumulada e produt?rio acumulado de x?
sum(x)
prod(x)
cumsum(x)
cumprod(x)

# Como voc? utilizaria a fun??o cumsum() para calcular a m?dia acumulada de x?
cumsum(x) / (1:length(x))
soma_acum <- cumsum(x); soma_acum[100] / length(x)
mean(x)

# Crie os vetores x_cres e x_decres com x ordenado de formas crescente e decrescente.
x_cres <- sort(x) # x[order(x)]
x_cres

x_decres <- sort(x,decreasing=TRUE)
x_decres

# Crie um vetor z concatenando x e y.
z <- c(x,y)
z

# Selecione apenas os valores de y maiores do que sua m?dia.
selec <- y[y > mean(y)]
selec

# Selecione os valores de x maiores ou iguais a 0.5, ou menores do que -1.5. 
x[x >=0.5 | x < -1.5]

# Selecione os valores de x maiores do que 0.5 e menores ou iguais a 1. 
x[x > 0.5 & x <= 1]

# Crie novos vetores com os resultados da soma, multiplica??o, divis?o, parte inteira da divis?o, resto da divis?o e exponencia??o de x com y. 
soma <- x + y
mult <- x*y
div <- x/y
part_inteira <- x %/% y
resto <- x %% y
exp <- x ^ y

# Veri???que se existem NA's ou NaN's nos vetores criados. Caso existam, substitua os NA's ou NaN's por 0.
sum(is.na(soma))
any(is.na(soma))

quantos_nas <- function (x) sum(is.na(x))
quantos_nas(div)
quantos_nas(mult)
quantos_nas(expo)
sapply (c("div", "mult", "expo", "resto", quantos_nas))

expo[is.na(expo)] <- 0

# Crie um vetor de diferen?as entre x sua primeira defasagem. Crie outro com a diferen?a da terceira defasagem. Crie um com as segundas diferen?as do primeiro lag de x (veja o help da fun??o diff()). Veri???que a estrutura e tamanho dos vetores. 
?diff
dif_x <- diff(x)
dif3_x <- diff(x, lag = 3)
str(dif_x) ; length(dif_x)

# Selecione apenas cada segundo elemento do vetor x. 
x [seq(2, length(x), by = 2)]
x[c(F,T)]

# 5. Considere os vetores x <- 1:6 e y <- 2:1. Qual o tamanho de cada vetor? Qual o resultado de x + y? Explique o que aconteceu.
x <- 1:6
y <- 2:1

length(x)
length(y)

x+y

#O que ocorreu foi que o vetor y foi replicado tr?s vezes para ficar do mesmo tamanho do vetor x.
#Portanto seria como o vetor y fosse c(2,1,2,1,2,1). Esse ? o processo de reciclagem. 

# 6. Crie os seguintes vetores (Dica: use :, seq(), rep() etc):
# . 1, 2, 3, 4, . . . , 10;
x<-seq(1:10)
x

# . 10, 9, 8, 7, . . . ., 1;
y<-seq(from=10, to=1)
y

# . 2, 4, 6, 8, . . . ., 200;
z<-seq(from=2, to=200,by=2)
z

# . 10.5, 9.5, 8.5, . . . ., 0;
a<-c(seq(from=10.5, to=0, by=-1),0)
a

# . de 1.06 at? 2.98 com 67 elementos;
b <- seq(from=1.06, to=2.98, length.out=67)
b

# . 1, 7, 1, 7, . . . . de tamanho 140.
c <- rep(c(1,7), length.out = 140) # Ou times = 70
c

# . "a", "b", "a", "b", . . . . de tamanho 10
d <- rep(c("a","b"),length.out = 10) # Ou times = 5
d

# . 1, 1, 1, . . . . 100 vezes junto com 5, 5, 5, . . . . 25 vezes.
e <- c(rep(1,100),rep(5,25)) # rep(c(1,5), times = c(100,25))
e

# . 1, 1, 1, 2, 2, 2, . . . , 10, 10, 10;
f <- rep(1:10, each = 3) #l <- sort(rep((1:10),3))
f

# 7. Crie um vetor de 1 at? 100 e o transforme em matrizes quadr?ticas conforme ilustrado abaixo.
# (Dica: use as op??es ncol, nrow e byrow da fun??o matrix())
# Ordenada por colunas:
x <- c(1:100)
dim(x) <- c(10,10)
x

# Ordenada por linhas:
x <- c(1:100)
m <- matrix(x, ncol = 10, nrow = 10, byrow = TRUE)
m

# 8. Considere os seguintes vetores gerados de uma distribui??o t com 1 e 2 graus de liberdade:
set.seed(10)
x <- rt(10, df = 1)
x
y <- rt(10, df = 2)
y

# Crie uma matriz xy combinando x e y como linhas. Qual ? a estrutura desta matriz?
m <- matrix(c(x,y),byrow = TRUE) #m <- rbind(x, y)
m
str(m)

# Crie um matriz XY combinando x e y como colunas. Qual ? a estrutura desta matriz?
m2 <- matrix(c(x,y)) #m2 <- cbind(x, y)
m2
str(m2)

# Crie um vetor z concatenando x e y. Crie com z uma matriz com duas linhas. Crie com z uma matriz
# com duas colunas.
z <- c(x,y)
matriz_z <- matrix(z, nrow = 2) #dim(z) <- c(10,2)
matriz_z
matriz_z2 <- matrix(z, ncol = 2)
matriz_z2

# Transforme x e y em matrizes de 10 linhas e uma coluna. Crie uma matriz m com o resultado de x vezes # a transposta de y. Notar que a multiplica??o ? matricial.
matriz_x <- matrix(x, nrow = 10, ncol = 1); matriz_x #dim(x) <- c(10,1)
matriz_y <- matrix(y, nrow = 10, ncol = 1); matriz_y
matriz_m <- matriz_x %*% t(matriz_y)
matriz_m

# Selecione: (i) a linha 10 de m; (ii) a coluna 5 de m; (iii) o elemento na terceira linha e segunda coluna; os
# elementos de m maiores do que zero; (iv) os elementos de m menores do que zero e calcular a m?dia; (vi)
# a diagonal de m

matriz_m[10,]
matriz_m[,5]
matriz_m[3,2]
matriz_m[matriz_m>0]
matriz_m[matriz_m<0]
mean(matriz_m[matriz_m<0]) #média
diag(matriz_m)

# 9. Crie 2 matrizes, A e B, com 5 linhas e 5 colunas e elementos de uma normal(0,1). Antes de gerar
# os valores aleat?rios, defina a semente set.seed(1). (Dica: uma matriz 5 por 5 vai precisar de 25
#                                                       elementos; a fun??o para gerar dados de uma normal ? rnorm e a fun??o para criar uma matriz ? matrix).
set.seed(1)
A <- matrix(rnorm(25,0,1), ncol=5)
B <- matrix(rnorm(25,0,1), ncol=5)
A
B

# Quais os resultados das fun??es length(), ncol(), nrow(), dim(), str(), min(), max(), summary() e is.matrix nas matrizes?

length(A) ; length(B)
ncol(A) ; ncol(B)
nrow(A) ; nrow(B)
dim(A) ; dim(B)
str(A) ; str(B)
min(A) ; min(B) # apply(A, 1, min) - minimo por linha 
max(A) ; max(B) # apply(A, 2, max) - maximo por coluna
summary(A) ; summary(B)
is.matrix(A); is.matrix(B)

# Crie matrizes A2 e B2 compostas dos elementos de A e B em valores absolutos;
A2 <- abs(A)
B2 <- abs(B)
A2 ; B2

# Crie uma matriz C com a soma (elemento a elemento) de A e B;
C <- A + B
C

# Crie uma matriz D com a multiplica??o (elemento a elemento) de A e B;
D <- A * B

# Inverta as matrizes. Calcule o determinante das matrizes;
solve(A) ; det(A)
solve(B) ; det(B)
solve(C) ; det(C)
solve(D) ; det(D)

# Crie a uma matriz A3 excluindo a primeira linha e a primeira coluna de A;
A3 <- A[-1,-1]
A3

# Calcule a media dos elementos de A tais que A[i] <= B[i];    
mean(A[A <= B])

# Crie uma matriz C tal que C[i] = 1 se A[i] >= B[i] e 0 caso contrario;
C <- (A>=B)*1
C

# Outra solução
C <- A
C[A>=B] <- 1
C[A<B] <- 0
C

C <- ifelse(A>=B,1,0)
C

# Utilize a fun??o rownames() para nomear as linhas de A como "linha1", "linha2" . . . , e a fun??o
# colnames() para nomear as colunas de A como "coluna1", "coluna2" . . . . Utilize a fun??o paste()

rownames(A) <- paste("linha", 1:nrow(A), sep="") #ou paste0
colnames(A) <- paste("coluna", 1:nrow(A), sep="") #ou paste0
A

# para criar os nomes. Fa?a alguns subsets utilizando os nomes.
A["linha1" , ]
A[ , "coluna3"]

# 10. Suponha uma lista do tipo
lista <- list( elemento1 = rnorm(10),
               elemento2 = 1L,
               elemento3 = "a",
               elemento4 = c(1,"b"),
               elemento5 = c(TRUE, TRUE, FALSE),
               elemento6 = c(10i, 20i))

# Quais os resultados de names(), length(), str(), dim(), summary() e is.list() na lista?
names(lista)
length(lista) #tamanho da lista no primeiro nível
sapply(lista, length) #tamanho de cada elemento da lista
str(lista)
dim(lista)
summary(lista)
is.list(lista)

# Qual o primeiro elemento da lista? E o terceiro? Quais as formas de selecionar estes elementos?
lista$elemento1 ; lista[["elemento1"]]; lista[[1]]
lista$elemento3  ; lista[["elemento3"]]; lista[[3]]

# Os elementos da lista sao de classes diferentes? Quais as classes de cada elemento?
sapply (lista, class)

# Adicione um novo elemento na lista, chamado elemento7, com o resultado de elemento1 mais
# elemento2.
lista$elemento7 <- lista$elemento1 + lista$elemento2
lista

# Delete o elemento1 da lista (Dica: atribuir o valor NULL a um elemento da lista deleta este elemento.
#                                Isso tambem vale para data.frames!).
lista$elemento1 <- NULL #Forma que pode ser utilizada para lista e data frame
lista <- lista[-1] #Forma universal do R

# Existe uma funcao no R chamada unlist que, como diz o nome, "desfaz" a lista, a transformando em
# um vetor simples. Qual o objeto resultante de unlist(lista)?
unlist(lista)


# 11. Listas podem ter estruturas arbitrariamente complexas, com listas dentro de listas. Considere a seguinte lista2.

lista2 <- list( lista_dentro_da_lista = lista,
                outra_lista = list(numero=c(1,2,4),
                                   mais_lista=list(c(1,3,4), TRUE)))

# Quais os resultados de names(), length(), str() e summary() na lista2?
names(lista2)
lenght(lista2)
str(lista2)
summary(lista2)

# Como acessar o elemento1 contido em lista_dentro_da_lista que esta em lista2?
lista2$lista_dentro_da_lista$elemento2 

# Como acessar o segundo elemento do objeto mais_lista dentro de outra_lista da lista2?
lista2$outra_lista$mais_lista[[2]]


# 12. Rode o seguinte comando para criar um data.frame:
set.seed(14)
df <- data.frame(x = rnorm(10), y = rnorm(10))

# Verifique os resutados de length(), nrow(), ncol(), dim(), class(), is.data.frame(),str(), 
# summary() em df. Quantas observa??es temos na base de dados? Quantas vari?veis? Qual a classe do
# objeto? Quais as classes das vari?veis?
df
length (df)
nrow(df)
ncol(df)
dim(df)
class(df)
is.data.frame(df)
str (df)
sapply(df, class)
summary(df)

# Temos 10 observa??es, 2 vari?veis (x e y). df ? um Data Frame, com duas vari?veis com classe n?merico.
# Crie um vetor z <- rlnorm(10). Adicione este vetor como mais uma vari?vel, chamada z, em df?
# Quais as diferentes formas de fazer isso?
z <- rlnorm(10)
df$z <- z # ou df[["z"]] <- z
df[ , "z"]

# Como adicionar mais uma linha com x=1, y =2, e z=3 ao data.frame?
df[11, ] <- c(1,2,3)
df[11, ] <- data.frame(x = 1, y = 2, z = 3)
df <- rbind(df, data.frame(x = 1, y = 2, z = 3)) 
df

# Crie uma vari?vel w em df com o resultado de x+y+z.
df$w <- df$x + df$y + df$z
df$w <- with (df, x + y + z)
df
  
# Delete a variavel x de df (Dica: veja a dica do exercicio 10!).
df$x <- NULL
df <- df[names(df) != "x"]
df <- df[!names(df) %in% "x"]
df

# Delete as ultimas cinco linhas de df.
df <- df[1:nrow(df)-5,]
df <- df[-((nrow(df)-4):nrow(df)), ] # Forma alternativa

# 13. Carrege a base de dados wi.venda.rds em um objeto chamado dados. Estes dados s?o de oferta online
# de apartamentos no Plano Piloto (Asa Sul, Asa Norte, Sudoeste e Noroeste).
dados <- readRDS("Dados/wi.venda.rds")

# Verifique os resutados de length(), nrow(), ncol(), dim(), class(), is.data.frame() em dados.
# Quantas observa??es temos na base de dados? Quantas vari?veis? Qual a classe do objeto?
length(dados)
nrow(dados)
ncol(dados)
dim(dados)
class(dados)
is.data.frame(dados)


# Verifique os resultados de names() e colnames(). S?o os mesmos?
names(dados)
colnames(dados)

# Aplique str(), summary() em dados para entender melhor quais sao os dados do data.frame. Quais as classes de cada coluna?
str(dados)
summary(dados)

sapply(dados, class)

# Quais foram a media, mediana, desvio-padrao e variancia dos precos dos anuncios de apartamento no
# Plano Piloto neste dia? (faca com with(), $ e [ ])
estatisticas <- function(x){
  media <- mean(x)
  mediana <- median(x)
  dp <- sd(x)
  var <- var(x)
  resultado <- c(media,mediana,dp,var)
  return(resultado)
}

estatisticas(dados$preco)
with(dados, estatisticas(preco))
estatisticas(dados[ ,"preco"])

mean(dados$preco)
with(dados, sd(preco))

# Quais foram a media, mediana, desvio-padrao e variancia do numero de quartos dos anuncios?
# Quais foram a media, mediana, desvio-padrao e variancia do tamanho dos apartamentos? 

sapply(dados[c("preco","quartos","m2")], estatisticas)

#Com dplyr
library(dplyr)
dados %>% select(preco, quartos, m2) %>% summarise_each(funs = funs("mean","median","sd","var"))

# Qual a correla??o entre pre?os e metro quadrado? (fa?a com with(), $ e [ ])
cor(dados$preco, dados$m2)
plot(preco ~ m2, dados)

# A coluna bairro cont?m a informa??o dos bairros dos an?ncios. Quantos an?ncios temos na Asa Sul
# (em n?mero e percentual)? Quantos an?ncios temos na Asa Norte (em n?mero e percentual)? (fa?a
#                                                                                          com with(), $ e [ ])
sum(dados$bairro == "Asa Sul")
mean(dados$bairro == "Asa Sul")

sum(dados$bairro == "Asa Norte")
mean(dados$bairro == "Asa Norte")

# Crie um vetor chamado preco_asa_sul com os pre?os da Asa Sul. E outro chamado preco_asa_norte
# com os precos da Asa Norte. Qual dos bairros tem a maior mediana de pre?os de apartamento? (fa?a
#                                                                                             com with(), $ e [ ])
preco_asa_sul <- dados$preco[dados$bairro == "Asa Sul"]
preco_asa_sul <- dados[dados$bairro == "Asa Sul", "preco"]

preco_asa_norte <- dados$preco[dados$bairro == "Asa Norte"]
preco_asa_norte <- dados[dados$bairro == "Asa Norte", "preco"]

median(preco_asa_sul)
media(preco_asa_norte)

tapply (dados$preco, dados$bairro, median)
aggregate(preco ~ bairro, data = dados, FUN = median)
dados %>% group_by(bairro) %>% summarise(mediana = median(preco))

# Crie uma coluna pm2 em dados com o resultado de preco dividido por m2 e repita o exerc?cio anterior
# (criando os vetores pm2_asa_sul e pm2_asa_norte). Qual dos dois bairros tem a maior mediana de
# pre?os por metro quadrado? (fa?a com with(), $ e [ ])
dados %>% group_by(bairro) %>% summarise(mediana = median(pm2))

# Delete a coluna link de dados.
dados$link <- NULL

# 14. Exercicio extra: data.frame é uma lista.
# Rode o comando is.list() em dados. Qual o resultado?
# A funcao unclass() retira a classe "especial" dos objetos revertendo-o para sua classe mais basica. Rode o
# seguinte codigo abaixo. Note que um data.frame nada mais é do que uma lista com certas caracteristicas
# (por exemplo: atributo row.names; cada coluna com o mesmo numero de linhas).
class(dados)
is.list(dados)
unclass(dados)
