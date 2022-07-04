
GGR_flags<-function(){
  
  
  ### Prepare countries data frame
  countries<-as.data.frame(countryref) %>% subset(., is.na(.$capital)==F, select=c("name", "iso2")) %>%  distinct(., name, .keep_all=T) 
  countries$iso2<-tolower(countries$iso2)
  
  ### Prepare the question
  RAND<-sample(x=(1:nrow(countries)), size=1) %>% as.numeric()
  
  # Plot
  plot(
    ggplot(data=data.frame(X=1, Y=1, CO=countries$iso2[RAND]))+
      geom_flag(aes(x=X, y=Y, country=as.character(CO)), size=100)+
      theme_void()
  )
  
  # Ask
  Question<-paste0("Which country has this flag?      Your answer:")
  
  
  ### Collect the answer
  answer_given<-readline(Question)
  answer_correct<-countries$name[RAND] %>% as.character()
  
  
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
  GGR_Store_results(GAME="Flags",
                    QUESTION=answer_correct,
                    ANSWER=answer_given,
                    CORRECT=Correct)
  
}  


