### LISTA 2 ###
# 
# Em mat, calcule as somas e as m?dias, por linhas e por columas, utilizando apply e compare o resultado
# com as fun??es rowSums, colSums, rowMeans e colMeans. Extra: em mat, calcule a m?dia m?vel com
# janela de 5 observacoes, por linha e por coluna, utilizando a fun??o rollapply do pacote zoo 
# (nao vimos essa funcao em aula, olhe a ajuda em ?rollapply).

set.seed(321)
mat <- matrix(rchisq(100, df = 2), ncol = 10)
df <- data.frame(grupo = rep(c("a","b"), 5),
                 col1 = rbinom(10, 1, 0.5),
                 col2 = rcauchy(10))
lista <- lapply(1:10, function(x) matrix(rnorm(100), ncol = 10))

rowSums(mat)
apply(mat, 1, sum)

apply(mat, 1, mean)
rowMeans(mat)

colSums(mat)
apply(mat, 1, sum)

colMeans(mat)
apply(mat, 1, sum)

install.packages("zoo")
library("zoo")
?rollapply

