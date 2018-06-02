# CURSO DE R - 5ª AULA

# A estrutura básica: 
#   if (condicao) {
#   # comandos que 
    # serao rodados 
    # caso condicao = TRUE
# }

# Exemplo
rm(list=ls())
cria_x <- TRUE 
cria_y <- FALSE 

if (cria_x) { 
  x <- 1 
}

if (cria_y) { 
  y <- 1 
}

exists("x"); exists("y") 

# if (condicao) { 
#   # comandos que 
#   # serao rodados 
#   # caso condicao = TRUE } else { 
#   # comandos que 
#   # serao rodados 
#   # caso condicao = FALSE }

numero <- 1
if (numero == 1) { 
  cat("o numero é igual a 1") } else { 
  cat("o numero não é igual a 1") }

# Encadear vários if else
numero <- 10
if (numero == 1) { cat("o numero é igual a 1") } else if (numero == 2) { 
                  cat("o numero é igual a 2") } else { 
                  cat("o numero não é igual nem a 1 nem a 2") } 

# Exemplo
par_ou_impar <- function(x){ 
  if (abs(x - round(x)) > 1e-7) { 
    return(NA) 
  }
  if (x %% 2 == 0) { 
    return("par") 
  } else { 
      return("impar") 
  }
}

par_ou_impar(4) 
par_ou_impar(5)
par_ou_impar(1.999)  

x <- 1:5
par_ou_impar(x) #Dá erro ... a função if não é vetorizada
if (c(F, T)) {
  print("TRUE")
} else {
  "FALSE"
}

# Solução
sapply(x, par_ou_impar)

# Função ifelse é vetorizada
# ifelse(vetor_de_condicoes, valor_se_TRUE, valor_se_FALSE)

ifelse(c(TRUE, FALSE, FALSE, TRUE), 1, -1) 

par_ou_impar_ifelse <- function(x){
  x <- ifelse(abs(x - round(x)) > 1e-7, NA, x)
  ifelse(round(x) %% 2 == 0, "par", "impar")
}

x <- c(1:5,6.999,6.999999999999999)
par_ou_impar_ifelse(x)

# Vetorização 
par_ou_impar_vec <- function(x){ 
  res <- character(length(x))
  ind <- (round(x) %% 2) == 0
  res[ind] <- "par" 
  res[!ind] <- "impar"
  decimais <- abs(x - round(x)) > 1e-7 
  res[decimais] <- NA
  return(res)
}

x <- c(1:5,6.999,6.999999999999999)
par_ou_impar_vec(x)

?all.equal

install.packages("microbenchmark")
library(microbenchmark) 
microbenchmark(par_ou_impar_vec(1:1e3), par_ou_impar_ifelse(1:1e3))   

# Exercício
# forma diferente sem else
func_if2 <- function(x) {
  if(x > 1) return(x ^ 2)
  if (x < -1) return(-x ^ 2)
  return (x)
  }
  

func_ifelse <- function(x) {
  ifelse(x > 1, x^2, ifelse(x < -1, -x ^ 2, x))}

func_vet <- function (x){
  x[x > 1] <- x[x > 1]^2
  x[x < -1] <- -x[x < -1]^2
  return(x)
}

x <- c(-2,0,3)
func_if(x)
func_ifelse(x)
func_vet(x)

# Loops
for (i in 1:5){ 
  print(i) } 

x <- rep(NA, 5)
for (i in 1:5){
  x[i] <- i}
# a mesma coisa que x[1:5] <- 1:5

for (i in 1:5){ 
  print(letters[i]) }

for (letra in letters[1:5]){ 
  print(letra) } 


set.seed(119) 
x <- rnorm(10)

seq_along(x) #cria um vetor de inteiros com índices para acompanhar o objeto.
1:length(x)


x <- numeric(0)
# 1:length(x) 
# note que o loop é executado (o que é errado) 
for (i in 1:length(x)) print(i) 

# seq_along 
# note que o loop não é executado (o que é correto) 
for (i in seq_along(x)) print(i)

x <- 10:20
for (i in seq_along(x)) 
  x[i] <- x[i]/10
x

x <- 10:20
x <- x/10
x

set.seed(1)
# número de passos 
n <- 1000
# vetor para armazenar o passeio aleatório
passeio <- numeric(n) 
# primeiro passo 
passeio[1] <- sample(c(-1, 1), 1) 
# demais passos
for (i in 2:n) {
  # passo i é o onde você estava (passeio[i-1]) mais o passo seguinte 
  passeio[i] <- passeio[i - 1] + sample(c(-1, 1), 1)
  }
plot(passeio)
?plot

set.seed(1) 
passeio2 <- cumsum(sample(c(-1, 1), n, TRUE))
plot(passeio2)

