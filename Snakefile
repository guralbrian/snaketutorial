GROUP_SIZE = list(range(5, 10, 1))
MEAN_DIFF = list(range(10, 100, 10))
ST_DEV = list(range(10, 20, 10))

# Rule to generate all output files
rule all:
    input:
        "plots/p_value_distribution.png",
        "plots/test_statistic_distribution.png",
        "plots/p_value_heatmap.png",
        "plots/p_value_by_sd_boxplot.png",
        "plots/test_statistic_vs_mean_diff.png"

# Rule to generate individual t-test result files
rule run_t_test:
    output:
        "data/sim_results/t_test_results_{group_size}_{mean_diff}_{st_dev}.csv"
    shell:
        """
        Rscript scripts/01_01_run_t_test.R {wildcards.group_size} {wildcards.mean_diff} {wildcards.st_dev}
        """

# Rule to merge the individual results into a single CSV
rule merge_t_tests:
    input:
        expand("data/sim_results/t_test_results_{group_size}_{mean_diff}_{st_dev}.csv", 
            group_size=GROUP_SIZE, 
            mean_diff=MEAN_DIFF, 
            st_dev=ST_DEV)
    output:
        "data/sim_results/combined_t_test_results.csv"
    shell:
        """
        Rscript scripts/02_01_merge_t_tests.R
        """
rule plot_results:
    input:
        "data/sim_results/combined_t_test_results.csv"
    output:
        "plots/p_value_distribution.png",
        "plots/test_statistic_distribution.png",
        "plots/p_value_heatmap.png",
        "plots/p_value_by_sd_boxplot.png",
        "plots/test_statistic_vs_mean_diff.png"
    shell:
        """
        Rscript scripts/03_01_plotResults.R
        """