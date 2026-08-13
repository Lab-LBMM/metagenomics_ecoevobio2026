#Carrega os pacotes
library(readxl)
library(dplyr)
library(tidyr)
library(ggplot2)
library(stringr)
library(ggthemes)

#Definir caminho e o diretório de trabalho
path <- "//wsl.localhost/Ubuntu/home/freitas/GenomaA/GR"
setwd(path)

#Importar os arquivos
checkM2 <- read_excel("quality_report.xlsx")
map <- read_excel("file_map.xlsx")

#Definindo as categorias de qualidade
Qualidade <- checkM2 %>% mutate(VAMB = str_extract(Name, "^S\\d+")) %>%
  mutate(Completeness_General = as.double(Completeness_General), Contamination = as.double(Contamination)) %>% 
  mutate(Qualidade = ifelse((Completeness_General >= 90.0 & Contamination <= 5.0), "1.Alta",
                            ifelse((Completeness_General >= 50.0 & Contamination <= 10.0), "2.Média", "3.Baixa")))

#Agrupa os arquivos pela coluna VAMB
Qualidade <- Qualidade %>% full_join(., map, by = "VAMB")

#Conta o número de MAGs baseado nas amostras
Qualidade_cont <- Qualidade %>% group_by(Amostra, Espécie, Qualidade) %>% summarise('Número de MAGs'=n())


# Cores com acessibilidade para daltônicos
scale_fill_colorblind7 = function(.ColorList = 2L:8L, ...){
  scale_fill_discrete(..., type = colorblind_pal()(8)[.ColorList])
}

Grafico <- Qualidade_cont %>% ggplot(aes(x = Amostra, y = `Número de MAGs`, fill = Qualidade)) +
  facet_grid(~ Espécie, scales = "free_x", switch = "x") +
  geom_bar(stat = "identity") + theme_bw(base_size = 15) +
  theme(
    strip.background = element_blank(), # Remove a caixa cinza ao redor dos nomes das espécies
    strip.placement = "outside",        # Coloca os nomes das espécies do lado de fora do eixo X
    strip.text.x = element_text(face = "italic", size = 12), # Coloca as espécies em itálico e ajusta o tamanho
    panel.grid = element_blank(),       # Remove as linhas de grade (quadriculado) do fundo
    panel.spacing = unit(0, "lines"), 
    axis.title.x = element_blank()
  ) +
  scale_fill_colorblind7(.ColorList = c(1,7,3))

print(Grafico)
ggsave("qualidade_MAGs.png", plot = Grafico, width = 14, height = 8)
