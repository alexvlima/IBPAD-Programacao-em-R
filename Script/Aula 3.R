# CURSO DE R - 3ª AULA
# Função básica para a criação de matriz
# matrix(data = dados, ncol = numero_de_colunas, nrow = numero_de_linhas)

minha_matriz <- matrix(data = 1:10, ncol = 2, nrow = 5)
minha_matriz
# O R por definição ele preenche por coluna (padrão).

minha_matriz2 <- matrix(data =  1:10, ncol = 2, nrow = 5, byrow = TRUE)
minha_matriz2

matrix(data = 1:10, ncol = 5) #R infere o número de linhas

matrix(data = 1:10, nrow = 2) #R infere o número de colunas

str(minha_matriz) #Estrutura da matriz
nrow(minha_matriz) #Retorna o número de linhas
ncol(minha_matriz) #Retorna o número de colunas
dim(minha_matriz) #Retorna a dimensão da matriz
length(minha_matriz) #Quantos elementos tem a matriz


rownames(minha_matriz) <- letters[1:5]
rownames(minha_matriz)
colnames(minha_matriz) <- LETTERS[1:2]
colnames(minha_matriz)

str(minha_matriz)

#Outra forma de criar uma matriz
m <- 1:10 #cria o vetor m
dim(m) <- c(5,2) #atribui dimensões para o vetor m
m

#Operações de matriz
# == != > >= < <= Operadores relacionais elemento a elemento 
# + - / * Soma, subtração, divisão e multiplicação elemento a elemento 
# %*% Multiplicação de matriz 
# %x% Produto de Kronecker 
# t() Transposição de matriz 
# solve() Inversão de matriz (ver também qr(), svd(), chol()) 
# det() Determinante de uma matriz 
# diag() Diagonal de uma matriz

#Exemplo com as operações matriciais
z <- 1:4
dim(z) <- c(2,2)
str(z)

z + z
z + c(1,2,3,4)
z + 10 #Reciclagem c(10,10,10,10)
z + c(10,20) #Reciclagem c(10,20,10,20)

teste <- t(z) + c(10,20) #transposição para alterar a soma e aproveitar a reciclagem
t(teste)
rm(teste)

z + c(10,20,30) #Cuidado com a reciclagem...nesse caso ficou c(10,20,30,10)

z_mais_z <- z + z
z_mais_z
dois_z <- 2*z
z_mais_z == dois_z

zz <- z %*% z #Multiplicação matricial
zz

tz <- t(zz) #Transposição
tz

inv_zz <- solve(zz) #Inversão
inv_zz
inv_zz %*% zz #Matriz Identidade

det(zz) #Determinante da matriz z

#Produto de Kronecker
z %x% z

#diagonal principal da matriz
diag(z)

# Vamos simular e estimar os parâmetros de uma regressão linear usando operações matriciais:
# parametros 
n_vars <- 4 #numero de variaveis 
n_obs <- 100 #numero de observações
# Simulando y ~ Xb + e 
X <- matrix(rnorm(n_obs*n_vars), ncol = n_vars) #vetor X 
betas <- c(1, 2, 3, 4) #betas verdadeiros 
erro <- rnorm(n_obs) #termo de erro normal(0,1) 
y <- X %*% betas + erro #vetor y

# Estimando por mínimos quadrados:
# estimando os betas: (X'X)^-1 X'y 
betas_estimados <- solve(t(X) %*% X) %*% t(X) %*% y 
betas_estimados[,1] 
# Comparando com a estimativa da função nativa do R 
modelo <- lm(y ~ X - 1) #sem intercepto
modelo
coef(modelo) #coeficientes do modelo
modelo <- lm(y ~ X) #com intercepto 
modelo

#Exemplo 

n_vendedores <- 3 #3 Vendedores
n_dias <- 5 #5 dias

# valores de venda (aleatórios) 
# média de R$1000,00 por dia 
# desvio padrão de R$200,00
set.seed(192)
media <- 1000
desvio <- 200
valores <- rnorm (n_dias*n_vendedores, media, desvio)

