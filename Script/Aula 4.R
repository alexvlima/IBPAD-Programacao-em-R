# CURSO DE R - 4ª AULA
#FUNÇÕES

# queremos converter para numeric, retirar os dados discrepantes 
# dividir por 1000 e arredondar o resultado 
precos <- c("0.1", "1250.55", "2346.87", "3467.40", "10000000") 
precos <- as.numeric(precos) 
precos <- precos[!(precos < 1 | precos > 10000)] 
precos <- precos/1000 
precos <- round(precos) 
precos

# novo vetor de preços 
precos2 <- c("0.0074", "5547.85", "2669.98", "8789.45", "150000000") 
precos2 <- as.numeric(precos2) 
precos2 <- precos2[!(precos2 < 1 | precos2 > 10000)] 
precos2 <- precos2/1000 
precos2 <- round(precos2) 
precos2

# nomeDaFuncao <- function(arg1, arg2, arg3 = default3, ...)
# { # corpo da função: uma série de comados válidos. 
#   return(resultado) # opcional }

quadrado <- function(x){
                        x ^ 2 
                        }
quadrado(3) 
quadrado <- function(x) x ^ 2 ## se for na mesma linha nÃ£o precisa das chaves 
quadrado(3) 

## adicionando mais argumentos 
elevado_n <- function(x,n) x ^ n 
elevado_n(3, 3) 
x <- 10 
elevado_n(x, 2) # isso nÃ£o altera o valor de x! 

# se vocÃª quer salvar o resultado 
# tem que atribuir a outro objeto 
y <- elevado_n(x, 2)
y 

# Exercício
soma_e_subtrai <- function(x,y) {
                  resultado <- c(soma = x + y, subtracao = x - y)
                  return(resultado)
                  }
z <- 1 ; w <- 2
soma_e_subtrai(z,w)

# FIM

# Voltando ao exemplo inicial

limparDados <- function(dados){ 
                dados <- as.numeric(dados) 
                dados <- dados[!(dados < 1 | dados > 10000)] 
                dados <- dados/1000 
                dados <- round(dados) 
                return(dados)
                }


ls() # note que a função foi criada 

precos <- c("0.1", "1250.55", "2346.87", "3467.40", "10000000") 
precos2 <- c("0.0074", "5547.85", "2669.98", "8789.45", "150000000") 
precos3 <- c("0.02", "4560.45", "1234.32", "7894.41", "12000000") 
precos4 <- c("0.001", "1500000", "1200.9", "2000.2", "4520.5") 
precos5 <- c("0.05", "1500000", "1000000", "7123.4", "9871.5")

limparDados(precos)
limparDados(precos2)
limparDados(precos3)
limparDados(precos4)
limparDados(precos5)

lapply(list(precos, precos2, precos3, precos4, precos5), limparDados)
lapply(mget(ls(pattern = "precos")), limparDados)

# Colocando mais argumentos na função...posso estabelecer o outlier
limparDados <- function(dados, min, max, div){ 
                        dados <- as.numeric(dados) 
                        dados <- dados[!(dados < min | dados > max)] 
                        dados <- dados/div 
                        dados <- round(dados) 
                        return(dados)
                        }

precos3 <- c("0.02", "4560", "1234", "7894", "12000000")
limparDados(precos3, min = 0, max = 5000, div = 2)
limparDados(precos3, min = 0, max = 4000, div = 4)
limparDados(precos3, min = -Inf, max = Inf, div = 1) 

# argumentos em ordem diferente daquele definido na funÃ§Ã£o 
limparDados(max = 5000, div = 2, min = 0, dados = precos3) 
# argumentos sem nomes (colocar na ordem do que foi definido na funÃ§Ã£o) 
limparDados(precos3, 0, 4000, 4)


limparDados(precos3, max = 5000, div = 1) # Erro por faltar argumento
# Para sanar isto, basta definir valores padrão (default).
limparDados <- function(dados, min = 1, max = 10000, div = 1000){ 
  dados <- as.numeric(dados) 
  dados <- dados[!(dados < min | dados > max)] 
  dados <- dados/div 
  dados <- round(dados) 
  return(dados)
}
#Valores default para max, min e div
limparDados(precos3)

# usa o default para min 
limparDados(precos3, max = 5000, div = 1) 

# usa o default para min e div 
limparDados(precos3, max = Inf)

# Exercício            
divide <- function(x, divisor = 1){
  resultado <- x/divisor
  return(resultado)
  }           

divide(10,2)
divide(5)
divide(9,2)

?mean
media <- function(x, remove.nas = TRUE){
  resultado <- mean(x, na.rm = remove.nas)
  return(resultado)
  }
