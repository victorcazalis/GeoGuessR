
#################################
### Function to store results ###
#################################

GGR_Store_results<-function(GAME, QUESTION, ANSWER, CORRECT){
  `%not in%` <- function (x, table) is.na(match(x, table, nomatch=NA_integer_)) 
  
  ### Charge (or create) the results data frame
  if(!"Your_GeoGuessR_results.csv" %in% list.files(folder_results)){
    results<-data.frame(Game=NA, Date=NA, Question=NA, Answer=NA, Correct=NA)
  } else {
    results<-read.csv(paste0(folder_results, "/Your_GeoGuessR_results.csv"))
  }
  
  ### Add the results from this game
  results[nrow(results)+1,]<-c(GAME, as.character(Sys.Date()), QUESTION, ANSWER, CORRECT)

  ### Save the file
  write.csv(results[is.na(results$Game)==F,], paste0(folder_results, "/Your_GeoGuessR_results.csv"), row.names=F)
  
}





##################################################
### Function to clean answers from accents etc ###
##################################################

GGR_clean_names<-function(x){
  x %>% 
    tolower() %>% # Remove capital letters
    stri_trans_general(str=., id="Latin-ASCII") %>% # Remove accents and weird letters
    gsub(" ", "-", .) # Remove spaces
}









