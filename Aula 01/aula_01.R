# CURSO - ANALISE DE DADOS EM R -------------------------------------------
# AULA 01 -----------------------------------------------------------------
# PROF: FERNANDO DE SOUZA, Me ---------------------------------------------


# LEMBRETES ---------------------------------------------------------------

# 1. Para criar um script crie na folha com o sinal de mais, ou digite 
# CTLR+SHIFT+N

# 2. Para rodar um comando use CTRL + ENTER ou selecione as linhas e
# clique em "Run"

# 3. Sempre use # para escrever comentários em seus scripts.

# 4. Tente ao máximo deixar comentários nas suas ações, seu eu do futuro
# ficará imensamente feliz

# 5. Sempre use um script, programar apenas no Console fará com que seus 
# dados se percam


# Primeiros passos --------------------------------------------------------
# Cálculos ----------------------------------------------------------------

1 + 1 # somar
1 - 1 # diminuir
1 * 1 # multiplicar 
1/1   # dividir
1^1 # potência


1 + 1 * 2 # operações complexas
5^2 / 5



# SUA VEZ - Quanto é (2 * 2)² + (4/8) -------------------------------------








# Vectors ------------------------------------------------------------------

a <- 2  #se insere valores usando uma seta apontada para a variável
b <- 4

a + b  # é possível realizar operações com vetores
a * b

a <- "azul" #vetores podem conter palavras
A <- "azul" # cuidado com o nome das suas variáveis

a <- c("azul", "verde", "laranja") #vetores podem conter mais de um item com o comando c()
b <- c(1, 2, 3, 4, 5)
c <- c("roxo", a) # é possível acrescentar elementos a vetores

b[3]  #é possível achar elementos dentro de vetores usando []



# Ache o 15 elemento do vetor abaixo --------------------------------------

set.seed(1)       # este comando controla a aleatorização de itens
v <- sample(1:100) # este comando gera números aleatórios
x <- rnorm(1:100) # este comando gera números aleatórios dentro da escala Z












# Classes e Estruturas ----------------------------------------------------

a <- 1    #vetores núméricos pertencem a classe "numeric"
b <- c("um", "dois", "três") # vetores de texto pertencem a classe "character"
a <- TRUE #vetores lógicos pertencem a classe "logical"
a <- factor(b) #dados categóricos pertencem a classe "factors"
a <- NA #missing data é chamada de NA e possue uma classe própria
a <- list (12, "laranja", 470) #um vetor pode ser agregado em nívels por meio de listas

class() #o comando class() revela a classe de um objeto
as.nomedaclasse ()#transforma as classes no R
str() #ajuda a entender a estrutura do objeto


# SUA VEZ - Qual a classe do objeto abaixo? -------------------------------

objeto <- c(12, "laranja", 470)




# Lógica ------------------------------------------------------------------

a <- "a"
b <- "A"

a == b  #igualdade
a > b   # maior que
a < b   # menor que
a >= b  # maior igual
a <= b  # menor igual
a != b  # desigualdade




# SUA VEZ - Teste se "A" é igual a "a" ------------------------------------









# Funções e Comandos ------------------------------------------------------

c () # concatenar
sqrt()  # raiz quadrada
mean () #média
median () #mediana
sum() # somatório
length() # número de objetos em um vetor
summary() # resumos
class () #classe de objetos
ls() #lista todos os objetos atuais do ambiente de trabalho
rm () # apaga objetos do ambiente do trabalho
setwd() #muda a localização de onde o R procura arquivos
rm(list = ls()) #apaga TODOS os objtos do ambiente de trabalho
library () # abre pacotes
install.packages() #instala pacotes
q() #fecha o R



# Sua vez - Ache a mediana do vetor abaixo --------------------------------

x <- sample (20:60)





# BANCO DE DADOS ----------------------------------------------------------
# do 0 --------------------------------------------------------------------

a <- c("banana", "manga", "uva", "bergamota", "amora")
b <- c(1.00, 2.50, 3.20, 2.40, 4.69)

c <- cbind(a, b) #concatenar verticalmente
c <- rbind (a, b) # concatenar horizontalmente
c <- matrix(a, b) # cria uma matriz de vetores



# data frames -------------------------------------------------------------

c <- data.frame(a, b) #é possível construir df a partir de vetores antigos

bd <- data.frame(n = sample(1:50, 20), 
                 nome = letters[1:20]) #é possível usar vetores dentro da função




# funções para DF ---------------------------------------------------------

head () #primeiras 6 linhas
tail () #últimas 6 linhas
nrow () #número de linhas
ncol () #núnero de colunas
names () #nomes das colunas
colnames() #nome das colunas alternativo
subset() #ajuda a seccionar o banco em parte

colnames()[] <- "" #trocar o nome de uma coluna




# SUA VEZ - Troque o nome da primeira coluna do "bd" ----------------------









# Importando Bancos de Dados ----------------------------------------------

library (readr) #para planilhas em .csv, .txt, .tsv 
library (readxl) #para planilhas em .xls e .xlsx
library (haven) #para formatos mais específicos como .sas e .sav

setwd("~/intro_R_MQ/")

bd <- read_csv("https://raw.githubusercontent.com/neptune97/introdu-ao-ao-R/main/Aula%2001/Ask%20A%20Manager%20Salary%20Survey%202021%20(Responses)%20-%20Form%20Responses%201.csv?token=GHSAT0AAAAAABZ5DYDTVEOXM35TJ4I4OQ2YY2MVZAA")
db <- read.csv("https://raw.githubusercontent.com/neptune97/introdu-ao-ao-R/main/Aula%2001/pokemon.csv?token=GHSAT0AAAAAABZ5DYDTQ26VVNKW3J6T5NUWY2MV2SA")



# SUA VEZ - Instale os pacotes usados na seção anterior no seu PC ---------







