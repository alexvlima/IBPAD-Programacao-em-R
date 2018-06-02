# CURSO DE R - 7ª AULA

# criando um vetor de textos 
# aspas simples 
x1 <- 'texto 1'

# aspas duplas 
x2 <- "texto 2"

# criando um vetor de inteiros 
x3 <- 1:10

# É texto? Não. 
is.character(x3) 

# Convertendo para texto 
x3 <- as.character(x3)

# Agora é texto? Sim. 
is.character(x3)

# ordenação de letras 
sort(c("c", "d", "a", "f"))

# ordenação de palavras 
# tal como um dicionário 
sort(c("cor", "casa", "árvore", "zebra", "branco", "banco")) 

# CUIDADO! 
2 > 100 
"2" > "100"
# b > a 
"b" > "a"

# Imprime texto na tela 
print(x1)

# Quando em modo interativo 
# Equivalente a print(x1) 
x1

# sem print não acontece nada 
for(i in 1:3) i
# com print o valor de i é exibido 
for(i in 1:3) print(i)

cat(x1) #Função cat (concatenate and print)
cat("A função cat exibe o texto sem aspas:", x1) 
cat(x1, x2)
cat(x1, x2, sep = " - ") 

# Outra funções úteis são sprintf() e format()
?sprintf
?format

# %.2f (float, 2 casas decimais) 
sprintf("R$ %.2f", 312.12312312) 

# duas casas decimais, separador de milhar e decimal 
format(10500.5102, nsmall=2, big.mark=".", decimal.mark=",") 

# texto com duas linhas
texto_nova_linha <- "texto 
com nova linha"
texto_nova_linha #nova linha representado por /n 

# print: \n aparece literalmente 
print(texto_nova_linha) 
# cat: \n aparece como nova linha 
cat(texto_nova_linha) 

cat("colocando uma \nnova linha")
cat("colocando um \ttab") 
cat("colocando uma \\ barra") 
cat("texto com novas linhas e\numa barra no final\n\\") 

# Aspas simples dentro do texto 
aspas1 <- "Texto com 'aspas' simples dentro" 
aspas1 
aspas2 <- 'Texto com "aspas" duplas dentro' 
cat(aspas2) 
aspas3 <- "Texto com \"aspas\" duplas" 
cat(aspas3) 
aspas4 <- 'Texto com \'aspas\' simples' 
cat(aspas4) 

for (i in 1:100) {
  # imprime quando o resto da divisão 
  # de i por 25 é igual a 0 
  if (i %% 25 == 0) { 
  cat("Executando: ", i, "%\n", sep = "") 
  } 
  # alguma rotina 
  Sys.sleep(0.05) 
}

#ou com tempo aleatório (utilizado a distribuição uniforme)
for (i in 1:100) {
  # imprime quando o resto da divisão 
  # de i por 25 é igual a 0 
  if (i %% 25 == 0) { 
    cat("Executando: ", i, "%\n", sep = "") 
  } 
  # alguma rotina 
    tempo <- runif (1, min = 0.01, max = 0.1)
    Sys.sleep(tempo) 
}

# Função rle
x <- rle(c(1,1,1,0))
x
# resultado é uma lista 
str(x)
unclass(x)

# Isso ocorre porque a classe rle tem um método de print próprio, print.rle():

print.rle <- function (x, digits = getOption("digits"), prefix = "", ...) 
  { if (is.null(digits)) 
    digits <- getOption("digits") 
  cat("", "Run Length Encoding\n", " lengths:", sep = prefix) 
  utils::str(x$lengths) 
  cat("", " values :", sep = prefix) 
  utils::str(x$values, digits.d = digits) 
  invisible(x) 
}

# O vetor x1 tem apenas um elemento 
length(x1)
# O elemento do vetor x1 tem 7 caracteres 
# note que espaços em brancos contam 
nchar(x1)

# A função nchar() é vetorizada.
# vetor do tipo character 
y <- c("texto 1", "texto 11")
length(y)
# O primeiro elemento tem 7 caracteres 
# O segundo 8. 
nchar(y) # vetorizada 

# Função paste permite concatenar textos
tipo <- "Apartamento" 
bairro <- "Asa Sul" 
texto <- paste(tipo,"na", bairro ) 
texto 

