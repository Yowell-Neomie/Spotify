#### Lecture des data
spotify_data <- read.csv("data/spotify-2023.csv",
                         stringsAsFactors = FALSE,
                         check.names = FALSE, quote = "\"",
                         header=TRUE,
                         encoding= "UTF-8") %>% 

#### A faire 

# renommer la colonne artist(s)_name en artist_name 
  rename(artist_name = `artist(s)_name`) %>% 
    mutate(streams=as.numeric(as.character(streams)))




# convertir les valeurs de la colonne streams en nombres.
  
#### Traitement des artistes

# Nettoyage des guillemets : suppression des crochets de la colonne artist_name), 
# probablement pour nettoyer les données.

# Séparation des artistes : Les noms des artistes sont séparés s'ils sont listés ensemble dans une même chaîne de caractères.
spotify_data$id_artists<-strsplit(spotify_data$artist_name,",")
spotify_data<-tidyr::unnest(spotify_data, id_artists)
spotify_data$artist_name<-trimws(spotify_data$id_artists, which="both")
# Nettoyage supplémentaire et formatage : Suppression des espaces superflus dans les noms des artistes.



# Filtrage des artistes :  ne garder que les artistes ayant plus de 5 chansons.
spotify_data<-spotify_data %>% 
  group_by(artist_name) %>%
  mutate(nombre = n() ) %>%
  filter(nombre > 4 ) %>% 
 ungroup()


#### Définition genre de musique 


# https://www.kine-formations.com/wp-content/uploads/2020/04/Liste-des-BPM-par-style-musical-Annexe-t%C3%A9l%C3%A9chargeable-%C3%A0-la-fin.pdf

get_genre_by_bpm<-function(bpm){
case_when(
      bpm == 80 ~ "Crunk",
      bpm >= 60 & bpm <= 90 ~ "Dub",
      bpm >= 80 & bpm <= 90 ~ "Reggae",
      bpm >= 80 & bpm <= 100 ~ "Hip-hop",
      bpm >= 80 & bpm <= 120 ~ "Rock Folk",
      bpm >= 90 & bpm <= 120 ~ "Rock Pop",
      bpm >= 50 & bpm <= 56 ~ "Tango",
      bpm >= 80 & bpm <= 100 ~ "Salsa",
      bpm >= 60 & bpm <= 120 ~ "Trip Hop",
      bpm >= 70 & bpm <= 120 ~ "Soul Music",
      bpm >= 100 & bpm <= 120 ~ "Chillstep",
      bpm >= 120 & bpm <= 135 ~ "Minimal",
      bpm >= 125 & bpm <= 135 ~ "Funky House",
      bpm >= 126 & bpm <= 135 ~ "Electro",
      bpm >= 125 & bpm <= 140 ~ "House Music",
      bpm >= 130 & bpm <= 140 ~ "Trance",
      bpm >= 135 & bpm <= 145 ~ "Dubstep",
      bpm >= 120 & bpm <= 150 ~ "Techno",
      bpm >= 170 & bpm <= 180 ~ "Rock Punk",
      bpm >= 150 & bpm <= 190 ~ "Drum’n’bass",
      bpm >= 60 & bpm <= 220 ~ "Jazz",
      bpm >= 80 & bpm <= 220 ~ "Rock",
      bpm >= 160 & bpm <= 230 ~ "Hardcore",
      bpm >= 200 & bpm <= 500 ~ "Speedcore",
      bpm > 1000 ~ "Extratone",
      TRUE ~ "Autre"  # Si aucune condition n'est satisfaite, assigner "Autre"
    )
  }

spotify_data<-spotify_data %>% 
  mutate(genre_by_bpm=get_genre_by_bpm(bpm))




#### Header application
dbHeader <- dashboardHeader()
dbHeader$children[[2]]$children <- tags$a(href='https://www.kaggle.com/datasets/nelgiriyewithana/top-spotify-songs-2023',
                                          tags$img(src='my_Logo.jpg',height='40',
                                                   width='130'))
