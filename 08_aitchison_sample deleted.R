library(qiime2R)
library(phyloseq)
library(vegan)
library(compositions)
library(ggplot2)
library(ape)

## 1. Load phyloseq object and prepare data
# load rarefied phyloseq object
load("./phyloseq_obj_rq2.Rdata")

set.seed(111) # keep result reproductive

# Extract and transpose OTU table
otu_table_rq2 <- phyloseq::otu_table(physeq_obj_rq2)
if (!phyloseq::taxa_are_rows(physeq_obj_rq2)) otu_table_rq2 <- t(otu_table_rq2)

# Remove empty samples and convert to compositional
otu_table_rq2 <- otu_table_rq2[, colSums(otu_table_rq2) > 0]
otu_comp_rq2 <- compositions::clo(otu_table_rq2)

## 2. Compute Aitchison distance
aitchison_dist <- compositions::dist(compositions::acomp(t(otu_comp_rq2)))

## 3. Perform PCoA with full dimensions
pcoa_result <- ape::pcoa(aitchison_dist, correction = "none")

## 4. Determine optimal number of dimensions (k)
# Scree plot of eigenvalues
eigenvalues <- pcoa_result$values$Eigenvalues
rel_eigenvalues <- pcoa_result$values$Relative_eig * 100

# Create scree plot data
scree_data <- data.frame(
  PC = 1:length(eigenvalues),
  Eigenvalue = eigenvalues,
  Relative = rel_eigenvalues
)

# Plot scree plot
ggplot(scree_data, aes(x = PC, y = Relative)) +
  geom_point(size = 3, color = "steelblue") +
  geom_line(color = "steelblue") +
  labs(title = "Scree Plot for Dimension Selection",
       x = "Principal Coordinate",
       y = "Percentage of Variance Explained") +
  theme_minimal() +
  geom_hline(yintercept = 5, linetype = "dashed", color = "red") # Typical cutoff

# Automated elbow detection (optional)
find_elbow <- function(x) {
  first <- diff(x[1:2])
  second <- diff(x[2:3])
  scale <- abs(first - second)
  which(diff(x) <= scale)[1]
}

optimal_k <- find_elbow(scree_data$Relative)
cat("Suggested optimal dimensions (k):", optimal_k, "\n")

## 5. Calculate stress (goodness-of-fit)
# Reconstruct distances from PCoA coordinates
pcoa_coords <- pcoa_result$vectors[, 1:optimal_k]
reconstructed_dist <- dist(pcoa_coords)  # Euclidean distances in PCoA space

# Calculate stress (Kruskal's stress formula)
stress <- sqrt(sum((aitchison_dist - reconstructed_dist)^2) / sum(aitchison_dist^2)) * 100
cat("Stress value (%):", round(stress, 2), "\n")

## 6. Final PCoA plot with selected dimensions
plot_data <- data.frame(
  Sample = rownames(pcoa_result$vectors),
  PCo1 = pcoa_result$vectors[,1],
  PCo2 = pcoa_result$vectors[,2]
)

# Add metadata if available
if (!is.null(phyloseq::sample_data(physeq_obj_rq2))) {
  meta <- data.frame(phyloseq::sample_data(physeq_obj_rq2))
  plot_data <- cbind(plot_data, meta)
}

ggplot2::ggplot(plot_data, aes(x = PCo1, y = PCo2)) +
  geom_point(size = 3, alpha = 0.7) +
  labs(
    x = paste0("PCo1 (", round(rel_eigenvalues[1], 2), "%)"),
    y = paste0("PCo2 (", round(rel_eigenvalues[2], 2), "%)"),
    title = paste("Aitchison PCoA | Stress =", round(stress, 2), "%"),
    subtitle = paste("Using", optimal_k, "dimensions")
  ) +
  theme_minimal() +
  stat_ellipse(level = 0.8, linetype = 2, color = "gray50") # Optional ellipses

## 7. Shepard plot to visualize fit
shepard_data <- data.frame(
  Original = as.vector(aitchison_dist),
  Reconstructed = as.vector(reconstructed_dist)
)

ggplot(shepard_data, aes(x = Original, y = Reconstructed)) +
  geom_point(alpha = 0.3) +
  geom_abline(slope = 1, intercept = 0, color = "red") +
  labs(title = "Shepard Plot: Original vs Reconstructed Distances",
       subtitle = paste("Stress =", round(stress, 2), "%")) +
  theme_minimal()

