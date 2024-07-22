# Load necessary libraries
library(tidyverse)
library(ggplot2)
library(sf)
library(tmap)
library(leaflet)
library(farver)
library(XML)
library(gridExtra)
library(maps)

----------------------------------------------
# Load the dataset
new_cancer_data <- read.csv("C:/Users/ammar.jubril/Downloads/epid_data_with_continent.csv")

----------------------------------------------
# Data Exploration and Cleaning
summary(new_cancer_data)
str(new_cancer_data)

# Data Transformation
new_cancer_data <- new_cancer_data %>%
  mutate(Incidence_Rate = as.numeric(Incidence_Rate),
         Mortality_Rate = as.numeric(Mortality_Rate),
         Environmental_Factors = as.numeric(Environmental_Factors))

# Top 10 Countries based on Incidence Rate
top_10_countries <- new_cancer_data %>%
  group_by(Country) %>%
  summarize(Total_Incidence_Rate = sum(Incidence_Rate, na.rm = TRUE)) %>%
  top_n(10, Total_Incidence_Rate) %>%
  arrange(desc(Total_Incidence_Rate))

top_10_data <- new_cancer_data %>%
  filter(Country %in% top_10_countries$Country)

----------------------------------------------
# Create the plots
plot1 <- ggplot(new_cancer_data, aes(x = Continent, y = Incidence_Rate, fill = Cancer_Type)) +
  geom_bar(stat = "identity", position = "dodge") +
  theme_minimal() +
  labs(title = "Cancer Incidence Rates by Continent and Type",
       x = "Continent",
       y = "Incidence Rate per 100,000 population")

plot2 <- ggplot(top_10_countries, aes(x = reorder(Country, Total_Incidence_Rate), y = Total_Incidence_Rate, fill = Country)) +
  geom_bar(stat = "identity") +
  theme_minimal() +
  labs(title = "Top 10 Countries by Cancer Incidence Rate",
       x = "Country",
       y = "Total Incidence Rate per 100,000 population") +
  coord_flip()

# Arrange the plots
grid.arrange(plot1, plot2, nrow = 2)

# Scatter Plot with Regression Line (Overall)
scatter_plot_overall <- ggplot(new_cancer_data, aes(x = Environmental_Factors, y = Incidence_Rate, color = Cancer_Type)) +
  geom_point() +
  geom_smooth(method = "lm") +
  theme_minimal() +
  labs(title = "Incidence Rate vs Environmental Factors",
       x = "Environmental Factors (Composite Index)",
       y = "Incidence Rate per 100,000 population")

# Scatter Plot with Regression Line (By Continent)
scatter_plot_by_continent <- ggplot(new_cancer_data, aes(x = Environmental_Factors, y = Incidence_Rate, color = Continent)) +
  geom_point() +
  geom_smooth(method = "lm") +
  theme_minimal() +
  labs(title = "Incidence Rate vs Environmental Factors by Continent",
       x = "Environmental Factors (Composite Index)",
       y = "Incidence Rate per 100,000 population")

# Scatter Plot with Regression Line (Top 10 Countries)
scatter_plot_top_10 <- ggplot(top_10_data, aes(x = Environmental_Factors, y = Incidence_Rate, color = Country)) +
  geom_point() +
  geom_smooth(method = "lm") +
  theme_minimal() +
  labs(title = "Incidence Rate vs Environmental Factors for Top 10 Countries",
       x = "Environmental Factors (Composite Index)",
       y = "Incidence Rate per 100,000 population")

# Arrange the scatter plots
grid.arrange(scatter_plot_overall, scatter_plot_by_continent, scatter_plot_top_10, nrow = 2)

# Basic World Map
world <- st_as_sf(maps::map("world", plot = FALSE, fill = TRUE))
new_cancer_data_map <- world %>%
  left_join(new_cancer_data, by = c("ID" = "Country"))

tm_shape(new_cancer_data_map) +
  tm_polygons("Incidence_Rate", style = "quantile", palette = "Blues") +
  tm_facets(by = "Cancer_Type", ncol = 2) +
  tm_layout(title = "Global Cancer Incidence Rates")

# Set the tmap option to check and fix invalid polygons
tmap_options(check.and.fix = TRUE)

# Create Leaflet choropleth maps for each continent
continents <- unique(new_cancer_data$Continent)

for (continent in continents) {
  data_continent <- new_cancer_data %>% filter(Continent == continent)
  world_continent <- world %>%
    left_join(data_continent, by = c("ID" = "Country"))
  
  map <- tm_shape(world_continent) +
    tm_polygons("Incidence_Rate", style = "quantile", palette = "Blues") +
    tm_layout(title = paste("Cancer Incidence Rates in", continent))
  
  print(map)
}
