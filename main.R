library(jsonlite)
library(tm)
library(SnowballC)
library(wordcloud)
require(RColorBrewer)

json_data <- jsonlite::stream_in(file('data.json'))

ff <- function(str) {
  strsplit(str,split=' ')
}
russian_stop_words <- scan('russian_stop_words.txt', character(), '\n')
# d <- tolower(unlist(lapply(json_data[3][1], ff)[[1]]))
d <- json_data[3][1]
corpus <- VCorpus(VectorSource(d))

corpus <- tm_map(corpus, removePunctuation)
corpus <- tm_map(corpus, content_transformer(tolower))
#corpus <- tm_map(corpus, stemDocument, language = "russian")
corpus <- tm_map(corpus, removeWords, stopwords("russian"))
corpus <- tm_map(corpus, removeWords, russian_stop_words)
pal2 <- brewer.pal(8,"Dark2")
wordcloud(corpus,max.words = 100, random.order = FALSE,colors=pal2)
