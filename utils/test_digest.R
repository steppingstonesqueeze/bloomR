library(digest)
library(gmp)

item <- "Saanu is so cute"
item <- "s"
hashing_algo = "murmur32"
hashing_algo = "xxhash64"
hex_start <- "0x"

hashed_item <- digest(item,
                      algo = hashing_algo,
                      seed = 1)

# try substrings
substr1 <- substr(hashed_item, 1, 3)
substr2 <- substr(hashed_item, 1, 5)
substr3 <- substr(hashed_item, 1, 8)

# add in the 0x for hex
substr1 <- paste0(hex_start, substr1)
substr2 <- paste0(hex_start, substr2)
substr3 <- paste0(hex_start, substr3)

# use bigz
integ_substr1 <- as.numeric(as.bigz(substr1))
integ_substr2 <- as.numeric(as.bigz(substr2))
integ_substr3 <- as.numeric(as.bigz(substr3))

# as.integer-ise them
#integ_substr1 <- as.numeric(strtoi(substr1, base = 16L, signed = FALSE))
#integ_substr2 <- as.numeric(strtoi(substr2, base = 16L, signed = FALSE))
#integ_substr3 <- as.numeric(strtoi(substr3, base = 16L, signed = FALSE))

cat("original item is :", item, "\n")
cat("hashed item using ", hashing_algo, " : ", hashed_item, "\n")

cat("Substring 1-3 is ", substr1,  "and integerised is ", integ_substr1, "\n")
cat("Substring 1-5 is ", substr2,  "and integerised is ", integ_substr2, "\n")
cat("Substring 1-8 is ", substr3,  "and integerised is ", integ_substr3, "\n")


