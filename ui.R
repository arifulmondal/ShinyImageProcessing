shinyUI(pageWithSidebar(
        headerPanel("Basic Image Processing"),
        sidebarPanel(
                  sliderInput("obs", "Histogram Input:Number of observations",
                                            min = 500, max = 50000,  value = 20000),
                                br(),
                           
                                hr(),
                 
                  # Select Image options
                  selectInput("picture", label = h3("Select Image:"), 
                              choices = list("Cats" = "Cats", "Penguins" = "Penguins", "myImage" = "other"), 
                              selected = "Penguins"),
                  #Upload Image
                 
                  fileInput("MyImage", label = h3("My Image"))
                  
        ),
        mainPanel(
               
                h4("Printing Hostogram Image:"),
                imageOutput("myImage"),
                br(),
                h4("Original Image:"),
                imageOutput("image2"),
                br(),
                h4("Image From Numeric Matrix:"),
                plotOutput('plot1'),
                br(),      
                h4("Basic Image Properties:"),
                verbatimTextOutput("img2print"),
                br()
               
                
        )
))