require(jsonlite)

# Get the file into R and simplify it to a data frame

filename <- stream_in(file("yelp_academic_dataset_checkin.json"))
data_flat <- flatten(filename)
saveRDS(data_flat, "data.rds")