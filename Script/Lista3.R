### LISTA 3 ###

# 1. Considere os dados em roubo2.rds. Esses dados contêm registros online 
# de crimes por todo o Brasil,e foram coletados do site OndeFuiRoubado? 
# (http://www.ondefuiroubado. com.br).

library(dplyr)
getwd()
?readRDS
roubo <- readRDS("Dados/roubo2.rds")

View(roubo)
str(roubo)

# Utilize sapply para calcular o número de NA’s por colunas. 
sapply(roubo, function(x) sum(length(which(is.na(x)))))
sapply(roubo, function(x) sum(is.na(x)))
summary(roubo)

# Calcule o número de crimes por cidade e ordene de forma decrescente. 
# Onde houve mais crimes registrados? 
# Com dplyr
roubo %>% group_by(cidade) %>% summarise(n_crimes = length(tipo))
roubo %>% group_by(cidade) %>% summarise(n_crimes = n()) %>% arrange(desc(n_crimes))

# Quantos crimes foram registrados em Brasília? 
roubo %>% filter(cidade == "Brasília/DF") %>% summarise(n_crimes = n())
sum(roubo$cidade == 'Brasília/DF')

# Calcule o número de crimes por tipo de crime. Qual o tipo de crime mais frequente? 
roubo %>% group_by(tipo) %>% summarise(n_crimes = n()) %>% arrange(desc(n_crimes)) 
  
# Calcule, por cidade, a frequencia relativa de tipo de crime. 
roubo %>% 
  group_by(cidade, tipo) %>% 
  summarise(n=n()) %>%
  group_by(cidade) %>% 
  mutate(n_cidade = sum(n)) %>% 
  mutate(percentual = n / n_cidade) %>%
  arrange(desc(n_cidade, percentual)) %>%
  View()
  
tapply(roubo$tipo, roubo$tipo, length)
  
# Das cidades que tem mais de 100 registros, qual cidade tem a maior proporção de assalto à mão armada? 
roubo %>% 
  group_by(cidade, tipo) %>% 
  summarise(n=n()) %>%
  group_by(cidade) %>% 
  mutate(n_cidade = sum(n)) %>% 
  mutate(percentual = n / n_cidade) %>%
  arrange(desc(n_cidade, percentual)) %>%
  filter(n_cidade > 100) %>%
  View()

