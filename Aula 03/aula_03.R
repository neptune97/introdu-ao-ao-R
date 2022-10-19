# CURSO - ANALISE DE DADOS EM R -------------------------------------------
# AULA 03 -----------------------------------------------------------------
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


# Início ------------------------------------------------------------------

library (tidyverse)

setwd("~/intro_R_MQ/")

ask <- read_csv("Ask A Manager Salary Survey 2021 (Responses) - Form Responses 1.csv")
pkm <- read.csv("https://raw.githubusercontent.com/neptune97/introdu-ao-ao-R/main/Aula%2001/pokemon.csv?token=GHSAT0AAAAAABZ5DYDTQ26VVNKW3J6T5NUWY2MV2SA")




# VERBOS II ---------------------------------------------------------------


# pivot -------------------------------------------------------------


a <- pkm %>% 
  select(generation, type1, attack) %>% 
  group_by(generation, type1) %>% 
  summarise(mean = mean(attack)) %>% 
  na_if (" ") %>% 
  drop_na() %>% 
  pivot_wider(names_from = type1, 
              values_from = mean) # pivot_wider torna seu banco mais horizontal


a <- a %>% 
  pivot_longer(!generation, names_to = "tipo", values_to = "attack")

#pivot_longer deixa seu banco mais vertical



# SUA VEZ - Identifique o problema do banco abaixo e conserte --------

us_rent_income





# spread ------------------------------------------------------------------

a <- pkm %>% 
  select(generation, type1, attack) %>% 
  group_by(generation, type1) %>% 
  summarise(mean = mean(attack)) %>% 
  drop_na() %>% 
  spread(type1, mean) #spread torna seu banco horizontal








# gather ------------------------------------------------------------------

a <- a %>% 
  gather(type, ataque, 2:19) #gather faz o mesmo que pivot_longer






# SUA VEZ - Use Spread ou Gather no banco de dados abaixo -----------------

us_rent_income






# slice -------------------------------------------------------------------

pkm %>% 
  select(type1, height_m) %>% 
  group_by(type1) %>% 
  slice_max(height_m, n = 5) #slice_max ordena o número de itens pedidos por ordem decrescente

pkm %>% 
  select(type1, height_m) %>% 
  group_by(type1) %>% 
  slice_min(height_m, n = 5) #slice_min ordena o número de itens pedidos por ordem crescente


pkm %>% 
  slice_sample(n = 2) #slice_sample seleciona samples aleatórios




# SUA VEZ - Faça o que se pede abaixo -------------------------------------

## selecione um sample aleatório de 10 itens no banco ask e após encontre
## os 5 maiores salários e suas profissões






# ungroup -----------------------------------------------------------------


pkm %>% 
  select(generation, base_egg_steps) %>% 
  group_by(generation) %>% 
  mutate(m = mean(base_egg_steps)) %>%
  ungroup() %>%  
  mutate(x = mean(base_egg_steps)) #ungroup afeta o nível de agrupamento do dado





# unique/distinct ---------------------------------------------------------

df <- data.frame(row = rep(c(1, 51), each = 3),
                 var = rep(c("azul", "verde"), each = 3))


df %>% 
  unique() #exclui linhas repetidas

df %>% 
  distinct() #exclui linhas repetidas





# join --------------------------------------------------------------------

bd_a <- ask %>% 
  select(`Job title`, `What is your annual salary? (You'll indicate the currency in a later question. If you are part-time or hourly, please enter an annualized equivalent -- what you would earn if you worked the job 40 hours a week, 52 weeks a year.)`) %>% 
  rename (renda = `What is your annual salary? (You'll indicate the currency in a later question. If you are part-time or hourly, please enter an annualized equivalent -- what you would earn if you worked the job 40 hours a week, 52 weeks a year.)`) %>% 
  slice_sample(n = 20)


bd_b <- ask %>% 
  select(`Job title`, `What is your annual salary? (You'll indicate the currency in a later question. If you are part-time or hourly, please enter an annualized equivalent -- what you would earn if you worked the job 40 hours a week, 52 weeks a year.)`) %>% 
  rename (renda = `What is your annual salary? (You'll indicate the currency in a later question. If you are part-time or hourly, please enter an annualized equivalent -- what you would earn if you worked the job 40 hours a week, 52 weeks a year.)`) %>% 
  slice_sample(n = 20)


