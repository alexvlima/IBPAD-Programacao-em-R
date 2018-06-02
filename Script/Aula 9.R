# CURSO DE R - 9ª AULA
# DESENHANDO GRÁFICOS

rm(list = ls())

library(ggplot2) 
library(dplyr) 

limpos <- readRDS("Dados/limpos.rds") 
venda <- limpos %>% 
  filter(tipo == "venda", 
         quartos < 10, 
         imovel == "apartamento", 
         bairro %in% c("Asa Sul","Asa Norte", 
                       "Noroeste","Sudoeste"))

# Função plot e curve
plot(function(x) x^2, from = -10, to = 10)
curve(dnorm(x), -4, 4)
with(venda, plot(m2, preco)) # ou plot(venda$m2, venda$preco)
with(venda, smoothScatter(m2, preco)) # suaviza o scatter plot

with(venda, coplot(preco ~ m2 | bairro)) #Separado por grupo

# Personalizando parâmetros
?par #parâmetro do gráfico
with(venda, plot(m2, preco, 
                 col = "darkblue", 
                 main = "Título do Gráfico", 
                 xlab = "Eixo X", 
                 ylab = "Eixo Y", 
                 pch = 20, 
                 cex = 0.5))
plot(1:20, pch = 1:20)
plot(1:20, pch = "A")

# Gráfico de linhas
library(ggplot2) # para a base de dados economics 
plot(psavert ~ date, type = "l", data = economics) # não está utilizando ggplot2, só a base de dados economics

# Adicionando linhas, pontos e textos no gráfico
lines(economics$date, economics$psavert + 1, col = "red")
points(economics$date, economics$psavert - 1, col = "blue", cex = 0.3)
text(x = as.Date("2000-01-01"), y = 14, "texto")
legend("bottomleft", col=c("black", "red", "blue"), 
       legend = c("a", "b", "c"), lty = 1)

# Gráfico de barras
barplot(table(venda$bairro), col = "red")

# Boxplot
boxplot(preco ~ bairro, data = venda, col = "lightblue")

# Histograma
histograma <- with(limpos, hist(log(preco), col = "lightblue"))

# Densidade
densidade <- with(limpos, density(log(preco))) 
plot(densidade, col = "red")

plot(histograma, col = "lightblue", freq = FALSE) 
lines(densidade, col = "red", lwd = 2)
rug(log(limpos$preco))

qqnorm(venda$pm2) 
qqline(venda$pm2, col="red")

# Para plotar vários gráﬁcos ao mesmo tempo, 
# utilizar par(mfrow=c(n,m)) - preencher por linhas 
# ou par(mfcol=c(n,m)) - preencher por colunas

par(mfrow=c(2,2))
plot(1)
plot(1:10)
plot(densidade, col = "red")
curve(dnorm(x), -4, 4)

par(mfrow=c(1,1)) # voltando para um gráfico só

# ggplot2: Uma grmática de gráficos

# Instalando os pacotes (caso não os tenha instalados) 
install.packages(c("ggplot2", "ggthemes", "gridExtra"))

library(ggplot2) 
library(ggthemes) 
library(gridExtra)        

ggplot(data = venda, aes(x = m2, y = preco)) + geom_point() 

# Tipo de Gráﬁco 
# geom scatterplot (gráﬁco de dispersão) geom_point() 
# barchart (gráﬁco de barras) geom_bar() 
# boxplot geom_boxplot() 
# line chart (gráﬁco de linhas) geom_line() 
# histogram (histograma) geom_histogram() 
# density (densidade) geom_density() 
# smooth (aplica modelo estatístico) geom_smooth()

# Scatter plot 
ggplot(data = venda, aes(x = m2, y = preco)) + geom_point()
# Line plot 
ggplot(data = venda, aes(x = m2, y = preco)) + geom_line()
# Histogram 
ggplot(data = venda, aes(x = preco)) + geom_histogram()
# Density 
ggplot(data = venda, aes(x = preco)) + geom_density()
# Boxplot 
ggplot(data = venda, aes(x = bairro, y = preco)) + geom_boxplot()
# Smoother (lm, loess, gam) 
ggplot(data = venda, aes(x = m2, y = preco)) + geom_smooth(method = "lm")

# Podemos combinas os objetos geométricos
# pontos mais reta de regressão 
ggplot(data = venda, aes(x = m2, y = preco)) + 
  geom_point() + 
  geom_smooth(method = "lm")

# Trabalhando com mais de uma variável
ggplot(data = venda, aes(x = m2, 
                         y = preco, 
                         color = bairro, 
                         size = quartos)) + 
  geom_point() 

# muda o tamanho, a cor e a forma dos pontos 
# note que não há legenda, pois não estamos 
# mapeando os dados a atributos estéticos 
ggplot(data = venda, aes(x = m2, y = preco)) + 
  geom_point(color = "darkblue", shape = 21, size = 5)


# aes(color) compartilhado 
ggplot(venda, aes(m2, preco, color = bairro)) + 
  geom_point() + 
  geom_smooth(method = "lm")

# aes(color) apenas nos pontos 
ggplot(venda, aes(m2, preco)) + 
  geom_point(aes(color = bairro)) + 
  geom_smooth(method = "lm")

# Exemplo
ggplot(mpg, aes(displ, hwy)) + geom_point()

ggplot(mpg, aes(displ, hwy, col = factor(cyl))) + 
  geom_point() + 
  geom_smooth(method = "lm")

# Facetas
ggplot(venda, aes(m2, preco)) + 
  geom_point(aes(col = factor(quartos))) + 
  geom_smooth(method = "lm") + 
  facet_wrap(~bairro)


media <- mean(log(venda$preco)) 
dp <- sd(log(venda$preco)) 

ggplot(data = venda, aes(x = log(preco))) + 
  geom_histogram(aes(y = ..density..), binwidth = 0.3, 
                 fill = "lightblue", col = "black") + 
  geom_rug() + 
  stat_function(fun = dnorm, args = list(mean = media, sd = dp), 
                color = "red") + 
  xlab("Log do Preço") + 
  ylab("Densidade") + 
  ggtitle("Histograma Preços de Imóveis") + 
  theme_bw()

library(ggthemes) 
?ggthemes

ggplot(mpg, aes(displ, hwy, col = factor(cyl))) + 
  geom_point() + 
  geom_smooth(method = "lm", se = F) + 
  theme_tufte()

# Pode salvar o gráfico e depois apenas mudar o tema
grafico <- ggplot(mpg, aes(displ, hwy, col = factor(cyl))) + 
  geom_point() + 
  geom_smooth(method = "lm", se = F)

grafico + theme_excel() # Tema do excel

# Exercício
grafico2 <- ggplot(venda, aes(m2, preco)) +
  geom_point(aes(col = factor(quartos))) + 
  geom_smooth(method = "lm") + 
  facet_wrap(~bairro) 

grafico2 + theme_economist(stata = T)
grafico2 + theme_economist_white()
grafico2 + theme_wsj()
grafico2 + theme_wsj(color = "lightgrey")
grafico2 + theme_pander()
grafico2 +   
  xlab("Metro Quadrado") + 
  ylab("Preço") +
  theme_pander()

ggplot(venda, aes(m2, preco)) + 
  geom_point(shape = 5, aes(color = factor(quartos))) + 
  geom_smooth(method = "lm") + 
  facet_wrap(~bairro) + 
  ggtitle("Preços, quartos e M2 no Plano Piloto") + 
  scale_color_discrete("Número de quartos") + 
  theme_gdocs()
