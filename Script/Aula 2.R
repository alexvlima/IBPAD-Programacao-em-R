# CURSO DE R - 2ª AULA

x1 <- 10 #atribui o valor para a variável x1
x1 #apresenta o valor no Console

x2 = 20 #atribui o valor para a variável. Na maioria das vezes = é a mesma coisa que <-
x2

assign("x3",4) #função que faz a mesma coisa que o <- ou o =
x3

x1+x2+x3 #soma o valor das três variáveis
x1/x2 #divide x1 por x2
x1*x2 #multiplica x1 e x2
##Contudo não guarda o resultado

y <- x1*x2+x3 #cria a variável y com o resultado da operação
y

X1 ##Vai dar erro, porque o R é case sensitive (maiúsculo e minúsculo são diferentes)

a1_b2.c15 <- "variável com nome estranho"
a1_b2.c15

## Não pode começar nome de variável com underscore ou número
#_vai_dar_erro <- 2000

ls() #Vejo o nome das variáveis que foram criadas na área de trabalho
x3
rm(x3) #remove a variável da área de trabalho
x3 #não vai encontrar a variável porque ela foi removida

ls()

# Salva a área de trabalho no arquivo "aula1_2.RData"
save.image(file = "aula_2.RData")

# Remover todos os objetos deda área de trabalho
rm(list = ls())
ls()

# Carrega os objetos que foram salvos
load(file = "aula_2.RData")
ls()


#Exercício1
save.image(file = "aula_2_1.rda") #salva a seção do R

rm(list=ls()) #remove todos os objetos

#cria e atribui valores para objetos de diferentes formas
x1 <- 10
20 -> x2
assign("x3",5)
y=15

ls() #apresenta os objetos que foram criados

rm(list=ls()) #remove todos os objetos 

load(file = "aula_2_1.rda") #carrega os dados da seção anterior
# FIM

###Vetores###

# concatena os objetos em um vetor
x3 <- c(x1,2,3,x2)
x3

# concatena "a" , "b", "c"
x4 <- c("a","b","c")
x4


#Tipos de variáveis
numero <- c(546.90, 10, 789) #tipo numérico
inteiro <- c(1L , 98L) #tipo número inteiro
complexo <- c(20i, 2 + 9i) #tipo número complexo
texto <- c("aspas duplas", 'aspas simples', "aspas 'dentro' do texto") #tipo string...utilizar aspas
logico <- c (TRUE,FALSE,TRUE) #tipo lógico...utilizar sempre letra maiúscula


#Verifica a classe da variável
class(numero)
class(inteiro)
class(complexo)
class(texto)
class(logico)

# Pergunta para o R se a variável é de determinada classe
is.numeric(numero) ## [1] TRUE
is.character(numero) ## [1] FALSE
is.character(texto) ## [1] TRUE
is.logical(texto) ## [1] FALSE

# O vetor pode conter apenas uma classe. Se tiver mais de uma, ele vai atribuir seguindo a ordem de texto, complexo, numérico, inteiro e lógico
x <- c(1, 2, 3L)
class(x)

x <- c (1, 2, 3L, 4i)
class(x)

x <- c (1, 2, 3L, 4i, "5")
class(x)

# Função "as." converte a classe da variável
as.character(numero) #converte para a texto a variável numero
as.numeric(logico) #converte para número TRUE=1 e FALSE=0
as.numeric(texto) #converte a variável texto para numérico...não faz sentido e aparece NA como missing
as.numeric("1012312")

# Função str() mostra a estrutura da variável
str(x3)
str(numero)
str(inteiro)
str(complexo)
str(texto)
str(logico)

# A função length() mostra o tamanho do objeto
length(x1)
length(x2)
length(x3)

length(numero)
length(inteiro)
length(complexo)

length(texto)
length(logico)

# Nomear os elementos de um vetor
numero
names(numero) <- c("número1","número2","número3")
numero
names(numero)

# Acessar o elemento de um vetor. Utilizar []
numero[1]
numero[c(1,2)] #elementos 1 e 2
numero[c(1,3)] #elementos 1 e 3
numero[c(3,1,2)] #elementos 3, 1 e 2

numero[-1] #apresenta todos os elementos menos o 1
numero[-c(1,2)] #a mesma coisa que numero[c(-1,-2)] #todos menos o 1 e 2
numero[-c(1,3)] #todos menos o 1 e o 3

