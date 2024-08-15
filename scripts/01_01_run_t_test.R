# This script is a simple R script that generates two groups of normally distributed data -
# performs a two-sample t-test, and writes the results to a CSV file.

# Capture command-line arguments
args <- commandArgs(trailingOnly = TRUE)

# Assign arguments to variables
n <- as.numeric(args[1])         # Sample size per group
mean_diff <- as.numeric(args[2])  # Difference in means between groups
sd <- as.numeric(args[3])         # Standard deviation of the groups

# Generate data
group1 <- rnorm(n, mean = 0, sd = sd)
group2 <- rnorm(n, mean = mean_diff, sd = sd)

# Perform t-test
test_result <- t.test(x = group1, y = group2)

# Output results
result <- data.frame(
  statistic = test_result$statistic,
  p_value = test_result$p.value,
  parameter = test_result$parameter
)

# Name the output file and write the results to a CSV file

# Create directories if they don't exist
if (!file.exists("data")) {
    dir.create("data")
}
if (!file.exists("data/sim_results")) {
    dir.create("data/sim_results", recursive = TRUE)
}

output_file <- paste("t_test_results_", n, "_", mean_diff, "_", sd, ".csv", sep = "")
file_path <- file.path("data/sim_results", output_file)
write.csv(result, file = file_path, row.names = FALSE)
