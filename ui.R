####################################################################################
#######          PRIMS point                                    ####################
#######    contributors:  Remi d'Annunzio                       ####################
#######              FAO Open Foris SEPAL project               ####################
#######    remi.dannunzio@fao.org                               ####################
####################################################################################

####################################################################################
# FAO declines all responsibility for errors or deficiencies in the database or 
# software or in the documentation accompanying it, for program maintenance and 
# upgrading as well as for any # damage that may arise from them. FAO also declines 
# any responsibility for updating the data and assumes no responsibility for errors 
# and omissions in the data provided. Users are, however, kindly asked to report any 
# errors or deficiencies in this product to FAO.
####################################################################################

####################################################################################
## Last update: 2019/02/19
## GFC_WRAPPER / ui
####################################################################################


print("Starting the process")

options(stringsAsFactors=FALSE)
options(shiny.launch.browser=T)

source("scripts/packages.R",  echo = TRUE)
source("scripts/app_config.R",echo = TRUE)


####################################################################################
####### Start User Interface

shinyUI(
  
  dashboardPage(
    skin='green',
    
    ####################################################################################
    #######       General title of the application            ##########################
    dashboardHeader(
      title= textOutput('title'),
      titleWidth = 350),
    
    ####################################################################################
    #######       Side Bar definition with all TABS           ##########################
    dashboardSidebar(
      width = 350,
      sidebarMenu(
        menuItem(textOutput('t0_title',inline=T), tabName = "main_tab", icon = icon("dashboard")),
        hr(),
        br(),
        br(),
        menuItem(textOutput('source_code',inline=T), icon = icon("file-code-o"),href = "https://github.com/openforis/"),
        menuItem(textOutput('bug_reports',inline=T), icon = icon("bug")        ,href = "https://github.com/openforis/")
      )
    ),
    
    ####################################################################################
    #######       Body structure of the Dashboard: tabItems   ##########################
    dashboardBody(
      tabItems(
        ####################################################################################
        # New Tab
        tabItem(tabName = "main_tab",
                fluidRow(
                  # ####################################################################################
                  # Change style of the CSS style of the tabBox, making the color green
                  tags$style(".nav-tabs-custom .nav-tabs li.active {border-top-color: #00994d;}"),
                  
                  ## CSS format for errors, making the message in purple
                  tags$head(tags$style(HTML(".shiny-output-error-validation {color: #cc00ff;font-family:courier;font-size: 120%;}"))),
                  
                  ####################################################################################
                  # New box
                  box(
                    title= textOutput('title_language'), width=3,status = "success", solidHeader= TRUE,
                    selectInput(
                      'language','',choices = c("English")),
                    uiOutput("chosen_language")
                  ),
                  
                  ####################################################################################
                  # New box
                  box(
                    title= textOutput('title_description'), width=6,status = "success", solidHeader= TRUE,
                    htmlOutput('body_description'),
                    
                    selectizeInput(
                        'country_code',
                      textOutput('text_choice_country'),
                      choices = setNames(getData('ISO3')[,1], 
                                         getData('ISO3')[,2]),
                      options = list(
                        placeholder = '',#Please select a country from the list below',#htmlOutput('t6_b2_button1_field'),
                        onInitialize = I('function() { this.setValue(""); }')
                      )
                    ),
                    
                    sliderInput('threshold',
                                textOutput('text_choice_threshold'),
                                min = 0,
                                max=100,
                                step = 5,
                                value=30
                                )
                    
                  ),
                  
                  # ###################################################################################
                  # #New boxanother
                  box(
                    title= textOutput('another'), width=3,status = "success", solidHeader= TRUE,
                    htmlOutput('dfg')
                  )
                  
                  # ,
                  # ###################################################################################
                  # #New box
                  # box(
                  #   title= textOutput('title_download_testdata'), width=3,status = "success", solidHeader= TRUE,
                  #   actionButton("download_test_button",
                  #                textOutput('download_testdata_button')),
                  #   uiOutput("dynUI_download_test")
                  # )
                  
                  
                ),
                ####################################################################################
                # End of the fluid row
                
                fluidRow(
                  ####################################################################################
                  # New box
                  box(title= textOutput('title_ts_dir'),width=6, status = "success", solidHeader= TRUE,
                      #htmlOutput('body_ts_dir'),
                      #br(),
                      
                      textOutput('filepath')
                  ),
                  
                  ####################################################################################
                  # New box
                  box(title= textOutput('title_opt_dir'),width=6, status = "success", solidHeader= TRUE,
                      htmlOutput('body_opt_dir')
                      # selectInput(inputId = 'option_graph_type',
                      #             label = textOutput('label_option_graph_type'),
                      #             choices = c("Color overlap","BW separated","Cross-correlation"),
                      #             multiple = FALSE,
                      #             selected = "Color overlap"
                      # )
                      # 
                      # ,
                      # selectInput(inputId = 'option_frequency',
                      #             label = textOutput('label_option_aggregation'),
                      #             choices = c("Monthly","Weekly","Daily","10 minutes"),
                      #             multiple = FALSE,
                      #             selected = "10 minutes"
                      # )
                      
                      # ,
                      # selectInput(inputId = 'option_Transition',
                      #             label = "Transition Core - Loop/Bridge",
                      #             choices = c(0,1),
                      #             multiple = FALSE,
                      #             selected = 1
                      # )
                      
                      #,
                      # selectInput(inputId = 'option_Intext',
                      #             label = "Separate internal from external features ?",
                      #             choices = c(0,1),
                      #             multiple = FALSE,
                      #             selected = 1
                      # )
                      
                      #,
                      # selectInput(inputId = 'option_dostats',
                      #             label = "Compute statistics ?",
                      #             choices = c(0,1),
                      #             multiple = FALSE,
                      #             selected = 1
                      # )
                       
                  )
                  
                ),
                ####################################################################################
                # End of the fluid row
                
                fluidRow(
                  ####################################################################################
                  # New box
                  box(title=textOutput('title_process'),width=6,status = "success", solidHeader= TRUE,
                      uiOutput("MergeButton"),
                      uiOutput("MapButton"),
                      uiOutput("StatButton")
                  ),
                  
                  ####################################################################################
                  # New box
                  box(title= textOutput('results'),width=6, status = "success", solidHeader= TRUE,
                      uiOutput("DisplayMapButton"),
                      plotOutput("display_res")
                      
                      
                  )
                  ####################################################################################
                  # End of the Box
                  
                ),
                ####################################################################################
                # End of the fluid row
                
                fluidRow(
                  ####################################################################################
                  # New box
                  box(title=textOutput('title_disclaimer'),width=12,status = "success", solidHeader= TRUE,
                      br(),
                      htmlOutput('body_disclaimer'),
                      br(),
                      br(),
                      img(src="thumbnails/sepal-logo-EN-white.jpg", height = 100, width = 210),
                      img(src="thumbnails/UNREDD_LOGO_COLOUR.jpg",  height = 80,  width = 100),
                      img(src="thumbnails/Open-foris-Logo160.jpg",  height = 70,  width = 70),
                      br()
                  )
                  ####################################################################################
                  # End of the Box
                  
                )
                ####################################################################################
                # End of the fluid row
                
        )
        ####################################################################################
        # End of the tabItem 
        
      )
      ####################################################################################
      # End of the tabItem list
      
    )
    ####################################################################################
    # End of the Dashboard Body
    
  )
  ####################################################################################
  # End of the Dashboard Page 
  
)
####################################################################################
# End of the User Interface