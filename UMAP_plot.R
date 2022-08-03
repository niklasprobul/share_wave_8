## UMAP-Plot following the introduction from:
## https://datavizpyr.com/how-to-make-umap-plot-in-r/

library(tidyverse)
library(palmerpenguins)
library(umap)
theme_set(theme_bw(18))

umap_data <- all_data %>%
  drop_na() %>%
  select(-year) %>%
  mutate(mergeid=row_number())

umap_data <- umap_data %>%
  select(mergeid, country, GGIR_mean_ENMO_total, age, female)

# creating a list with the layout variable
# that contains two umap components 
set.seed(142)
umap_fit <- umap_data %>%
  select(where(is.numeric)) %>%
  column_to_rownames("mergeid") %>%
  scale() %>%
  umap()

# extract the components and save it in a dataframe
# merge UMAP components with meta data associated (umap_data)
umap_df <- umap_fit$layout %>%
  as.data.frame()%>%
  rename(UMAP1="V1",
        UMAP2="V2") %>%
  mutate(mergeid=row_number())%>%
  inner_join(umap_data, by="mergeid")

umap_df %>% head()

# UMAP plot: Scatter plot between 2 UMAP components
umap_df %>%
  ggplot(aes(x = UMAP1,
             y = UMAP2,
             color = GGIR_mean_ENMO_total,
             shape = factor(female))) +
  geom_point()+
  labs(x="UMAP1",
       y="UMAP2",
       subtitle = "UMAP plot")
ggsave("UMAP_plot_GGIR_sex.png")

# UMAP plot: adding facetting based on country variable
umap_df %>%
  ggplot(aes(x = UMAP1,
             y = UMAP2,
             color = GGIR_mean_ENMO_total)) +
  geom_point(size=3, alpha=0.5) +
  facet_wrap(~country) +
  labs(x="UMAP1",
       y="UMAP2",
       subtitle = "UMAP plot")+
  theme(legend.position = "bottom")
ggsave("UMAP_plot_GGIR_country.png")

## CountyID:
# 12: Germany, 13: Sweden, 15: Spain, 16: Italy, 17: France
# 18: Denmark, 23: Belgium, 28: Czech Republic, 29: Poland, 34: Slovenia
## http://www.share-project.org/fileadmin/pdf_documentation/SHARE_release_guide_8-0-0.pdf
