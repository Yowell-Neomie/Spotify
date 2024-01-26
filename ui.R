base::source("packages.R")
base::source("global.r")

ui <- dashboardPage(skin = "black",
                    dbHeader,
                    dashboardSidebar(disable = TRUE),
                    dashboardBody(
                      box(
                        ...
                      ),
                      box(
                        title = "Artist",
                        solidHeader = FALSE, 
                        width = 6,
                        column(3, align = "center"),
                        column(6, align = "center"),
                        column(3, align = "center")
                      ),
                      box(
                        title = "Chat with ChatGPT",
                        solidHeader = FALSE, 
                        width = 6,
                        column(3, align = "center"),
                        column(6, align = "center"),
                        column(3, align = "center")
                      ),
                      box(
                        title = "Stats",
                        solidHeader = FALSE,
                        width = 6,
                        ...,
                        br(),
                        fluidRow(
                         ...
                        )
                      ),
                      br(), 
                      box(title = "Track & playlist presence", 
                          ...,
                      )
                      
                    )
)

