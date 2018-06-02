# CURSO DE R - 6ª AULA

imoveis <- readRDS("Dados/dados.rds") 

str(imoveis, vec.len = 1)

names(imoveis)[2] 
names(imoveis)[2] <- "endereco" 
names(imoveis)[2] 

imoveis$pm2 <- imoveis$preco/imoveis$m2
# imoveis$pm2 <- with(imoveis, preco/m2) # Função de conveniência with 
str(imoveis$pm2) 

head(imoveis) # mostra 6 primeiras linhas ... a função head é equivalente a select top no SQL
imoveis[1:6,] #equivalente a head

head(imoveis, 10) # mostra 10 primeiras linhas
imoveis[1:10,] # equivalente

tail(imoveis) # mostra as 6 últimas linhas 
imoveis[(nrow(imoveis)-5):nrow(imoveis),] # equivalente 
tail(imoveis, 10) # mostra as 10 últimas linhas 
imoveis[(nrow(imoveis)-10):nrow(imoveis),] # equivalente

# Subset
imoveis[1,] #primeira linha, todas as colunas 
imoveis[,1] #primeira coluna, todas as linhas 
imoveis[1,1] #primeira linha e primeira coluna 
imoveis[c(2,4,6), c(1,3:5)] #linhas 2, 4 e 6, e colunas 1,3,4,5
imoveis[1:10,-(1:5)] #linhas 1:10, exclui colunas 1 a 5
head(imoveis[-c(1,2,5),]) # exclui linhas 1, 2 e 5

# com nomes
imoveis[imoveis$bairro == "Asa Sul", c("data", "bairro", "preco")] 
subset(imoveis, bairro == "Asa Sul", select=c(data, bairro, preco))


precos1 <- imoveis$preco # vetor 
precos2 <- imoveis[ ,"preco"] # vetor 
precos3 <- imoveis[["preco"]] # vetor 
precos4 <- imoveis["preco"] # data.frame 
precos5 <- subset(imoveis, select=preco) # data.frame
precos6 <- imoveis[,"preco", drop=FALSE] # data.frame

str(precos1)
str(precos4)
rm(list=ls(pattern="precos"))

# Filtrando com índices lógicos
indice <- with(imoveis, coleta=="2014-08-31" & 
                 tipo=="venda" & 
                 preco > 1e6) 
sum(indice) # quantos imóveis?

dia31_venda_maior1m <- imoveis[indice,] # filtrando

# Operação com subset
dia31_venda_maior1m <- subset(imoveis, coleta == "2014-08-31" & 
                                tipo == "venda" & 
                                preco > 1e6)

imoveis$m2_cat <-
  cut(imoveis$m2, 
      breaks= c(0, 50, 150, 200, 250, Inf), 
      labels=c("de 0 a 50 m2", "de 50 a 150 m2", 
               "de 150 a 200 m2","de 200 a 250 m2", 
               "mais de 250 m2") )
str(imoveis$m2_cat)

unique(imoveis$tipo) 
unique(imoveis$imovel) 
unique(imoveis$bairro)
# Semelhante ao Select XXX From base Group by XXX

subset(imoveis, bairro == "Brasília", select=c(data, endereco))

unique(imoveis$coleta) # quais os dias de coleta únicos? 
length(unique(imoveis$link)) # quantas observações únicas? 

# Eliminar as duplicidades
duplicados <- duplicated(imoveis$link) 
unicos <- imoveis[!duplicados, ]

# Eliminar as linhas que possuem algum valor não informado em alguma coluna
unicos <- na.omit(unicos)

sapply(imoveis, function(x){
  length(unique(x))})

sapply(imoveis, function(x){
  sum(is.na(x))})

sapply(unicos, function(x){
  length(unique(x))})

sapply(unicos, function(x){
  sum(is.na(x))})

# outra forma
sapply(list(imoveis, unicos), 
       function(x) sapply(x, function(x) length(unique(x))))

# Separar, Dividir e Combinar
# Calculando a média separado por aluguel e venda de forma mais 
aluguel <- unicos[unicos$tipo == "aluguel", ] 
venda <- unicos[unicos$tipo == "venda", ]

media_aluguel <- mean(aluguel$preco) 
media_venda <- mean(venda$preco)

medias = c(aluguel = media_aluguel, venda = media_venda) 
medias 

# Simplificando
# com tapply 
tapply(X = unicos$preco, INDEX = unicos$tipo, FUN = mean)

# com aggregate ... retorna um data frame
aggregate(x = list(media = unicos$preco), by = list(tipo = unicos$tipo), 
          FUN = mean)

# com dplyr 
library(dplyr) 
unicos %>% group_by(tipo) %>% summarise(media = mean(preco))

# Função split
str(split)

alug_venda <- split(unicos$preco, unicos$tipo)
str(alug_venda, max.level = 1) 
medias <- lapply(alug_venda, mean) # pode usar também o sapply
medias 
unlist(medias) #transforma uma lista em um vetor

# Função do.call que combina argumentos
# do.call("alguma_funcao", lista_de_argumentos) = 
#   alguma_funcao(lista_de_argumentos[1], 
#                 lista_de_argumentos[2], 
#                 ..., 
#                 lista_de_argumentos[n])

do.call("rbind", medias) 
do.call("cbind", medias) 

sapply(alug_venda, mean)

vapply(alug_venda, mean, numeric(1)) 
vapply(alug_venda, mean, character(1)) #Erro porque o resultado é um atributo do tipo 'double'

lapply(alug_venda, summary) 

# filtro para venda 
ok.venda <- with(unicos, tipo == "venda" & pm2 > 3000 & pm2 < 20000)

