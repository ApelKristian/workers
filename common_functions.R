#functions needed for common worker tasks

#choose a user agent for the worker (only called rarely)
configure_global_user_agent <- function() {
  
  #read in list of user agents
  all_agents <- read_csv2("~/Documents/common/data/user_agents.csv")
  
  #select user agent if one hasn't been set yet
  if(!(list.files("~/Documents/common/data") %>% str_detect("selected_agent") %>% any())) {
    
    selected_agent <- sample(all_agents, 1)
    saveRDS(selected_agent, "~/Documents/common/data/selected_agent")
  }
}

