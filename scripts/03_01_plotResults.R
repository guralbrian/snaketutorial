# Load necessary libraries
library(ggplot2)
library(dplyr)
library(tidyr)

# Load the combined results
results <- read.csv("data/sim_results/combined_t_test_results.csv")

# Create output directory for plots if it doesn't exist
output_dir <- "plots"
if (!dir.exists(output_dir)) {
  dir.create(output_dir)
}

# Plot 1: Distribution of p-values
p1 <- ggplot(results, aes(x = p_value)) +
  geom_histogram(binwidth = 0.05, fill = "steelblue", color = "black") +
  theme_minimal() +
  labs(title = "Distribution of p-values",
       x = "p-value",
       y = "Frequency")

ggsave(filename = file.path(output_dir, "p_value_distribution.png"), plot = p1)

# Plot 2: Distribution of test statistics
p2 <- ggplot(results, aes(x = statistic)) +
  geom_histogram(binwidth = 0.5, fill = "darkorange", color = "black") +
  theme_minimal() +
  labs(title = "Distribution of Test Statistics",
       x = "Test Statistic",
       y = "Frequency")

ggsave(filename = file.path(output_dir, "test_statistic_distribution.png"), plot = p2)

# Plot 3: Heatmap of p-values by group size and mean difference
p3 <- results %>%
  ggplot(aes(x = factor(sample_size), y = factor(mean_diff), fill = p_value)) +
  geom_tile() +
  scale_fill_gradient(low = "blue", high = "red") +
  theme_minimal() +
  labs(title = "Heatmap of p-values",
       x = "Sample Size",
       y = "Mean Difference",
       fill = "p-value")

ggsave(filename = file.path(output_dir, "p_value_heatmap.png"), plot = p3)

# Plot 4: Boxplot of p-values by standard deviation
p4 <- ggplot(results, aes(x = factor(sd), y = p_value)) +
  geom_boxplot(fill = "lightgreen", color = "black") +
  theme_minimal() +
  labs(title = "Boxplot of p-values by Standard Deviation",
       x = "Standard Deviation",
       y = "p-value")

ggsave(filename = file.path(output_dir, "p_value_by_sd_boxplot.png"), plot = p4)

# Plot 5: Scatter plot of Test Statistic vs. Mean Difference
p5 <- ggplot(results, aes(x = mean_diff, y = statistic)) +
  geom_point(color = "purple") +
  theme_minimal() +
  labs(title = "Test Statistic vs. Mean Difference",
       x = "Mean Difference",
       y = "Test Statistic")

ggsave(filename = file.path(output_dir, "test_statistic_vs_mean_diff.png"), plot = p5)

# Print completion message
cat("All plots have been generated and saved in the 'plots' directory.\n")
