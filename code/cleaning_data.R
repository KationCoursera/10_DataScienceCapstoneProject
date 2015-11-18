require(caret)
require(lubridate)
setwd("~/Dev/R/DataScienceSpecialization/10_DataScienceCapstoneProject")

# When answering the question "Are reviews better during christmas time?" we don't need all the data

# Load the three files I will need:
# - reviews is my main file
# - business and users are files for references and some additional info about reviews and reviewers
#

reviews <- readRDS("data/review_file.RDS")
business <- readRDS("data/business_file.RDS")
users <- readRDS("data/user_file.RDS")

# For review file we need columns stars, date, user_id, business_id and text field

reviews_clean <- reviews[,c(2,4,5,6,8)]

# For business file we need business_id, review_count, name, stars, categories

business_clean <- business[,c(1,7,8,12,5)]

# For user file we need user_id, review_count and average stars

user_clean <- users[,c(4,2,7)]

# Prepare data for building a model
# Main points:
# - it is non-sensical to take into account businesses that have too few reviews
# - we will split the data first into two groups -> christmas time (december) and nonchristmas time (everything else)
# - each group needs enough reviews for each business -> at least 5 in the christmas group and at least 30 in the nonchristmas group
# - a total of 35 reviews are needed (without groups -> 10k businesses -> 1,1mio reviews)

reviews_clean.date <- reviews_clean
reviews_clean.date$date <- ymd(reviews_clean.date$date)

#business_enough_reviews <- business_clean[business_clean$review_count > 30, ]

#review_enough_reviews <- reviews_clean[reviews_clean$business_id %in% business_enough_reviews$business_id,]
#review_enough_reviews.date <- review_enough_reviews
#review_enough_reviews.date$date <- ymd(review_enough_reviews$date)

saveRDS(reviews_clean,"data/review_clean.rds")
saveRDS(business_clean,"data/business_clean.rds")
saveRDS(user_clean,"data/user_clean.rds")