bd_a %>% 
  inner_join(bd_b) #inclue as linhas presentes em ambos os bancos

bd_a %>% 
  left_join(bd_b) # da preferência ao banco secundário

bd_a %>% 
  right_join(bd_b) # da preferência ao banco primário


bd_a %>% 
  full_join(bd_b) #une um banco ao outro



# SUA VEZ - Crie bancos aleatórios e una-os usando full_join --------------






# GGPLOT2 -----------------------------------------------------------------
# barras ------------------------------------------------------------------


## barras convencionais
pkm %>% 
  group_by(type1) %>% 
  summarise(mean = mean(base_egg_steps)) %>% 
  ggplot(aes(x = type1, y = mean)) +
  geom_bar(stat = "identity")


## barras ajustadas
pkm %>% 
  group_by(type1) %>% 
  summarise(mean = mean(base_egg_steps)) %>% 
  ggplot(aes(x = reorder(type1, -mean), y = mean)) +
  geom_bar(stat = "identity") +
  labs (
    x = "Tipo",
    y = "Número de Passos (Média)",
    title = "Número de Passos para Eclodir um Ovo de Pokemon por Tipo",
    tag = "#1",
    caption= "Fonte: Serebi, 2022"
  ) +
  coord_flip() +
  theme_light()



## barras agrupadas
pkm %>% 
  group_by(type1) %>% 
  count(is_legendary) %>% 
  ggplot(aes(x = type1, y = n,
             fill = is_legendary)) +
  geom_bar(stat = "identity", position = "fill")


## barras agrupadas

pkm %>% 
  group_by(type1, generation) %>% 
  mutate (generation = factor (generation)) %>% 
  summarise(mean = mean(attack)) %>%
  ggplot(aes(x = reorder(type1, -mean), 
             y = mean, 
             fill = generation)) +
  geom_bar(stat = "identity", 
           position = "fill")





# pontos + linhas ---------------------------------------------------------

## gráfico comum
pkm %>% 
  group_by(is_legendary, type1) %>% 
  summarise(mean = mean(attack)) %>% 
  ggplot(aes(x = type1, y = mean,
             group = is_legendary,
             colour = is_legendary)) +
  geom_point()



## gráfico melhorado
pkm %>% 
  mutate (is_legendary = factor (is_legendary)) %>% 
  group_by(is_legendary, type1) %>% 
  summarise(mean = mean(attack)) %>% 
  ggplot(aes(x = type1, y = mean,
             group = is_legendary,
             colour = is_legendary)) +
  geom_point(aes(size = mean)) +
  geom_line() +
  labs (
    x = "Tipo",
    y = "Ataque (Média)",
    title = "Pokemons Lendários tem mais ataque?",
    caption = "Serebi, 2022",
    tag = "#2",
    colour = "Lendário?"
  ) +
  scale_colour_manual(values = c("#D2B48C", "#900D09")) +
  theme_minimal()






# jitter ------------------------------------------------------------------

ask %>% 
  rename (renda = `What is your annual salary? (You'll indicate the currency in a later question. If you are part-time or hourly, please enter an annualized equivalent -- what you would earn if you worked the job 40 hours a week, 52 weeks a year.)`) %>% 
  group_by(`How old are you?`, renda) %>% 
  count () %>% 
  ggplot(aes(x = `How old are you?`,
             y = n,
             group = renda)) +
  geom_jitter()




# boxplot -----------------------------------------------------------------

ask %>% 
  filter(`What country do you work in?` == "Brazil" |
         `What country do you work in?` == "USA") %>% 
  rename (renda = `What is your annual salary? (You'll indicate the currency in a later question. If you are part-time or hourly, please enter an annualized equivalent -- what you would earn if you worked the job 40 hours a week, 52 weeks a year.)`,
          pais = `What country do you work in?`) %>% 
  group_by(pais) %>% 
  summarise(median = median(renda)) %>% 
  ggplot(aes(x = pais, y = median)) +
  geom_boxplot()