# Posso selecionar o mesmo atributo mais de uma vez
numero[c(1,1,1,1,1,1)]

numero["número1"] #outra forma de selecionar os elementos
numero[c("número1","número3")] #outra forma de selecionar os elementos

numero[c(TRUE,FALSE,FALSE)] #selecionar por vetor lógico
numero[c(FALSE,FALSE,TRUE)] #selecionar por vetor lógico
numero[c(TRUE,FALSE,TRUE)] #selecionar por vetor lógico

# Alterar atributos de um vetor
numero
numero[1] <- 100 #alterar o elemento 1 para 100
numero

numero[2:3] <- c(12.3, -10) #altera elementos 2 a 3
numero

# Função order() retorna o vetor pelas posições em ordem crescente
order(numero) #índices

numero[order(numero)] #ordena numero

# A função sort() retorna o vetor ordenado
sort(numero)

# O padrão do parâmetro é decreasing = FALSE (forma crescente)
# Forma decrescente
order(numero,decreasing = TRUE)
numero[order(numero,decreasing = TRUE)]
sort(numero,decreasing = TRUE)

# Criar sequencia, utilizar ":"
1:10
-1:10
-(1:10)

# Função seq() - Sequencia de dados
seq(from = 1, to = 10, by = 3)

# Repetição
rep (1, times = 10)
rep(c(1,2), times = 5)

# Exercício2

numero <- c(1,2,3,4)
is.numeric(numero)
as.character(numero)
length(x)
str(x)
y <- c(90L, 5L, 100L)
class(y)
is.integer(y)
length(y)
str(y)

v1 <- c("a", TRUE, 1, 2, 10) 
v2 <- c(TRUE, 1, 1L, 4)
class(v1)
class(v2)

y <- 1:3
names(y) <- c("e1", "e2", "e3")
y["e1"]
y[1]
y[c(TRUE,FALSE,FALSE)]
y[-c(3)] # ou y[-3]
y[-length(y)] # outra forma
y[2]<-10

x<-1:100
x[rep(c(F,T), length(x)/2)]
selec<-seq(2,100,by = 2)
# ou x[c(F,T)]
## Fim

# Operadores Matemáticas
# x + y Soma (elemento a elemento) 
# x - y Subtração (elemento a elemento) 
# x * y Multiplicação (elemento a elemento) 
# x / y Divisão (elemento a elemento) 
# x ˆ y Exponenciação (elemento a elemento) 
# x %/% y Divisão por inteiro (elemento a elemento) 
# x %% y Resto da divisão (elemento a elemento)

1+20
c(1, 2, 3) + c(4, 5, 6) #Soma vetorizada

200-2
c(1,2,3) - c(4,5,6) #Subtração vetorizada

200/15
c(2,4,6) / c(1,2,3)  #Divisão vetorizada

2*10
c(10,9,8) * c(1,2,3) #Multiplicação vetorizada

4^2
c(2,2,2) ^ c(1,2,3) #Exponenciação vetorizada

7%/%3
c(7,7) %/% c(3,2) #Parte inteira da divisão vetorizado

7%%3
c(7,7) %% c(3,2) #Resto da divisão vetorizado

# RECICLAGEM
x<-c(1,2,3,4)
x*2 #A mesma coisa de x*c(2,2,2,2)

x<-c(1,2,3,4)
x*c(2,3) #equivalente a x*c(2,3,2,3)

x*c(2,3,1)

# Funções Matemáticas
# abs(x) Valor absoluto. 
# log(x) Logaritmo natural. 
# exp(x) Exponencial. 
# sqrt(x) Raiz quadrada. 
# factorial(x) Fatorial.

##Análise Combinatória - Função choose()
# Todas as funções são vetorizadas.
x<-c(1,2,-3,4,-20.3)
abs(x)
log(x)
exp(x)
sqrt(x)

factorial(5) #5*4*3*2*1

#Há também funções trigonométricas
sin(pi); cos(pi)

