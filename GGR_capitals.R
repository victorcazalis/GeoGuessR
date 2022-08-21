

GGR_capitals<-function(){

  
### Prepare capital data frame
capitals<-read.csv("Data/Capitals_table.csv")
capitals$name<-as.factor(capitals$name)

### Prepare the question
RAND<-sample(x=(1:nrow(capitals)), size=1) %>% as.numeric()
Country_Sel<-levels(capitals$name)[RAND]

Question<-paste0("What is the capital of ", Country_Sel, "?      Your answer:")


### Collect the answer
answer_given<-readline(Question)
answer_correct<-capitals$capital[capitals$name==Country_Sel] %>% as.character()


### Clean answers to be more comparable
answer_given_CLEANED<-GGR_clean_names(answer_given)
answer_correct_CLEANED<-GGR_clean_names(answer_correct)


### Provide answers
if(answer_given_CLEANED %in% answer_correct_CLEANED){
  cat(paste0("Congratulations, the answer was indeed ", paste(answer_correct, collapse=" or "), "\n")) ; Correct="Yes"
} else {
  cat(paste0("Too bad, the answer was ", paste(answer_correct, collapse=" or "), "\n"))  ; Correct="No"
} 


### Store answer in the results file
GGR_Store_results(GAME="Capitals",
                  QUESTION=capitals$name[RAND],
                  ANSWER=answer_given,
                  CORRECT=Correct)

}




