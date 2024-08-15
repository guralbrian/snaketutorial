# Load necessary library
library(dplyr)

# Specify the directory containing the result files
result_dir <- "data/sim_results"

# List all CSV files in the directory
result_files <- list.files(path = result_dir, pattern = "*.csv", full.names = TRUE)

# Initialize an empty data frame to store all results
all_results <- data.frame()

# Loop through each file and read it into the data frame
for (file in result_files) {
  # Read the CSV file
  result <- read.csv(file)
  
  # Extract parameters from the file name
  file_info <- strsplit(basename(file), "_")[[1]]
  n <- as.numeric(file_info[3])
  mean_diff <- as.numeric(file_info[4])
  sd <- as.numeric(gsub(".csv", "", file_info[5]))
  
  # Add parameters as new columns to the data frame
  result <- mutate(result, sample_size = n, mean_diff = mean_diff, sd = sd)
  
  # Append the results to the main data frame
  all_results <- bind_rows(all_results, result)
}

# Write the combined results to a single CSV file
output_file <- "combined_t_test_results.csv"
file_path <- file.path("data/sim_results", output_file)
write.csv(all_results, file = file_path, row.names = FALSE)
