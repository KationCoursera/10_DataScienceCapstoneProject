en_US.blogs <- readLines("F:/documents/dev/R/10_DataScienceCapstoneProject/data/en_US/en_US.blogs.txt")
en_US.twitter <- readLines("F:/documents/dev/R/10_DataScienceCapstoneProject/data/en_US/en_US.twitter.txt")
en_US.news <- readLines("F:/documents/dev/R/10_DataScienceCapstoneProject/data/en_US/en_US.news.txt")

length(en_US.news)

# Take a sample of 20% of each

sample_size <- 0.05

en_US.blogs.sample <- sample(en_US.blogs,size=length(en_US.blogs)*sample_size,replace=FALSE)
en_US.twitter.sample <- sample(en_US.twitter,size=length(en_US.twitter)*sample_size,replace=FALSE)
en_US.news.sample <- sample(en_US.news,size=length(en_US.news)*sample_size,replace=FALSE)

length(en_US.news.sample)
length(en_US.twitter.sample)
length(en_US.blogs.sample)

writeLines(en_US.news.sample,"F:/documents/dev/R/10_DataScienceCapstoneProject/data/en_US/samples/en_US.news.sample.txt")
writeLines(en_US.twitter.sample,"F:/documents/dev/R/10_DataScienceCapstoneProject/data/en_US/samples/en_US.twitter.sample.txt")
writeLines(en_US.blogs.sample,"F:/documents/dev/R/10_DataScienceCapstoneProject/data/en_US/samples/en_US.blogs.sample.txt")

# Create corpus from sampled data

corpus <- Corpus(DirSource("F:/documents/dev/R/10_DataScienceCapstoneProject/data/en_US/samples"), readerControl = list(language="english"))

# Remove stuff

corpus <- tm_map(corpus,removeNumbers)
corpus <- tm_map(corpus,removePunctuation)
corpus <- tm_map(corpus,stripWhitespace)
corpus <- tm_map(corpus,tolower)
corpus <- tm_map(corpus,removeWords,stopwords("english"))
corpus <- tm_map(corpus,PlainTextDocument)

# Get document term matrix from the corpus
dtm <- DocumentTermMatrix(corpus)

# Calculate frequency of words by summing columns
word_freq <- colSums(as.matrix(dtm))

# Histogram of frequency of words
qplot(word_freq, geom="histogram", binwidth=1.5) + xlim(0,50) + xlab("Words - news") + ylab("Word frequency")

