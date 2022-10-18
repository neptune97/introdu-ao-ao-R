# CURSO - ANALISE DE DADOS EM R -------------------------------------------
# AULA 02 -----------------------------------------------------------------
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



# Instalações -------------------------------------------------------------

#install.packages("tidyverse")
library (tidyverse)

setwd("caminho da pasta que vc baixou")

# Bancos de Dados --------------------------------------------------------

pkm <- read_delim("pokemon.csv") 
ask <- read_delim("Ask A Manager Salary Survey 2021 (Responses) - Form Responses 1.csv")




# SUA VEZ - Ache os erros de pelo menos um dos bancos de dados ------------








# filter ------------------------------------------------------------------


pkm <- pkm %>% 
  filter(type1 == "grass")  # filtra os casos presentes no banco de dados




pkm <- pkm %>% 
  filter (type1 != "grass") #filtra os casos opostos



pkm <- pkm %>% 
  filter (type1 == "grass" & type2 == "ice") # filtra casos de União (&)



pkm <- pkm %>% 
  filter (name == "Bulbasaur" | name == "Chikorita") # filtra casos por OU




# SUA VEZ - Filtre no banco ASK apenas os casos aonde o salário e em USD  -










# select ------------------------------------------------------------------

pkm <- pkm %>% 
  select(attack, name) #seleciona colunas por nome



pkm <- pkm %>% 
  select(5, 9) #seleciona colunas por número


pkm <- pkm %>% 
  select(-abilities) #exclue colunas





# SUA VEZ - Selecione a coluna de idade no banco de dados ASK -------------













# mutate ------------------------------------------------------------------

## if_else opera mudanças a níveis binários
ask <- ask %>% 
  mutate(cor_bin = if_else(`What is your race? (Choose all that apply.)` == "White", 1, 0))
  


## case_when opera mudanças a níveis categóricos
ask <- ask %>% 
  mutate (educ = case_when(
    `What is your highest level of education completed?` == "College degree" ~ "Graduação",
    `What is your highest level of education completed?` == "High School" ~ "Ensino Médio",
    `What is your highest level of education completed?` == "Master's degree" ~ "Mestrado",
    `What is your highest level of education completed?` == "PhD" ~ "Doutorado",
    `What is your highest level of education completed?` == "Professional degree (MD, JD, etc.)" ~ "MBA",
    `What is your highest level of education completed?` == "Some college" ~ "Superior Incompleto"
  ))



## é possível alterar tipos dentro de um mutate
ask <- ask %>% 
  mutate (educ = factor(educ, levels = c("Ensino Médio",
                                         "Superior Incompleto",
                                         "Graduação",
                                         "Mestrado",
                                         "Doutorado",
                                         "MBA")))





# SUA VEZ - Crie uma nova coluna com as indicações abaixo -----------------


## Crie uma nova coluna no banco ASK que indique quantas pessoas trabalham no Brasil,
## (dica: esta informação está em `What country do you work in?`)



# group_by ----------------------------------------------------------------


ask <- ask %>% 
  group_by(`How old are you?`, `What is your gender?`) # permite agrupar dados




pkm <- pkm %>% 
  group_by(generation, capture_rate, type1) #é possível agrupar quantos dados quiser








# count -------------------------------------------------------------------

ask %>% 
  count (educ) #gera frequências básicas




pkm %>% 
  group_by(generation, is_legendary) %>% 
  count () #gera frequências cruzadas






# SUA VEZ - Quantos pokemons de gelo existem no banco de dados? -----------
# (dica: vc precisará usar as colunas type1 e type 2 para achar o número certo)












# summarise ---------------------------------------------------------------

## cria estatísticas sumarizadas do dado
ask %>% 
  summarise(mean = mean(`What is your annual salary? (You'll indicate the currency in a later question. If you are part-time or hourly, please enter an annualized equivalent -- what you would earn if you worked the job 40 hours a week, 52 weeks a year.)`),
            median = median (`What is your annual salary? (You'll indicate the currency in a later question. If you are part-time or hourly, please enter an annualized equivalent -- what you would earn if you worked the job 40 hours a week, 52 weeks a year.)`))



## pode ser unida a outros verbos
pkm %>% 
  filter(type1 == "dark") %>% 
  summarise(mean = mean (height_m))



## uma contagem de elementos é feita por meio do elemento (n = n())






# SUA VEZ - Qual a altura média dos pokemons de cada geração --------------
# (dica: vc precisará das colunas generation e height_m)









# cálculo de porcentagens -------------------------------------------------


pkm %>% 
  filter(type1 == "dark") %>% 
  group_by(type2) %>% 
  summarise(n = n()) %>% 
  mutate (p = n/sum(n)*100)








# SUA VEZ - Calcue a porcentagem de pokemons do tipo Fada na 7 ger --------
# (dica: vc precisará das colunas generation, type1, type2)





# separate ----------------------------------------------------------------



a <- pkm %>% 
  separate(abilities, into = c("H1", "H2", "H3"), sep = ",") 

#separa elementos 







# rename ------------------------------------------------------------------

ask <- ask %>% 
  rename(idade = `How old are you?`,
         sexo = `What is your gender?`,
         moeda = `Please indicate the currency`,
         renda = `What is your annual salary? (You'll indicate the currency in a later question. If you are part-time or hourly, please enter an annualized equivalent -- what you would earn if you worked the job 40 hours a week, 52 weeks a year.)`)






# SUA VEZ - Renomeie uma das colunas do banco ASK -------------------------