# Estatística Descritiva
# sum(x) e cumsum(x) Soma e soma acumulada. 
# prod(x) e cumprod(x) Produtório e produtório acumulado. 
# min(x), cummin(x) e pmin(x, y) Mínimo, mínimo acumulado e mínimo par a par. 
# max(x), cummax(x) e pmax(x, y) Máximo, máximo acumulado e máximo par a par. 
# mean(x) Média. 
# var(x) e sd(x) Variância e desvio-padrão. 
# cov(x, y) e cor(x, y) Covariância e correlação. 
# diff(x) Primeira diferença.

median(x) #Mediana
mean(x) 
sum(x)
prod(x)
cumsum(x)
cumprod(x)


y <- 1:5

var(x)
sd(x)
median(x)
cov(x,y)
cor(x,y)
quantile(x,probs = c(0.25,0.5,0.75))
diff(x)

# Função para cálculo da moda
# statmod <- function(x) {
#   z <- table(as.vector(x)) names(z)[z == max(z)]
# }
# 
# n <- c(1,2,2,2,3,3)
# statmod(n)

# Operadores lógicos
# x == y x é igual a y? Faz coerção. 
# x != y x é diferente de y? 
# x > y x é maior do que y? 
# x >= y x é maior ou igual a y? 
# x < y x é menor do que y? 
# x <= y x é menor ou igual a y?

x<-10
y<-20
x==y

x<-c(10,20,30)
y<-c(10,10,30)
x==y

x[x==y] #pega os elementos que são iguais a y
 
# Coerção tem um ônus ... comparação em vetores de diferentes classes
x<-c(10,20)
y<-c("10","20")
x==y

20>"100" #correto do ponto de vista do string(dicionário)

identical(x,y) #verifica se os dois vetores são exatamente idênticos. Mesma classe e iguais.

## Probelama com ponto flutuante
identical(sin(pi),0)
identical(0.1,0.3-0.2)
sin(pi) == 0
all.equal(sin(pi),0)
abs(sin(pi)-0) < 1e-12

x <- c(1,2,3,4,5)
y <- c("1","3","2","4","4")

vetor_logico <- (x>=y)
vetor_logico

x[vetor_logico] #usa vetor lógico para fazer o subset do x.

as.numeric(vetor_logico)
sum(vetor_logico)
mean(vetor_logico)*100 #Percentual de TRUES

!vetor_logico #Oposto do vetor lógico. Utilizar !
sum(!vetor_logico)
identical(!vetor_logico, (x<y)) # são idênticos

# Operadores lógicos E(AND) & e OU(OR) |.
# c(TRUE, FALSE) & c(TRUE, TRUE) ## [1] TRUE FALSE
# c(TRUE, FALSE) | c(TRUE, TRUE) ## [1] TRUE TRUE

set.seed(11) #semente da simulação
x <- rnorm(1000, 5, 2) #Simula 1000 observações normal(5,2)
help.search("rnorm")

any(x > 10) #há algum x maior do que 10

all(x > -20 & x < 20) #todos os x estão entre -20 e 20

# Função which retorna a posição dos elementos que são TRUE
which(c(TRUE, FALSE, TRUE)) 
which(x>10)
x[which(x>10)]
indicador <- which(x>10)
indicador

# Operadores de conjunto
# setdiff(x, y) Conjunto dos elementos de x que não estão em y 
# intersect(x, y) Conjunto dos elementos de x que estão em y 
# union(x, y) Conjunto união de x e y 
# x %in% y Quais elementos de x estão em y?

x <- 1:5
y <- c(1:3, 6:10)

setdiff(x,y)
setdiff(y,x)

intersect(x,y)

union(x,y)

x %in% y
y %in% x

names(numero) <- c("alex", "lorena", "pedro", "ana")
numero

vetor_logico <- names(numero) %in% c("alex","lorena","ana")
numero[-vetor_logico]

#NaN = Not an Number, Infinite, NA = Not Available
log(-1)
x<-NaN
x+1
#NaN==NaN #Not Available
is.nan(x)

Inﬁnito: 2/0 # infinito 
x <- 2/0
x - Inf # infinito - infinito não é um número (NaN) 
1/x # zero
is.infinite(x) 
is.finite(x) 

x<-c(1,2,NA,3)
x+1
x+Inf
sum(x)
sum(x,na.rm=TRUE) #na.rm, opção para remover os NA (na.rm)
#x == NA #Não dá certo
is.na(x)
x[is.na(x)] <- 0 
x
!is.na(x)
x<-x[!is.na(x)]
x