# cria matriz 
vendas <- matrix(valores, nrow = n_dias, ncol = n_vendedores)
# nomes para linhas 
rownames(vendas) <- c("segunda", "terça", "quarta", "quinta", "sexta")
# nomes para colunas 
colnames(vendas) <- c("João", "Maria", "Ana")

#Como ficou a matriz
vendas
options(digits = 6) #apresentar os números com apenas 6 dígitos
vendas

vendas["segunda",] #Todas as vendas de segunda
vendas[1,] #seleciona a primeira linha
vendas[-c(1,2),] # seleciona tudo exceto linhas 1 e 2 
vendas[ ,"Ana"] # seleciona colunas de nome "Ana" 
vendas[ ,3] # seleciona terceira coluna 
vendas[ ,-3] # seleciona tudo exceto terceira coluna 

# linhas 1, 3 e 5 - colunas João e Ana 
vendas[c(1, 3, 5), c("João", "Ana")]
# linhas segunda, quarta e sexta - colunas 1 e 3 
vendas[c("segunda", "quarta", "sexta"), c(1, 3)]
# tudo menos linhas 1, 3 e 5 e menos colunas 2 e 3 
vendas[-c(1,3,5), -c(2,3)] #selecionou apenas as vendas de João e transformou a matriz em um vetor...retirou o label João

vendas_segunda <- vendas[1, ,drop=FALSE] #A função drop preserva como matriz
vendas_segunda

#Alterar o valor de elementos na matriz
vendas[c("quarta", "quinta"), "Ana"] 
vendas[c("quarta", "quinta"), "Ana"] <- c(1500, 2000)
vendas[c("quarta", "quinta"), "Ana"] 

#Adicionar colunas ... Função cbind()
set.seed(145)
José <- rnorm (nrow(vendas), media, desvio)
vendas <- cbind(vendas, José)
vendas

#Adicionar linhas ... Função rbind()
set.seed(90)
sábado <- rnorm(ncol(vendas), media, desvio) 
vendas <- rbind(vendas, sábado) 
vendas 

#Remover linhas e colunas
vendas <- vendas[-6, ] #Remove a sexta linha
vendas
vendas <- vendas[ ,-4] #Remove a quarta coluna
vendas
vendas[ ,colnames(vendas) != "Ana"] #Não selecionar a coluna Ana

#Função Summary
#Estatística Descritiva
summary(vendas) #Por coluna
summary(t(vendas)) #Por linha

#Soma por linha
rowSums(vendas)
#Média por linha
rowMeans(vendas)

#Soma por coluna
colSums(vendas)
#Média por coluna
colMeans(vendas)

#Função Apply
# apply(matriz, dimensão, função) Dimensão: 1 = linha ; 2 = coluna
?apply
apply(vendas, 1, max) #Qual o valor máximo vendido por cada dia (linhas)?
apply(vendas, 2, min) #Qual foi o menor valor de cada vendedor (colunas)?
apply(vendas, 1, sd)
apply(vendas, 2, sd)

#ARRAY - Mais de 2 dimensões
# Criando um array com 3 dimensões 
# '2 tabelas' com 4 linhas 2 colunas
meu_array <- array(1:16, dim = c(4,2,2))
# Selecionando nas 3 dimensões 
meu_array[1:2, 2, 2]

vendas2 <- t(vendas) 
vendas2 
sexo <- c("m", "f", "f") 
vendas2 <- cbind(vendas2, sexo)
is.character(vendas2) 

#Exercício
x <- 1:16
m <- matrix(x,4,4)
dim(x) <- c(4,4)
identical(x, m)

m[1:4, c(2,4)]
m[m[,1] < 3, ] 
m[m<10]

indice <- m %% 2 == 0
m[indice] <- m[indice]^2
m

#DATA FRAME: BANCO DE DADOS NO R

funcionarios <- data.frame (nome = c("João", "Maria", "José"),
                           sexo = c("M", "F", "M"),
                           salario = c(1000, 1200, 1300),
                           stringsAsFactors = FALSE)

str(funcionarios)

as.matrix(funcionarios)
#Todas as variáveis viraram character. 

df.vendas <- as.data.frame(t(vendas))
df.vendas

str(df.vendas)

# tudo menos linha 1 
funcionarios[-1, ] 

