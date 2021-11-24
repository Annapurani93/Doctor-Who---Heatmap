library(tidyverse)
library(tidytuesdayR)
tuesdata <- tidytuesdayR::tt_load('2021-11-23')
tuesdata$writers->writers
tuesdata$directors->directors
tuesdata$episodes->episodes
tuesdata$imdb->imdb

glimpse(imdb)

imdb%>%
  select(season,ep_num,rating,rating_n)%>%
  group_by(season,ep_num)%>%
  arrange(rating, rating_n,.by_group = TRUE)%>%
  data.frame()->data


ggplot(data,aes(x=as.factor(season),y=as.factor(ep_num),fill=rating,size=rating_n))+
  geom_point(aes(fill=rating),pch=21,colour="gray75")+
  scale_fill_distiller(palette="RdYlGn",limits=c(3,10),direction=1)+
  scale_size_continuous(limits=c(2000,20000))+
  labs(fill="Rating: ",size="Number of Ratings: ")+
  theme(plot.margin=unit(c(0.5,1.5,0.5,1.5),"cm"),
        plot.background = element_rect(fill="black"),
        panel.background = element_rect(fill="black"),
        panel.grid = element_line(colour="gray10"),
        axis.text = element_text(colour="white",size=10,face="bold"),
        axis.title.x = element_text(colour="white",size=10, face="bold",margin=margin(t=15)),
        axis.title.y = element_text(colour="white",size=10, face="bold",margin=margin(r=15)),
        legend.background = element_rect(fill="black"),
        legend.key = element_rect(fill="black"),
        legend.text=element_text(colour="white",margin=margin(l=15),face="bold"),
        legend.key.height = unit(1,"cm"),
        legend.box = "vertical",
        legend.title = element_text(colour="white",face="bold",size=12,margin=margin(b=15)),
        legend.position = "right",
        plot.title.position = "plot",
        plot.caption.position = "plot",
        panel.border = element_rect(fill=NA,colour = "gray50"),
        plot.title=element_text(size=14, face="bold",colour="white",margin=margin(b=15)),
        plot.subtitle = element_text(size=12, colour="white",margin=margin(b=25)),
        plot.caption=element_text(size=10,colour="white",hjust=0,margin=margin(t=20)))+
  labs(title="DOCTOR WHO: THE HIGHEST- AND LOWEST-RATED EPISODES OF THE SHOW",
       subtitle=str_wrap("Episode 10 of Season 3 where Sally Sparrow receives a cryptic message from the Doctor about a mysterious new enemy species that is after the TARDIS, is the highest-rated episode of the show with an IMDB rating of 9.8. On the other hand, Episode 3 of Season 12 where Graham accidentally teleports himself, the Doctor, Yasmin and Ryan to a luxury resort for rest and they end up discovering deadly secrets, is the lowest-rated, with an IMDB rating of 3.9",100),
       caption = "Data via Tidy Tuesday| Analysis and design: @annapurani93")+
  xlab("-------------SEASONS---------------")+
  ylab("-------------EPISODES--------------")->plot

ggsave("doctorwhoheatmap.png",plot,width=11,height=7)
ggsave("doctorwhoheatmap.pdf",plot,width=11,height=7)
