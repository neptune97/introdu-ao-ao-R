# CURSO - ANALISE DE DADOS EM R -------------------------------------------
# AULA 04 -----------------------------------------------------------------
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


# bancos ------------------------------------------------------------------

setwd("~/intro_R_MQ/")
library (tidyverse)

ask <- read_csv("Ask A Manager Salary Survey 2021 (Responses) - Form Responses 1.csv")
pkm <- read.csv("https://raw.githubusercontent.com/neptune97/introdu-ao-ao-R/main/Aula%2001/pokemon.csv?token=GHSAT0AAAAAABZ5DYDTQ26VVNKW3J6T5NUWY2MV2SA")



# EDA ---------------------------------------------------------------------

# install.packages ("gtsummary")
# install.packages ("skimr")
# install.packages ("frequency")

library(skimr)
library(gtsummary)
library (frequency)


# skimr -------------------------------------------------------------------
pkm %>% 
  select (generation, 
          is_legendary, attack,
          defense) %>% 
  skim()


# gt_summary --------------------------------------------------------------

pkm %>% 
  select (generation, 
          is_legendary, attack,
          defense) %>% 
  tbl_summary()
  

# freq --------------------------------------------------------------------

freq(ask)



# summarytools ------------------------------------------------------------

# install.packages("summarytools")
# library(summarytools)

freq(pkm)



# test-t ------------------------------------------------------------------

t <- pkm %>%
  filter (type1 == "fairy" | type1 == "dragon") %>% 
  select (type1, height_m) %>% 
  mutate (type1 = factor(type1)) %>% 
  slice_sample(n = 30)
  
t.test(height_m ~ type1, data = t)




# x² ----------------------------------------------------------------------

x <- ask %>% 
  select(`How old are you?`,
         `What country do you work in?`) %>% 
  rename (idade = `How old are you?`,
          pais = `What country do you work in?`) %>% 
  filter (pais == "Canada" | pais == "USA") %>% 
  mutate (
    idade = if_else(idade == "25-34" | idade == "35-44", "Sim", "Não"),
  )




a <- chisq.test(x$idade, x$pais, correct=TRUE)


a$expected # para checar valores esperados
a$observed # para checar valores observados




# ANOVA -------------------------------------------------------------------

pkm %>% 
  filter (type1 == "normal" | type1 == "psychic" | type1 == "dragon") %>%
  mutate (type1 = factor(type1)) %>% 
  select (type1, attack, defense) %>% 
  ggplot(aes (x = type1, y = attack)) +
  geom_boxplot()
  

anova <- aov (attack ~ type1, data = a) #comando da ANOVA

summary (anova) #ver os resultados

TukeyHSD(anova) #Post-Hoc



# matriz de correlação ----------------------------------------------------

stats <- pkm %>% 
  select(attack, sp_attack, sp_defense, 
         hp, defense, base_happiness)


x <- cor(stats)


#install.packages("corrplot")
library (corrplot)

corrplot(x)


# Regressão ---------------------------------------------------------------
# linear simples ----------------------------------------------------------

reg <- lm (base_happiness ~ is_legendary, 
           data = pkm)

summary (reg)






# linear múltipla ---------------------------------------------------------

reg2 <- lm (base_happiness ~ is_legendary + height_m + attack,
            data = pkm)



summary (reg2)




# logística ---------------------------------------------------------------


reg3 <- glm (is_legendary ~ height_m + attack + base_happiness,
             family = binomial,
             data = pkm)


summary (reg3)


# Fatorial ----------------------------------------------------------------


# install.packages("psych")
# library (psych)

bfi 

bfi <- bfi %>% 
  drop_na()

data <- cor(bfi)

fa <- fa(r = data, nfactors = 6)