# filtro para aluguel 
ok.aluguel <- with(unicos, tipo == "aluguel" & pm2 > 25 & pm2 < 100)

# juntando os dois 
ok <- (ok.venda | ok.aluguel)

# separando outliers e limpos 
outliers <- unicos[!ok,] 
limpos <- unicos[ok,]

# Função tapply
str(tapply) 

y <- tapply(limpos$pm2, limpos$tipo, median) 
str(y)
t <- tapply(limpos$pm2, list(limpos$bairro, limpos$tipo), median)
str(t)

aps <- limpos[limpos$imovel == "apartamento", ]
with(aps, tapply(pm2, list(quartos, tipo), median)) 

# Função aggregate
# aggregate(dados$valor, by = list(dados$indice1, dados$indice2), funcao)
# aggregate(valor ~ indice1 + indice2, dados, funcao)

pm2_bairro_tipo_imovel <- aggregate(formula = pm2 ~ bairro + tipo + imovel, 
                                    data = limpos, 
                                    FUN = median) 
head(pm2_bairro_tipo_imovel) 

# mais de uma variável a ser agregada
mediana_aluguel <- aggregate(cbind(preco, m2, pm2) ~ bairro, 
                             data = limpos, subset = (tipo == "aluguel" & 
                                                        imovel == "apartamento"), 
                             FUN = median)
mediana_aluguel[order(mediana_aluguel$pm2, decreasing = TRUE), ]

# Função dplyr
# pipe operator %>%
# library(dplyr)
?dplyr()
browseVignettes(package = "dplyr")

limpos %>% filter(imovel == "apartamento") %>%
  select(bairro, preco, m2) %>% mutate(pm2 = preco/m2) %>% 
  arrange(desc(pm2)) %>% head(10)

limpos %>% 
  filter(imovel == "apartamento", tipo == "venda") %>% 
  group_by(bairro) %>% 
  summarise(Mediana_Preco = median(preco), 
            Mediana_M2 = median(m2), 
            Mediana_pm2 = median(pm2), 
            Obs = length(pm2)) %>% #pode usar length(n()) - função de conveniência do dplyr
  filter(Obs > 30) %>% 
  arrange(desc(Mediana_pm2))

# Para mostrar sem ser científico 
options(scipen = 99999)

consulta <-
  imoveis %>% filter(grepl("SQ(N|S) (4|3|2|1)0(1|2|3|4)", endereco), 
                             tipo == "aluguel", 
                             bairro %in% c("Asa Sul", "Asa Norte"), 
                             preco < 2200, 
                             coleta == "2014-08-31")

# Exercício
# Sua vez. Considerando a base de dados limpos, Responda: 
# Qual o bairro com o maior preço mediano de venda? 
# Qual o bairro com o maior preço por m2 mediano de venda? 
# Qual o bairro com o maior preço mediano de venda para apartamentos? 
# Qual o bairro com o maior preço mediano de venda para lojas?


# Função merge()

# x: um data.frame 
# y: um data.frame 
# by: a coluna em comum nos data.frames pela qual será feito o merge. 
# all, all.x, all.y: especiﬁca o tipo do merge. 
# O default é FALSE e é equivalente ao “natural join” do SQL; 
# “all” é equivalente ao “outer join”; 
# “all.x” é equivalente ao “left outer join” e 
# “all.y” é equivalente ao “right outer join”.

dados1 <- aggregate(formula = pm2 ~ bairro, 
                    data = limpos, 
                    subset = (limpos$tipo == "aluguel"), 
                    FUN = median)

dados2 <- aggregate(formula = pm2 ~ bairro, 
                    data = limpos, 
                    subset = (limpos$tipo == "venda"), 
                    FUN = median)

names(dados1)[2] <- "aluguel" 
names(dados2)[2] <- "venda"

merge_all_false <- merge(dados1, dados2, all = FALSE)
merge_all_true <- merge(dados1, dados2, all = TRUE)

str(merge_all_false)
str(merge_all_true) 

# usando o dplyr
innerjoin <- inner_join(dados1, dados2) 
fulljoin <- full_join(dados1, dados2) 

# Formato Wide ("Largo", "Pivoteado") x Long ("Longo", "Empilhado")
# Formato wide é equivalente a tabela dinâmica do excel (pivot table de uma tabela long)
# Formato Long é equivalente ao banco de dados tradicional
# O resultado do tapply vem em formato wide
# O resultado do aggregate e do dplyr vem em formato long

ap_wide <- tapply(aps$preco, list(aps$bairro, aps$m2_cat), median) 
ap_wide[1:2, 1:3] 

library(reshape2) 
ap_long <- melt(ap_wide) 
head(ap_long, 2) 

long <- aggregate(pm2 ~ bairro + tipo + imovel + quartos, 
                  data = limpos, median) 
head(long, 2) 

wide <- dcast(data = long, 
              formula = imovel + quartos ~ tipo + bairro, 
              value.var = "pm2", sum) 
wide[1:2, 1:4] 

# Para mais dimensões do que duas, é preciso usar um array
cast2 <- acast(long, imovel~quartos~tipo~bairro, 
               value.var="pm2", sum)
str(cast2, vec.len=2)
cast2[,,"venda","Asa Sul"]

library (tidyr) #só trabalha para data.frame e transforma de long para wide
library (dplyr)

tidy_wide <- long %>% 
  spread(imovel, pm2)
head(tidy_wide)


tidy_long <- tidy_wide %>% 
  gather(imovel, pm2, -bairro, - tipo, - quartos)
head(tidy_long)