# seleciona primeira linha e primeira coluna (vetor) 
funcionarios[1, 1] 

# seleciona primeira linha e primeira coluna (data.frame) 
funcionarios[1, 1, drop = FALSE] 

# aumento de salario para o João 
funcionarios[1, "salario"] <- 1100
funcionarios

rownames(funcionarios) 
colnames(funcionarios) 
names(funcionarios) 
# Detalhe: o names trata-se de nomes das colunas do data.frame. Os elementos do data.frame são seus vetores coluna.

funcionarios$nome #Seleciona a coluna nome
funcionario[["nome"]] #outra forma de fazer a seleção

funcionarios$salario #Seleciona a coluna salario
funcionarios[["salario"]] 

# Tanto o $ quanto o [[ ]] sempre retornam um vetor como resultado.

# outro aumento para o João 
funcionarios$salario[1] <- 1150
# equivalente 
funcionarios[["salario"]][1] <- 1150 
funcionarios

# Retorna data.frame 
funcionarios[ ,"salario", drop = FALSE]
# Retorna data.frame 
funcionarios["salario"]

# Operações com Data Frame
# df[ ,"x"] Retorna vetor x do data.frame df. 
# df$x Retorna vetor x do data.frame df. 
# df[["x"]] Retorna vetor x do data.frame df. 
# df[ ,"x", drop = FALSE] Retorna um data.frame com a coluna x. 
# df["x"] Retorna um data.frame com a coluna x.

# Criando novas colunas
funcionarios$escolaridade <- c("Ensino Médio", "Graduação", "Mestrado")
funcionarios[,"experiencia"] <- c(10, 12, 15)
funcionarios[["avaliacao_anual"]] <- c(7, 9, 10)
funcionarios <- cbind (funcionarios, 
                       prim_emprego = c("sim", "nao", "nao"),
                       stringAsFactors=FALSE)
funcionarios

# Remover colunas
funcionarios$prim_emprego <- NULL
funcionarios$avaliacao_anual <- NULL
funcionarios <- funcionarios[,-c(4,6)] #Deleta a coluna 4 e 6
funcionarios

# Adicionar linhas
# CUIDADO! 
funcionarios[4, ] <- c("Ana", "F", 2000, 15) 
str(funcionarios)

funcionarios$salario <- as.numeric(funcionarios$salario)
funcionarios$experiencia <- as.numeric(funcionarios$experiencia)

funcionarios[4, ] <- data.frame(nome = "Ana", sexo = "F", 
                                salario = 2000, 
                                experiencia = 15, 
                                stringsAsFactors = FALSE)
funcionarios

# Outra forma de adicionar linha
rbind(funcionarios, 
      data.frame(nome = "Ana", 
                 sexo = "F", 
                 salario = 2000, 
                 experiencia = 15, 
                 stringsAsFactors = FALSE))

# Remover linhas
funcionarios <- funcionarios [-4,]

# remove linhas em que salario <= 1150 
funcionarios <- funcionarios[funcionarios$salario > 1150, ]
funcionarios
funcionarios [funcionarios$sexo!="F"&funcionarios$salario > 1150, ]

# Apenas linhas com salario > 1000 
funcionarios[funcionarios$salario > 1000, ] 
# Apenas linhas com sexo == "F" 
funcionarios[funcionarios$sexo == "F", ] 

# Função de conveniência subset()
# subset(nome_do_data_frame, 
#        subset = expressao_logica_para_filtrar_linhas, 
#        select = nomes_das_colunas, 
#        drop = simplicar_para_vetor?)

# funcionarios[funcionarios$sexo == "F",] 
subset(funcionarios, sexo == "F") 
# funcionarios[funcionarios$sexo == "M", c("nome", "salario")] 
subset(funcionarios, sexo == "M", select = c("nome", "salario")) 

# Função de conveniência with()

# Com o with 
with(funcionarios, (salario^3 - salario^2)/log(salario)) 

# Sem o with 
(funcionarios$salario^3 - funcionarios$salario^2)/log(funcionarios$salario) 

# Quatro formas de fazer a mesma seleção
subset(funcionarios, sexo == "M", select = "salario", drop = TRUE) 
with(funcionarios, salario[sexo == "M"])
funcionarios$salario[funcionarios$sexo == "M"]
funcionarios[funcionarios$sexo == "M", "salario"]