# separação padrão 
paste("x", 1:5) 
# separando por ponto 
paste("x", 1:5, sep=".") 
# sem separação, usando paste0. 
paste0("x", 1:5) #Ou paste("x", 1:5, sep="")

paste("x", 1:5, sep="", collapse = " ") #colocando tudo em um único vetor com um espaço em branco
paste("x", 1:5, sep="", collapse=" --> ") #colocando tudo em um único vetor e separado por -->

# Separando textos
dados <- "1;2;3;4;5;6;7;8;9;10" 
dados 
# Função strsplit()
dados_separados <- strsplit(dados, split=";") 
dados_separados
# convertendo o resultado em número 
dados_separados <- as.numeric(dados_separados[[1]])
dados_separados

mean(dados_separados)
sum(dados_separados)

# Maiúsculas e minúsculas
toupper(texto) # Caixa Alta
tolower(texto) # Caixa Baixa

# Carrega arquivo de aluguel do dropbox
arquivo <- url("https://dl.dropboxusercontent.com/u/44201187/aluguel.rds") 
con <- gzcon(arquivo) 
aluguel <- readRDS(con) 
close(con)

str(aluguel, vec.len = 1) 

# Econtrando parte de um texto ... função grep e grepl
busca_indice <- grep(pattern = "CLN 310", aluguel$endereco) 
busca_indice 

aluguel[busca_indice,]
aluguel[c(1,1812),]

busca_logico <- grepl(pattern = "CLN 310", aluguel$endereco) 
str(busca_logico) 
aluguel[busca_indice,]

# Substituindo partes de um texto ... função sub e gsub
texto2 <- paste(texto, ", Apartamento na Asa Norte") 
texto2 
# Vamos substituir "apartamento" por "Casa" 
# Mas apenas o primeiro caso 
?sub
sub(pattern = "Apartamento", 
    replacement = "Casa", 
    texto2) 

sub(pattern = "Apartamento", 
    replacement = "Casa", 
    texto2) 

# Vamos substituir "apartamento" por "Casa" 
# Agora em todos os casos 
gsub(pattern = "Apartamento", 
     replacement = "Casa", 
     texto2) 

# Exemplo
arquivos <- c("simulacao_1.csv","simulacao_2.csv")
# queremos eliminar a extensão .csv 
# note que o ponto precisa ser escapado 
nomes_sem_csv <- gsub("\\.csv", "", arquivos) 
nomes_sem_csv 

# Extraindo partes especíﬁcas de um texto por posição... função subtr e substring
x <- "Um texto de exemplo" 
substr(x, start = 4, stop = 8)
substr(x, start = 4, stop = 8) <- "TEXTO" 
x 

substring(x, first = c(4, 10), last = c(8, 11)) 
substring("abcdef", first = 1:6)

# install.packages("stringr")
library(stringr)
?stringr
# tolower e toupper e Title 
str_to_lower(texto)
str_to_upper(texto) 
str_to_title(texto) 

# removendo espaços em branco 
str_trim(c(" 12 ", " 12321 ")) 

# preenchendo até completar um número de caracteres 
str_pad(c("12", "12321"), 10, pad = 0)

# split 
str_split(dados, ";") 

# detectando textos 
cln_310 <- str_detect(aluguel$endereco, pattern = "CLN 310") 
which(cln_310) 

# substituindo partes do texto (primeira ocorrência) 
str_replace(texto2, "Apartamento", "Casa")

# substituindo partes do texto (todas ocorrência) 
str_replace_all(texto2, "Aparamento", "Casa") 

# extraindo textos 
x <- "dsj1302932kl2014-09-01da5465464-546jsl139022015-12-12çsa"
# extraindo primeira ocorrência 
str_extract(x, pattern = "[0-9]{4}-[0-9]{2}-[0-9]{2}") #Em expressão regular o [] apresenta qualquer caracter entre 0 e 9 e p {} indica quantos caracteres
# estraindo todas ocorrências 
str_extract_all(x, pattern = "[0-9]{4}-[0-9]{2}-[0-9]{2}") 

# Selcionando um texto dentro de parênteses
texto <- "djashdjashf(texto)sadsddsalk"
gsub(".*\\((.*)\\).*", "\\1", texto)

