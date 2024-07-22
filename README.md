# Cancer Incidence Data Visualization

This project involves the visualization of cancer incidence data across different countries and continents. The visualizations include bar plots, scatter plots with regression lines, and choropleth maps to provide a comprehensive understanding of cancer incidence rates globally.

## Table of Contents

- [Introduction](#introduction)
- [Data](#data)
- [Visualizations](#visualizations)
- [Requirements](#requirements)
- [Usage](#usage)
- [Contributing](#contributing)
- [License](#license)

## Introduction

This project aims to visualize cancer incidence data by:
- Generating bar plots of cancer incidence rates by continent and cancer type.
- Creating scatter plots with regression lines to show the relationship between environmental factors and cancer incidence rates.
- Producing choropleth maps to display the geographic distribution of cancer incidence rates globally and by continent.

## Data

The dataset used in this project is `epid_data_with_continent.csv`, which contains cancer incidence data along with corresponding continents.

## Visualizations

### Bar Plots

1. **Cancer Incidence Rates by Continent and Type**
   ![Bar Plot](images/bar_plot_continent_type.png)

2. **Top 10 Countries by Cancer Incidence Rate**
   ![Bar Plot](images/bar_plot_top_10_countries.png)

### Scatter Plots with Regression Lines

1. **Overall Scatter Plot**
   ![Scatter Plot](images/scatter_plot_overall.png)

2. **Scatter Plot by Continent**
   ![Scatter Plot](images/scatter_plot_by_continent.png)

3. **Scatter Plot for Top 10 Countries**
   ![Scatter Plot](images/scatter_plot_top_10_countries.png)

### Choropleth Maps

1. **Global Cancer Incidence Rates**
   ![World Map](images/world_map_global.png)

2. **Cancer Incidence Rates by Continent**
   ![World Map](images/world_map_continent.png)

## Requirements

- R
- R libraries:
  - `tidyverse`
  - `ggplot2`
  - `sf`
  - `tmap`
  - `leaflet`
  - `farver`
  - `XML`
  - `gridExtra`
  - `maps`

## Usage

1. Clone the repository:
   ```bash
   git clone https://github.com/your-username/cancer-incidence-visualization.git
   cd cancer-incidence-visualization
