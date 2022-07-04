
GGR_plot_results<-function(){
  
  ### Charge data
  res<-read.csv("Your_GeoGuessR_results.csv")
  res$Game<-factor(res$Game, c("Flags", "Capitals", "Countries localisation", "Countries shape"))
  
  
  ### Attribute regions
  countries<-read_sf("Countries_map/Countries_simplified_GeoGuessR.shp")
  # For localisation and shape
  res$Region<-countries$FIRST_NA3_[match(res$Question, countries$FIRST_NA2_)]
  cat(as.numeric(table(is.na(res$Region))["TRUE"]), "/", nrow(res), " results were not categorised in a region")
  
  
  ### Plot proportion of good answer per game
  res_table<-as.data.frame(prop.table(table(res$Correct, res$Game),2)) %>% subset(., .$Var1=="Yes")
  res_table$Y<-as.data.frame(table(res$Game))$Freq
    
  G1<-ggplot()+
    geom_bar(data=res, aes(x=Game, fill=Correct), stat="count")+
    scale_fill_manual(values=c("#de77ae", "#4d9221"))+
    geom_text(data=res_table, x=1:4, aes(y=(Y+0.03*max(Y)), label=paste0(round(Freq*100), "%")))+#, position=position_dodge(width=0.9), vjust=-0.5, size=3)+
    ylab("Number of answers")+
    ggtitle("Your overall results")
  
  
  ### Plot proportion of good answer per region
  G2<-ggplot(res[is.na(res$Region)==F,])+
    geom_bar(aes(x=Game, fill=Correct), stat="count")+
    scale_fill_manual(values=c("#de77ae", "#4d9221"))+
    facet_wrap(~ Region)+ 
    ggtitle("Your results per region")+
    ylab("Number of answers")+
    theme(axis.text.x = element_text(angle = 90, hjust = 1)) 
  
  
  ### Plot trend in good answers per game
  res$day<-julian(as.Date(res$Date))
  res$day<-res$day-min(res$day, na.rm=T)+1 # To get the difference since the first day
  
  res_temp<-ddply(res, .(Game, day), function(x){Prop=nrow(x[x$Correct=="Yes",]) / nrow(x)})
  
  G3<-ggplot(res_temp)+
    geom_line(aes(x=day, y=V1, col=Game))+
    geom_point(aes(x=day, y=V1, col=Game))+
    ylab("Proportion of correct answers")+
    xlab("Time since your first game (days)")+
    ggtitle("Change in score over time, per game")+
    ylim(c(0,1))
  
  
  ### Plot trend in good answers per region
  res_temp_region<-ddply(res[is.na(res$Region)==F,], .(Region, day), function(x){Prop=nrow(x[x$Correct=="Yes",]) / nrow(x)})
  
  G4<-ggplot(res_temp_region)+
    geom_line(aes(x=day, y=V1, col=Region))+
    geom_point(aes(x=day, y=V1, col=Region))+
    ylab("Proportion of correct answers")+
    xlab("Time since your first game (days)")+
    ggtitle("Change in score over time, per region")+
    ylim(c(0,1))
  
  
  
  ### Arrange
  plot(grid.arrange(G1, G2, G3, G4, nrow=2))
  
  
}