all.equal(passeio, passeio2) 

# Sequência de Fibonacci
n <- 9 
fib <- numeric(n) 
# Defini os dois primeiros números
fib[1] <- 0 
fib[2] <- 1 
for (i in 3:n) { 
  fib[i] <- fib[i - 1] + fib[i - 2] } 
fib

# Loop com While
# Estrutura básica
# while (condicao) { 
  # codigo a ser executado 
  # até que condição seja TRUE 
  # em geral a condição será atualizada 
  # dentro do código 
# }

i <- 1

while (i<=5) {
print(i)
  i <- i + 1
}

# Loop infinito
while (i>=1) {
  print(i)
  i <- i + 1
}


set.seed(1) 
x <- rnorm(1) 
i <- 1

while (x < 2) { 
  i <- i + 1 
  x <- rnorm(1) }

i

# Função break
set.seed(25) 
for (i in 1:10) { 
  u <- runif(1) 
  if (u > 0.8) break() 
  print(i) } 

# Função next
set.seed(25) 
for (i in 1:10) { 
  u <- runif(1) 
  if (u > 0.5) next() 
  print(i) } 

# Outra forma de fazer while ... repeat + break
i <- 1 
repeat { 
  print(i) 
  i <- i + 1 
  if (i > 5) break() }

# Exercício
set.seed(123)
x <- rnorm (100,10,20)

func_max <- function(x){
  m <- x[1] 
  for (i in 2:length(x)){ #seqalong(x)
    if (x[i] > m) 
      m <- x[i]}
    return(m)}
  
func_max(x)
max(x)
all.equal(max(x), func_max(x))

func_fat <- function(n){
  if (n == 0) return(1) 
  fat <- 1
  for (i in 1:n){
    fat <- i*fat}
  return(fat)}

func_fat(5)
all.equal(factorial(10), func_fat(10)) 


# Com while
func_max <- function(x){
  i <- 1
  m <- x[1] 
  while (i <= length(x)){ 
    if (x[i] > m){ 
      m <- x[i]}
  i <- i + 1}
  return(m)}

func_max(x)

func_fat <- function(n){
  if (n == 0) return(1) 
  fat <- 1
  i <- 1
  while (i <= n){
    fat <- i*fat
  i <- i + 1}
  return(fat)}

func_fat(5)

# Família apply

mtcars #base de dados já existente no R

sapply(mtcars, mean) #resultado um vetor
lapply(mtcars, mean) #resultado uma lista

apply(mtcars, 2, mean) # 2 é coluna .... 1 é linha

# Sem usar a família apply
n <- ncol(mtcars)
medias <- numeric(n)
names(medias) <- colnames(mtcars)
for (i in seq_along(mtcars)) medias[i] <- mean(mtcars[,i])
medias

options(digits = 5) # Número de dígitos

meu_sapply <- function(x, funcao){
  n <- length(x)
  resultado <- numeric(n)
  names(resultado) <- names(x)
  for(i in seq_along(x)){ resultado[i] <- funcao(x[[i]]) }
  return(resultado)
}

meu_sapply(mtcars, mean)
sapply(mtcars, mean)
meu_sapply(mtcars, sd)
meu_sapply(mtcars, max)

set.seed(1) 
x <- matrix(rnorm(9), ncol = 3)
apply(x, 1, mean) # média das linhas
apply(x, 2, mean) # média das colunas

lista_de_matrizes <- list(x = x, tx = t(x))
lapply(lista_de_matrizes, solve) 

lapply(lista_de_matrizes, det) 
sapply(lista_de_matrizes, det) # Simplifica o resultado


ok <- list(x = matrix(1:10, ncol = 2), 
           y = matrix(11:20, ncol = 2))
nao_ok <- list(x = matrix(1:10, ncol = 2), 
               y = matrix(11:20, ncol = 5))

vapply(ok, colMeans, numeric(2)) 
vapply(nao_ok, colMeans, numeric(2)) # Erro

# apply(X, MARGIN, FUN, ...) 
# lapply(X, FUN, ...) 
# sapply(X, FUN, ..., simplify = TRUE, USE.NAMES = TRUE) 
# vapply(X, FUN, FUN.VALUE, ..., USE.NAMES = TRUE) 

#mapply é um "sapply" multivariado
# mapply(funcao, x, y, z)

?mapply
set.seed(112) 
x1 <- rnorm(100) 
x2 <- rnorm(100) 
mapply(mean, x = list(x1, x2), trim = list(0.1, 0.2)) 

# Replicate ... simulação de Monte Carlo
# replicate(numero_de_repeticoes, expressao)
sims <- replicate(1000, mean(rnorm(100))) 
hist(sims, col = "lightblue")