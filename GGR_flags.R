
GGR_flags<-function(){
  
  
  ### Prepare countries data frame
  capitals<-read.csv("Data/Capitals_table.csv") %>% subset(., Flags=="Yes") # Remove the countries we don't want in the flags game (e.g., St Martin has the French flag so when it appears it expects you to answer St Martin while you think it's France)
  capitals$name<-as.factor(capitals$name)

  ### Prepare the question
  RAND<-sample(x=(1:nlevels(capitals$name)), size=1) %>% as.numeric()
  Country_Sel<-levels(capitals$name)[RAND]
  
  # Plot
  plot(
    ggplot(data=data.frame(X=1, Y=1, CO=capitals$iso2[capitals$name==Country_Sel]))+
      geom_flag(aes(x=X, y=Y, country=as.character(CO)), size=100)+
      theme_void()
  )
  
  # Ask
  Question<-paste0("Which country has this flag?      Your answer:")
  
  
  ### Collect the answer
  answer_given<-readline(Question)
  answer_correct<-Country_Sel %>% as.character()
  
  
  ### Clean answers to be more comparable
  answer_given_CLEANED<-GGR_clean_names(answer_given)
  answer_correct_CLEANED<-GGR_clean_names(answer_correct)
  
  
  ### Provide answers
  if(answer_given_CLEANED == answer_correct_CLEANED){
    cat(paste0("Congratulations, the answer was indeed ", answer_correct)) ; Correct="Yes"
  } else {
    cat(paste0("Too bad, the answer was ", answer_correct))  ; Correct="No"
  } 
  
  
  ### Store answer in the results file
  GGR_Store_results(GAME="Flags",
                    QUESTION=answer_correct[1],
                    ANSWER=answer_given,
                    CORRECT=Correct)
  
}  


