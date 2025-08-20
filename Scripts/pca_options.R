# First, ensure required packages are installed
library(plotly)
library(FactoMineR)
library(tidyverse)
library(ggrepel)

# Modify PCA to include more dimensions in the visualization
PCA_vocs <- PCA(PCA_data, scale.unit = TRUE,
                ncp = 6, graph = F,
                quali.sup = c(1:3,31:48))

# Update to include third dimension
topvars <- PCA_vocs$var$contrib[,1:3] %>% as.data.frame() %>%
  rownames_to_column(var = "species") %>%
  mutate(contribution = Dim.1 + Dim.2 + Dim.3) %>%
  top_n(22, contribution)

# Update variable coordinates for 3D
PCAvar_coords <- PCA_vocs$var$coord[topvars$species,] %>%
  as.data.frame() %>%
  select(1:3) %>%  # Select first 3 dimensions
  rownames_to_column(var = "var") %>%
  left_join(class_key, by = "var") %>%
  mutate(var=str_replace_all(var, c("Neryl_Geranyl_acetone" = "Neryl/Geranyl Acetone",
                                    "E_2_nonal"="E-2-Nonanal",
                                    "P_cymene"="P-Cymene",
                                    "_"=" ")),
         group=str_replace_all(group, c("Acids"="Sugar/acid","Sugars"="Sugar/acid")))

# create a scale value to the size of the scatter plot to adjust variable coordinates
var <- facto_summarize(PCA_vocs, 
                       element = "var", 
                       result = c("coord", "contrib", "cos2"))

colnames(var)[2:3] <- c("x", "y")

ind <- data.frame(PCA_vocs$ind$coord[, drop = FALSE], 
                  stringsAsFactors = TRUE)

colnames(ind) <- c("x", "y")

r <- min((max(ind[, "x"]) - min(ind[, "x"])/(max(var[, "x"]) - min(var[, "x"]))), 
         (max(ind[, "y"]) - min(ind[, "y"])/(max(var[,"y"]) - min(var[, "y"]))))

# update the variable coordinates

PCAvar_plot_data <- PCAvar_coords %>% 
  as_tibble() %>% 
  mutate(across(starts_with("Dim"), ~r*0.6*.x)) # this number scales arrow length

# Get component variance for 3 dimensions
percentVar <- PCA_vocs$eig[1:3,2]

# get coordinates for individuals to map group means with meta data for aesthetics
PCAvoctable <- PCA_vocs$ind$coord %>% 
  as.data.frame() %>% 
  rownames_to_column("ID") %>% 
  left_join(genotype_table)

# create a table with the average coordinates for each phenotype
Mean_coords <- PCAvoctable %>% 
  group_by(label) %>% 
  summarise(across(where(is.numeric), ~mean(.x, na.rm = TRUE))) %>%
  left_join(genotype_table %>% distinct(label,Flesh, Genotype, Genotype2, assay))

# Create 3D plot using plotly
p <- plot_ly() %>%
  # Add points
  add_trace(data = Mean_coords,
            x = ~Dim.1, y = ~Dim.2, z = ~Dim.3,
            type = "scatter3d",
            mode = "markers",
            marker = list(size = 8,
                          color = ~as.factor(Flesh),
                          symbol = ~as.factor(assay)),
            text = ~Genotype2,
            hoverinfo = "text") %>%
  # Add arrows for variables
  add_trace(data = PCAvar_plot_data,
            x = ~c(0, Dim.1), y = ~c(0, Dim.2), z = ~c(0, Dim.3),
            type = "scatter3d",
            mode = "lines",
            line = list(color = ~group),
            showlegend = FALSE) %>%
  # Add labels for variables
  add_trace(data = PCAvar_plot_data,
            x = ~Dim.1, y = ~Dim.2, z = ~Dim.3,
            type = "scatter3d",
            mode = "text",
            text = ~var,
            textposition = "top center",
            showlegend = FALSE) %>%
  layout(
    scene = list(
      xaxis = list(title = sprintf("PC1 (%0.1f%%)", percentVar[1])),
      yaxis = list(title = sprintf("PC2 (%0.1f%%)", percentVar[2])),
      zaxis = list(title = sprintf("PC3 (%0.1f%%)", percentVar[3]))
    ),
    title = "3D PCA Plot of Papaya Genotypes"
  )

# Display the interactive 3D plot
p


# 4D visualization using PC4 as color intensity
percentVar <- PCA_vocs$eig[1:4,2]

p_4d <- plot_ly() %>%
  # Add points with PC4 as color intensity
  add_trace(data = Mean_coords,
            x = ~Dim.1, y = ~Dim.2, z = ~Dim.3,
            type = "scatter3d",
            mode = "markers",
            marker = list(
              size = 8,
              color = ~Dim.4,  # Use PC4 for color intensity
              colorscale = "Viridis",
              showscale = TRUE,
              colorbar = list(title = sprintf("PC4 (%0.1f%%)", percentVar[4]))
            ),
            text = ~Genotype2,
            hoverinfo = "text") %>%
  layout(
    scene = list(
      xaxis = list(title = sprintf("PC1 (%0.1f%%)", percentVar[1])),
      yaxis = list(title = sprintf("PC2 (%0.1f%%)", percentVar[2])),
      zaxis = list(title = sprintf("PC3 (%0.1f%%)", percentVar[3]))
    ),
    title = "4D PCA Plot of Papaya Genotypes"
  )

