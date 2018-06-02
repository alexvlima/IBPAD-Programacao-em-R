# CURSO DE R - 1ª AULA
# Para rodar a syntaxe CTRL + ENTER ... isso envia para o console interpretar.

# Gerar HTML, PDF ou Word
# install.packages("rmarkdown") 

1+1

# Gráfico dos números de 1 a 10
plot (1:10)

# Para receber valores utilizar <-
x<-15
# Também recebe valores se utilizar o = 
y=15

# Rodar o script inteiro CTRL + SHIFT + ENTER
# Salvar CTRL + S

# Acessar a ajudar pode ser por ? ou help()
?mean ; help(mean)

# Buscar por nome, utilizar ??"" ou help.search()
??"normal distribuition" ; help.search("normal distribuition")


### Algumas funções necessitam de carregar o pacote primeiro ###
# EXEMPLO

Sigma <- matrix(c(10,3,3,2), nrow = 2, ncol = 2) # Matriz de Var-Covar 
mu <- c(1, 10) # Médias 

x <- mvrnorm(n = 100, mu, Sigma) # Tenta gerar 100 obs, mas dá erro 

## Error in eval(expr, envir, enclos): não foi possível encontrar a função "mvrnorm"

library(MASS) # Carrega pacote 
x <- mvrnorm(n = 100, mu, Sigma) # Agora funciona

cor(x) # Correlação entre a variável 1 e a variável 2 de X

search() # Mostra quais pacotes estão carregados

# detach(package:MASS) # Descarregar pacote

# A forma de chamar uma função de um pacote, tenha outro pacote com a mesma função, é pacote::função
x <- MASS::mvrnorm(n = 100, mu , Sigma) 

install.packages("dplyr")
# remove.packages(dplyr) # Para remover o pacote

library(dplyr)
 
# install.packages("ggplot2")
# install.packages("ggthemes")
# install.packages("tidyr")
# install.packages("reshape2")
# install.packages("stringr")

# Instalar pacotes de uma só vez
install.packages(c("ggplot2", "ggthemes", "tidyr", "reshape2", "stringr"))

library(ggplot2)
library(ggthemes)
library(tidyr)
library(reshape2)
library(stringr)

# install.packages("lattice")