x<-c(10,0,NA,5)
media(x)
media(x,FALSE)

limparDados <- function(dados, min = 1, max = 10000, 
                        div = 1000, funcao = round){ 
                        dados <- as.numeric(dados) 
                        dados <- dados[!(dados < min | dados > max)] 
                        dados <- dados/div 
                        dados <- funcao(dados) 
                        return(dados) 
                        }

# usou os defaults 
limparDados(precos3)
# usa floor ao invÃ©s de round 
limparDados(precos3, funcao = floor)
# usa ceiling ao invÃ©s de round 
limparDados(precos3, funcao = ceiling)
# funcao anonima que pega x e retorna x (nÃ£o faz nada com x) 
limparDados(precos3, funcao = function(x) x)

# Funções Anônimas
limparDados(precos3, funcao = function(x) x) 
limparDados(precos3, funcao = function(x) x ^ 2)
limparDados(precos3, funcao = function(x) log(x + 1)) 
limparDados(precos3, funcao = function(x) { 
            x <- round(x) 
            x <- as.complex(x) 
            x <- (-x) ^ (x/10) 
            } )

# Argumento coringa "..."
limparDados <- function(dados, min = 1, max = 10000, 
                        div = 1000, funcao = round, ...){ #colocar ... apÃ³s round,
                        dados <- as.numeric(dados) 
                        dados <- dados[!(dados < min | dados > max)] 
                        dados <- dados/div 
                        dados <- funcao(dados, ...) #colocar ...apÃ³s dados,
                        return(dados) } 

limparDados(precos3)
limparDados(precos3, digits = 1)
limparDados(precos3, funcao = elevado_n, n = 2)

# Operadores binários
1+1
"+"(1,1)

"%+%" <- function(x, y) paste(x, y)
"colando" %+% "textos" %+% "com nosso" %+% "operador" 

"%depois%" <- function(x, fun) fun(x)
set.seed(10) 
x <- rnorm(100) 
sqrt(exp(mean(x)))
x %depois% mean %depois% exp %depois% sqrt

# Exercício
fun <- function(x, remove.na = TRUE){
        minimo <- min(x, na.rm = remove.na)
        mediana <- median(x, na.rm = remove.na)
        maximo <- max(x, na.rm = remove.na)
    return(c(min=minimo,mediana=mediana,max=maximo))
}
y <- c(NA,1:5)
fun(y)

?rep
"%rep%" <- function (x,n) rep(x, times=n)
2 %rep% 3

normaliza <- function(x, media = mean,...){
          media <- mean(x,...) 
          desvio_padrao <- sd(x)
          normal <- (x-media)/desvio_padrao
          return(normal)
          }
x<-c(10,5,0,5,10)
x
x2 <- normaliza(x)
round(mean(x2))
sd(x2)
regressao <- function(x,y){
          modelo <- lm(y ~ x)
          return(list(coef(modelo),x,y))
          }

# ESCOPO DE FUNÇÃO

x <- 2 #definimos um x na área de trabalho 
func <- function(){ x <- 3 # definimos um x dentro da função 
#isso altera o valor de x fora da função? 
print(x) 
# print vai ser 2 ou 3? 
rm(x) 
# removemos o x. Qual x? 
print(x) # vai dar erro? # não dá erro ...busca o x definido anteriormente 
} 

func() #Não dá erro
rm(x) #remove o x<-2
func() #acha o 3 e dá erro

x <- 500 
func2 <- function(){ 
  x <- 1000 
  func() # vai achar quais x? 
  }
func2() 
rm(x) # e agora? 
func2() 

# O R funciona com escopo lêxico!

# Métodos
plot
## function (x, y, ...) 
## UseMethod("plot") 
## <bytecode: 0x7fa5623b7a70> 
## <environment: namespace:graphics>

# A função plot é uma função genérica
plot.default
graphics:::plot.data.frame
# Dependendo do tipo de objeto, o R manda faz uma função diferente

# Exemplo
ols <- function(X, y)
{ b <- solve(t(X) %*% X) %*% t(X) %*% y 
  resultado <- list(coef = b, X = X, y = y) 
  class(resultado) <- "nossa_classe" 
  return(resultado) 
  }

plot.nossa_classe <- function(x) { 
  previsto <- X %*% (x$coef) 
  plot(y, xlab = "Obs", 
       main = "Real x Previsto", 
       ylab = "Real x Previsto") 
  points(previsto, col = "red") 
  legend("bottomright", 
         col = c("black", "red"), 
         pch=1, legend = c("Real", "Previsto") )  
  }

resultado <- ols(X,y)
plot(resultado)

methods(print)
stats:::print.lm

methods(plot)

methods(class="data.frame")