

GGR_RandomGame<-function(GAMES, MinSize_Loc, MinSize_Shape){ # vector with games to play, default: c("flags", "capitals", "countries_shape", "countries_localisation")
  
  game_to_play<-sample(GAMES, size=1)
  
  cat(paste0("You are going to play: ", game_to_play, "\n"))
  
  if(game_to_play=="flags"){GGR_flags()}
  if(game_to_play=="capitals"){GGR_capitals()}
  if(game_to_play=="countries"){GGR_countries()}
  if(game_to_play=="countries_shape"){GGR_countries_shape(Size_Min=MinSize_Shape)}
  if(game_to_play=="countries_localisation"){GGR_countries_localisation(Size_Min=MinSize_Loc)}
  
}