rm(x3)
x1 <- 10
x2 <- 20
ls(pattern = "x[0-9]")

gsub ("\\\\", "", "\\remove barra\\")

# FATORES (Dados categóricos)

bairros <- c("Asa Sul","Asa Norte", "Sudoeste", "Asa Sul","Asa Norte", 
             "Noroeste","Asa Norte", "Sudoeste", "Asa Norte") 
fac_bairros <- factor(bairros) 
str(fac_bairros) 

temps <- c("Alta", "Baixa", "Média", "Média", "Média", 
           "Alta", "Alta", "Média", "Baixa","Baixa","Baixa")
fac_temps <- factor(temps, order=TRUE, 
                    levels=c("Baixa", "Média", "Alta"))
fac_temps[1] > fac_temps[2]

fac_temps 
levels(fac_temps) <- c("B", "M", "A", "MA") 
fac_temps 

summary(temps)
summary(fac_temps) 
table(temps) 
table(fac_temps) 

grupo <- rep(c("G1", "G2"),length.out=11) 
table(grupo, temps) 

# gráficos dispostos em 1 linha e 2 colunas 
par(mfrow=c(1,2)) 
#plot 
plot(fac_temps, col="lightblue", main="Temperaturas") 
plot(fac_bairros, col="darkred", main="Bairros")

# Cuidado!
numeros <- c(5,6,7,8) 
numeros <- as.factor(numeros) 
as.numeric(numeros) 
# O que aconteceu?
str(numeros) 
# como extrair os números de volta
as.numeric(as.character(numeros)) 
# com texto, sem problemas 
bairros[5] <- "Octogonal" 
bairros 
# com factor 
fac_bairros[5] <- "Octogonal" 
fac_bairros

# Na maior parte dos casos, use o parâmetro stringsAsFactors = FALSE

# REPRESENTANDO E MANIPULANDO DATAS
Data <- "01 de janeiro de 2014"
class(Data)
str(Data)

as.Date(Data, format="%d de %B de %Y") 
Data <- as.Date(Data, format="%d de %B de %Y")
str(Data) 

Data + 1 
Data - 1 
weekdays(Data)
Data > "2013-12-01"

months(Data + 31) 
quarters(Data) 

seq.Date(from = Data, by = 1, length.out = 10L) #pode utilizar to from igual a número

# Format    Descrição 
# %Y      Ano com 4 dígitos 
# %y      Ano com 1/2 dígitos 
# %m      Mês com 2 dígitos 
# %B      Mês por Extenso completo 
# %b      Mês por Extenso abreviado 
# %d      Dia com 1/2 dígitos 
# %A      Dia da semana por extenso 
# %a      Dia da semana por abreviado 
# %w      Dia da semana número

Data
cat( 
  format(Data, 
         format="isto ocorreu %A, \ndia %d de %B de %Y.") 
     )

# POSIXct e POSIXlt
# Dois formatos de datas ... com hora, minuto e segundo
# Format Descrição 
# %H Hora (00-23) 
# %I Hora (1-12) 
# %M Minutos (00-59) 
# %S Segundos (00-61) 
# %p AM/PM

Data <- "01 de janeiro de 2014 às 14h e 40m" 
ct <- as.POSIXct(Data, 
                 format="%d de %B de %Y às %Hh e %Mm") 
ct
lt <- as.POSIXlt(Data, 
                 format="%d de %B de %Y às %Hh e %Mm") 
lt
ct + 3600 # soma uma hora
lt - 60 # subtrai um minuto 
months(ct)
weekdays(lt)

# lubridate: funções de conveniência para lidar com formatação de datas. 
# ts, zoo, xts: pacotes que estendem os objetos de séries temporais do R, interessantes para quem modela séries temporais. O xts é construído em cima tanto do zoo quanto do ts.

# Exemplo
imoveis <- readRDS(file = "Dados/dados.rds")
str(imoveis)
format(imoveis$data, format = "%Y")

imoveis$dia_semana <- format(imoveis$coleta, format = "%a")

library(dplyr)
imoveis %>% group_by(dia_semana) %>%
  summarise((mediana = median(preco)))