# Display the interactive 4D plot
p_4d


# Assuming PCA_vocs is already created as in your original code

# Load required packages
library(plotly)
library(FactoMineR)
library(tidyverse)

# Assuming PCA_vocs is your existing PCA object
# Extract the first 3 dimensions for variables and individuals

# Get the first 3 dimensions of variance
percentVar <- PCA_vocs$eig[1:3,2]

scale_factor <- 20 

# Prepare variable (arrows) coordinates for 3D
PCAvar_coords_3d <- PCA_vocs$var$coord[topvars$species,] %>%
  as.data.frame() %>%
  select(1:3) %>%  # Select first 3 dimensions
  rownames_to_column(var = "var") %>%
  left_join(class_key, by = "var") %>%
  mutate(
    # Scale the coordinates
    Dim.1 = Dim.1 * scale_factor,
    Dim.2 = Dim.2 * scale_factor,
    Dim.3 = Dim.3 * scale_factor,
    var = str_replace_all(var, c(
      "Neryl_Geranyl_acetone" = "Neryl/Geranyl Acetone",
      "E_2_nonal" = "E-2-Nonanal",
      "P_cymene" = "P-Cymene",
      "_" = " "
    )),
    group = str_replace_all(group, c(
      "Acids" = "Sugar/acid",
      "Sugars" = "Sugar/acid"
    ))
  )

# Create color maps for different attributes
attribute_colors <- c(
  "Aftertaste" = "#D55E00",
  "Aroma" = "#0072B2",
  "Flavour" = "#009E73",
  "Texture" = "#999999"
)

flesh_colors <- c(
  "Red" = "#E31A1C",
  "Yellow" = "gold2"
)

# Create arrow coordinates
arrow_coords <- do.call(rbind, lapply(1:nrow(PCAvar_coords_3d), function(i) {
  data.frame(
    x = c(0, PCAvar_coords_3d$Dim.1[i]),
    y = c(0, PCAvar_coords_3d$Dim.2[i]),
    z = c(0, PCAvar_coords_3d$Dim.3[i]),
    group = PCAvar_coords_3d$group[i],
    var = PCAvar_coords_3d$var[i],
    arrow_id = i
  )
}))

# Create the 3D plot
p <- plot_ly() %>%
  # Add points for genotypes
  add_trace(
    data = Mean_coords,
    x = ~Dim.1, y = ~Dim.2, z = ~Dim.3,
    type = "scatter3d",
    mode = "markers+text",
    marker = list(
      size = 8,  # Increased marker size
      color = ~factor(Flesh),
      colors = flesh_colors,
      symbol = ~factor(assay),
      symbols = c("circle", "square", "diamond"),
      line = list(color = "black", width = 1)
    ),
    text = ~Genotype2,
    textposition = "top center",
    name = ~Flesh,
    hoverinfo = "text"
  )

# Add arrows for variables
for(i in unique(arrow_coords$arrow_id)) {
  arrow_data <- arrow_coords[arrow_coords$arrow_id == i, ]
  p <- p %>% add_trace(
    x = arrow_data$x,
    y = arrow_data$y,
    z = arrow_data$z,
    type = "scatter3d",
    mode = "lines",
    line = list(
      color = attribute_colors[arrow_data$group[1]],
      width = 3
    ),
    name = arrow_data$group[1],
    showlegend = (i == 1),  # Show legend only once per group
    hoverinfo = "none"
  )
}

# Add text labels for variables with adjusted positions
p <- p %>% add_trace(
  data = PCAvar_coords_3d,
  x = ~Dim.1, y = ~Dim.2, z = ~Dim.3,
  type = "scatter3d",
  mode = "text",
  text = ~var,
  textfont = list(
    color = ~group,
    size = 12,
    family = "Times New Roman"
  ),
  textposition = "top center",
  showlegend = FALSE
)

# Layout configuration with adjusted axis ranges
max_range <- max(abs(c(
  Mean_coords$Dim.1, Mean_coords$Dim.2, Mean_coords$Dim.3,
  PCAvar_coords_3d$Dim.1, PCAvar_coords_3d$Dim.2, PCAvar_coords_3d$Dim.3
)))

p <- p %>% layout(
  scene = list(
    xaxis = list(
      title = sprintf("PC1 (%.1f%%)", percentVar[1]),
      range = c(-max_range, max_range),
      zeroline = TRUE,
      zerolinecolor = "gray",
      gridcolor = "lightgray"
    ),
    yaxis = list(
      title = sprintf("PC2 (%.1f%%)", percentVar[2]),
      range = c(-max_range, max_range),
      zeroline = TRUE,
      zerolinecolor = "gray",
      gridcolor = "lightgray"
    ),
    zaxis = list(
      title = sprintf("PC3 (%.1f%%)", percentVar[3]),
      range = c(-max_range, max_range),
      zeroline = TRUE,
      zerolinecolor = "gray",
      gridcolor = "lightgray"
    ),
    camera = list(
      eye = list(x = 1.5, y = 1.5, z = 1.5)
    ),
    aspectmode = "cube"  # Force equal scaling on all axes
  ),
  title = "3D PCA Biplot of Papaya Genotypes",
  legend = list(
    title = list(
      text = "<b>Legend</b>"
    ),
    tracegroupgap = 0
  )
)

# Display the plot
p

# Optional: Save as HTML for interactive viewing
# saveWidget(p, "3D_PCA_biplot.html")
