rm(list = ls())

# install.packages("XML")
library(XML)

inicio <- Sys.time()

dados.venda <- vector()

inicial <- htmlTreeParse("http://www.wimoveis.com.br/df/brasilia/apartamento/venda/?busca=galeria&r=0&s=0&o=P&pronto=1&pg=0", useInternalNodes = T)
pagina <- as.numeric(xpathApply(inicial, "//span[@id='ctl00_Resultado_ResultadoGaleriaUC1_NavegacaoUC1_labelPaginas']", xmlValue))

i = 1
for (i in 0:(pagina - 1)) {
  print(i)
  site <- paste0("http://www.wimoveis.com.br/df/brasilia/apartamento/venda/?busca=galeria&r=0&s=0&o=P&pronto=1&pg=",i)
  
  html.raw <- htmlTreeParse(site,useInternalNodes = T)
  
  bairro <- xpathApply(html.raw,"//b[@class='bairro_galeria']", xmlValue)
  bairro <- unlist(bairro)
  bairro <- trimws(bairro)
  
  location <- xpathApply(html.raw, "//div[@class='borda_galeria']//h3", xmlValue)
  location <- unlist(location)
  
  preco <-  xpathApply(html.raw, "//div[@class='borda_galeria']//h4", xmlValue)
  preco <- sapply(preco, gsub, pattern = "\\.|\\s", replacement = "")
  preco <- sapply(preco, gsub, pattern = ",", replacement = "\\.")
  preco <- as.numeric(preco)
  
  quartos <- xpathApply(html.raw, "//div[@class='borda_galeria']/h5[contains(., 'Quartos:')]/following-sibling::span[1]", xmlValue)
  quartos <- as.numeric(unlist(quartos))
  quartos
  
  m2 <- xpathApply(html.raw,"//div[@class='borda_galeria']//span[contains(.,'m')]",xmlValue)
  m2 <- sapply(m2, gsub, pattern = "[^[:digit:]|[:punct:]]|?", replacement = "")
  m2 <- sapply(m2, gsub, pattern = ",", replacement = "\\.")
  m2 <- as.numeric(m2)
  
  corretora <- xpathApply(html.raw, "//div[@class='anunciante']//p[not(@class='ofertas')]", xmlValue)
  corretora <- sapply(corretora, gsub, pattern = "[[:alpha:]]|[[:punct:]]|\\s", replacement = "")
  
  data <- xpathApply(html.raw, "//div[@style='float: right;']/b", xmlValue)
  data <- unlist(data)
  data <- as.Date(data, format = "%d/%m/%y")
  
  link <- xpathApply(html.raw, "//div[@class='borda_galeria' and @style='line-height: 15px; width: 100%;']/a[h3]", xmlAttrs)
  link <- sapply(link, '[', "href")
  
  df <- data.frame(bairro = bairro, 
                   location = location, 
                   preco = preco,
                   quartos = quartos,
                   m2 = m2, 
                   corretora = corretora,
                   data = data,
                   link = link,
                   stringsAsFactors = FALSE)
  
  dados.venda <- rbind(dados.venda, df)
}

dados.venda$coleta <- Sys.Date()

fim <- Sys.time()
fim - inicio

