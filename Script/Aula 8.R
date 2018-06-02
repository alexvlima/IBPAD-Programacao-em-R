# CURSO DE R - 8ª AULA
# MANIPULANDO ARQUIVOS E PASTAS

getwd() # get working directory 

setwd("C:\\Users\\Alexandre\\Documents\\Trabalho") 
getwd() 
setwd("C:/Users/Alexandre/Desktop/Curso de R - IBPAD")
getwd()

# \\ ou / é igual a barra

file.path("C:", 
          "diretorio1", 
          "diretorio2", 
          "arquivo.csv") 

# listar os arquivos e diretórios que estão em uma pasta 
list.files("C:/Users/Alexandre/Desktop/Curso de R - IBPAD") 

# listar os diretórios e subdiretórios que estão em uma pasta 
list.dirs()

# verificar se um arquivo existe 
file.exists("io.pdf")
file.exists("arquivoquenaoexiste") 

file.create("arquivoquenaoexiste") 
file.exists("arquivoquenaoexiste") 

# remover arquivo 
file.remove("arquivoquenaoexiste") 
file.exists("arquivoquenaoexiste") 

# criar pastas 
dir.create("Nova Pasta"); list.dirs() 
file.remove("Nova Pasta"); list.dirs() 

# É possível também renomear e mover arquivos com file.rename(), ou copiar 
# arquivos file.copy() entre outras funções. 
# No limite, você pode usar diretamente os comandos do shell (DOS) do Windows.

# Cria diretório via DOS 
shell("md teste")

# Remove diretório via DOS 
shell("rmdir teste")

# Salvar e lê arquivos

# RData ou rda: salva um ou vários objetos da área de trabalho. Carrega com o mesmo nome que foi salvo.
# rds: salva apenas um objeto. É possível carregar com nome diferente.

mtcars <- mtcars 
# salva em rdata 
save(mtcars, file = "mtcars.RData") 
rm(mtcars) 
ls() 

load(file = "mtcars.RData") 
ls()

saveRDS(mtcars, file = "mtcars.rds") 
rm(mtcars)

dados <- readRDS("mtcars.rds") 
ls() 

# PLANILHA e WEB: csv, xlsx, XML e JSON
?read.table
?write.table

# dec: determina o símbolo utilizado para decimal. 
# No Brasil, utilizamos “,” mas em muitos outros lugares o padrão é “.”.

# sep: como os dados estão separados? 
# Por tab (\t), por vírgula (,), por ponto e vírgula (;), por espaço (" “)? 

# fileEncoding: o padrão do R, em geral, é trabalhar com caracteres ASCII. 
# No Brasil, são comuns os padrões latin1 ou UTF-8. 
# Ler o arquivo com o padrão errado pode resultar em caracteres “estranhos”.

# CSV
write.csv2(mtcars, "mtcars.csv") #Padrão latino e europeu, enquanto write.csv é o padrão americano
carros <- read.csv("mtcars.csv", dec = ",", sep = ";") #Poderia utilizar o read.csv2 que possui os parâmetros brasileiros
carros <- read.csv2(file = "mtcars.csv", stringsAsFactors = F)

# Excel
# Pacote         Acessa o Excel por
# readxl    C e C++ (somente leitura) 
# xlsx              Java 
# XLconnect         Java 
# openxlsx           C++ 
# RODBC             ODBC 
# gdata             perl

# # install.packages("xlsx")
# # library(xlsx)  # Problema com Java
# # write.xlsx(mtcars, "mtcars.xlsx") 
# 
# install.packages("openxlsx")
# library(openxlsx)
# #Precisa configurar variáveis no ambiente windows
# write.xlsx(mtcars, "mtcars.xlsx")

# ex1 <- read.xlsx("mtcars.xlsx",sheetIndex = 1)
# library(readxl) 
# ex2 <- read_excel("mtcars.xlsx", sheet = 1)

# JSON e XML
# Formato Pacote recomendado 
# JSON jsonlite 
# XML xml2

# STATA, SPSS, SAS
# Para ler dados de pacotes estatísticos, existem dois pacotes principais: o foreign e o haven. 
# Função do Haven    Pacote estatístico 
# read_dta()        Lê arquivos do STATA 
# read_stata()      Lê arquivos do STATA 
# write_stata()     Salva arquivos STATA 
# read_por()        Lê arquivos do SPSS 
# read_sav()        Lê arquivos do SPSS 
# read_spss()       Lê arquivos do SPSS 
# write_sav()       Salva arquivos do SPSS 
# read_sas()        Lê arquivos do SAS

# Banco de Dados
# Pacote               Conversa com... 
# RMySQL                   MySQL 
# RDOBC             SQL Server via ODBC 
# RPostgres               Postgres 
# RSQLite                  SQLite 
# rmongodb, mongolite     MongoDB 
# RCassandra             Cassandra