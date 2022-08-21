

GGR_countries_localisation<-function(){
  
  
  ### Prepare countries data frame
  countries<-read_sf("Data/Countries_simplified_GeoGuessR.shp")
  countries$AREA_M2<-st_area(countries) %>% as.numeric()
  countries<-subset(countries, countries$AREA_M2>10^10) # Remove the small countries (not visible on the map)
  
  ### Prepare the question
  RAND<-sample(x=(1:nrow(countries)), size=1) %>% as.numeric()
  
  # Plot
  plot(
    ggplot(countries)+
      geom_sf(aes(fill= FIRST_NA2_==FIRST_NA2_[RAND]), col=NA, show.legend=F)+
      scale_fill_manual(values=c("#f6e8c3", "#01665e"))+
      theme_void()
  )
  
  # Ask
  Question<-paste0("What is this country?      Your answer:")
  
  
  ### Collect the answer
  answer_given<-readline(Question)
  answer_correct<-countries$FIRST_NA2_[RAND] %>% as.character()
  
  
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
  GGR_Store_results(GAME="Countries localisation",
                    QUESTION=answer_correct,
                    ANSWER=answer_given,
                    CORRECT=Correct)
  
}  


