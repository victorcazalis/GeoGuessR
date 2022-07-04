

GGR_capitals<-function(){

  
### Prepare capital data frame
capitals<-as.data.frame(countryref) %>% subset(., is.na(.$capital)==F, select=c("name", "capital")) %>% distinct(., capital, .keep_all=T) 

### Prepare the question
RAND<-sample(x=(1:nrow(capitals)), size=1) %>% as.numeric()

Question<-paste0("What is the capital of ", capitals$name[RAND], "?      Your answer:")


### Collect the answer
answer_given<-readline(Question)
answer_correct<-capitals$capital[RAND] %>% as.character()


### Clean answers to be more comparable
answer_given_CLEANED<-GGR_clean_names(answer_given)
answer_correct_CLEANED<-GGR_clean_names(answer_correct)


### Provide answers
if(answer_given_CLEANED == answer_correct_CLEANED){
  cat(paste0("Congratulations, the answer was indeed ", answer_correct, "\n")) ; Correct="Yes"
} else {
  cat(paste0("Too bad, the answer was ", answer_correct, "\n"))  ; Correct="No"
} 


### Store answer in the results file
GGR_Store_results(GAME="Capitals",
                  QUESTION=capitals$name[RAND],
                  ANSWER=answer_given,
                  CORRECT=Correct)

}




