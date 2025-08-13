library(digest)
library(gmp)
library(bloomR)

num_items <- 5000
num_probes <- 100000
false_positive_rate <- 0.01
bf <- bloom_create(n = num_items, p = false_positive_rate)

# print bits and hash function numbers
cat("m = ", bf$m, "\n")
cat("Number of hash functions = ", bf$k, "\n")

for (i in 1:num_items) bf <- bloom_add(bf, paste0("k_", i))

cat("fill_ratio after adding ", num_items, "items initially is : ", round(bloom_fill_ratio(bf), 3), "\n")
cat("The theoretical expected fill rate is ", round(expected_bloom_fill_rate(bf), 3), "\n")

# probe 10k unseen keys <- membership check as usual
probes <- paste0("p_", 1:num_probes)
hits <- sum(vapply(probes, function(p) bloom_check(bf, p), logical(1))) # is there a collision on all hashes 
fp <- hits/length(probes)

cat("fill ratio =", round(bloom_fill_ratio(bf), 3),
    "  empirical false positive rate =", round(fp, 4), "\n")