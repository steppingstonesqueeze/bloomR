library(digest)
library(gmp)

hashing_algo = "xxhash64"
hex_start <- "0x"

# Create Bloom filter
bloom_create <- function(n, p) {
  m <- ceiling(-(n * log(p)) / (log(2)^2))   # bits
  k <- ceiling((m / n) * log(2))             # number of hash functions
  list(bits = rep(FALSE, m), m = m, k = k, n = n, p = p)
}

#fill ratio of the bloom filter
bloom_fill_ratio <- function(bf) mean(bf$bits)

# expected theoretical fill rate for the bloom filter
expected_bloom_fill_rate <- function(bf) {
  unset <- (1.0 - 1.0 / bf$m)
  unset_powered <- unset**(bf$n*bf$k)
  return (1.0 - unset_powered)
}

# Add element
bloom_add <- function(bloom, item) {
  for (i in 1:bloom$k) {
    s1 <- substr(digest(item, algo = hashing_algo, seed = i), 1, 8)
    # add in the "0x" marker for hex
    s1 <- paste0(hex_start, s1)
    
    # use bigz
    idx1 <- as.numeric(as.bigz(s1))
    
    #find hash index
    idx <- idx1 %% bloom$m + 1
    
    # set the bit to TRUE
    bloom$bits[idx] <- TRUE
  }
  bloom
}

# Check element
bloom_check <- function(bloom, item) {
  all(sapply(1:bloom$k, function(i) {
    s1 <- substr(digest(item, algo = hashing_algo, seed = i), 1, 8)
    
    # add in the "0x" marker for hex
    s1 <- paste0(hex_start, s1)
    
    # use bigz
    idx1 <- as.numeric(as.bigz(s1))
    
    #find hash index
    idx <- idx1 %% bloom$m + 1
    
    bloom$bits[idx]
  }))
}