# Aplicando funções no data.frame: o que funcionava nas matrizes continua valendo
rowSums(df.vendas) 
colSums(df.vendas) 

apply(df.vendas, 1, max) 
apply(df.vendas, 2, max) 

# Funções sapply() e lapply()
sapply(funcionarios[3:4], mean)

# Retorna uma lista
lapply(funcionarios[3:4], mean) 

# Filtrando as variáveis
Filter(is.numeric, funcionarios) 
Filter(is.character, funcionarios) 

# Combinando as funções sapply e filter 
sapply(Filter(is.numeric, funcionarios), mean) 
sapply(Filter(is.numeric, funcionarios), max) 

# Exercício
df <- data.frame(x = letters[1:4], y = 1:4, stringsAsFactors = FALSE)
y <- 1:4
df$y2 <- y^2 #outra forma df$y2 <- df$y^2
df
df$y2 <- NULL

df[5, ] <- data.frame(x = "e", y = "5", 
                      stringsAsFactors = FALSE)
df
df <- df[-5,]
df


subset (df, x == "a") #outra forma df[df$x == "a", ]
subset (df, y < 3) #outra forma df[df$y < 3, ]

df$y[df$y >= 3] <- df$y[df$y >= 3]^3
#outra forma, como se fosse matriz
df[df[,"y"]>=3, "y"] <- df[df[,"y"] >= 3, "y"]^3
#ou
filtro_linhas <-  df$y >= 3
df[filtro_linhas, "y"] <- df[filtro_linhas, "y"]^3

str(df)
df$y <- as.numeric(df$y) #Transformar em numérico a variável y


# LISTAS: juntar várias coisas em um único objeto

# gera variáveis aleatórias 
set.seed(1) 
x <- rnorm(100) 
y <- 10 + 2*x + rnorm(100)

# roda regressão linear 
modelo <- lm(y ~ x) 
summary(modelo)

# Veja que o objeto modelo é uma lista! 
str(modelo, max.level = 1)

minha_lista <- list(x = 1:10, 
                    y = letters[1:5], 
                    z = list(a = 1, 
                             b = list(c = 2))) 
str(minha_lista)
str(minha_lista, max.level = 1)

#Selecionar objetos dentro da lista: utilizar o $ ou o [[]]
minha_lista$x
minha_lista[["x"]]
minha_lista[[1]]
modelo$coefficients 
coef(modelo) #função de conveniência

# Selecionando uma lista com o objeto (note a diferença):
# Retorna uma lista com o objeto x e não o vetor do objeto x
minha_lista["x"] 
minha_lista[c(1,2)] 

# seleciona primeiro o elemento z 
# depois o elemento b (do elemento z) 
# e depois o elemento c (do elemento b) 
minha_lista$z$b$c
# idem anterior 
minha_lista[["z"]][["b"]][["c"]]


# Operadores
# lista$x Retorna o objeto x da lista. 
# lista[["x"]] Retorna o objeto x da lista. 
# lista["x"] Retorna uma lista com o objeto x.

dados_da_empresa <- list(vendas = df.vendas, 
                         funcionarios = funcionarios)

# Adicionar elementos em uma lista
dados_da_empresa$comentario <- "Um comentario"
str(dados_da_empresa, max.level = 1) 

# Remover elementos em uma lista
dados_da_empresa$comentario <- NULL
dados_da_empresa

# Aplicando funções em uma lista: sapply e lapply
set.seed(1)
# cria uma lista com 3 matrizes 2 x 2 
lista_de_matrizes <- list(x = matrix(rnorm(4), ncol = 2), 
                          y = matrix(rnorm(4), ncol = 2), 
                          z = matrix(rnorm(4), ncol = 2))

# calcula o determinante das 3 matrizes ao mesmo tempo 
sapply(lista_de_matrizes, det) 

# Exercícios
minha_lista$outralista <- list(c(1:10),
                               df.vendas)

minha_lista$x 
minha_lista$outralista
minha_lista[c("outralista","x")]

minha_lista$outralista <- NULL