
GGR_countries_shape<-function(Size_Min){
  
  
  ### Prepare countries data frame
  countries<-read_sf("Data/Admin_dissolved_by_country_Simplif_0.005.shp")
  countries<-subset(countries, countries$AREA_M2>Size_Min*1000000) # Remove the small countries (not visible on the map)
  
  ### Prepare the question
  RAND<-sample(x=(1:nrow(countries)), size=1) %>% as.numeric()
  
  # Plot
  plot(
    ggplot(countries[RAND,])+
      geom_sf(fill="gray70")+
      theme_void()
  )
  
  # Ask
  Question<-paste0("Which country has this shape?      Your answer:")
  
  
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
  GGR_Store_results(GAME="Countries shape",
                    QUESTION=answer_correct,
                    ANSWER=answer_given,
                    CORRECT=Correct)
  
}  


