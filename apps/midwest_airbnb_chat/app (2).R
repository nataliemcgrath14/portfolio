library(shiny)
library(querychat)
library(DBI)
library(RSQLite)
library(ellmer)
library(bslib)

con <- DBI::dbConnect(
  RSQLite::SQLite(),
  "data/midwest_airbnb.db"
)

client <- ellmer::chat_openai(
  model = "gpt-5.6-luna",
  params = ellmer::params(reasoning_effort = "none")
)

qc <- querychat::querychat(
  con,
  "listings",
  client = client,
  tools = c("filter", "query", "visualize"),
  greeting = "Ask me about 14,887 Airbnb listings in Chicago, Columbus, and the Twin Cities.",
  data_description = "data/data_desc.md",
  extra_instructions = "data/extra_instructions.md"
)

ui <- page_sidebar(
  title = "Midwest Airbnb Explorer",

  theme = bs_theme(
    version = 5,
    bootswatch = "minty"
  ),

  sidebar = sidebar(
    h4("About"),
    p(
      "Explore Airbnb listings from Chicago, Columbus, and the Twin Cities.
       Ask questions about prices, ratings, availability, hosts, and other
       listing details."
    )
  ),

  qc$ui()
)

server <- function(input, output, session) {
  qc$server()
}

shinyApp(ui = ui, server = server)
