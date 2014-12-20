shinyServer(function(input, output, session) {
      
       
        #source("http://bioconductor.org/biocLite.R")
        #biocLite("EBImage")
        
        output$myImage <- renderImage({
                # A temp file to save the output.
                # This file will be removed later by renderImage
                outfile <- tempfile(fileext='.png')
                
                # Generate the PNG
                
               colors<-c("red", "yellow", "green", "violet", "orange", "blue", "pink", "cyan")
                
                x<- rnorm(input$obs)
                png(outfile, width=600, height=400)
                h<-hist(x, main="Generated in renderImage()",col=colors)
                xfit<-seq(min(x),max(x),length=40) 
                yfit<-dnorm(xfit,mean=mean(x),sd=sd(x)) 
                yfit <- yfit*diff(h$mids[1:2])*length(x) 
                lines(xfit, yfit, col="blue", lwd=2)
                dev.off()
                             
                
                # Return a list containing the filename
                list(src = outfile,
                     contentType = 'image/png',
                     width = 600,
                     height = 400,
                     alt = "Historgram using Image")
             
               # }, deleteFile = TRUE)
        },deleteFile = FALSE)
        
        # image2 sends pre-rendered images
        output$image2 <- renderImage({
                if (is.null(input$picture))
                        return(NULL)
                
                if (input$picture == "Cats") {
                        return(list(
                                src = "www/images/pic1.png",
                                contentType = "image/png",
                                alt = "Cats",width = 700,
                                height = 400
                        ))
                } else if (input$picture == "Penguins") {
                        return(list(
                                src = "www/images/Penguins.jpg",
                                filetype = "image/jpeg",
                                alt = "Happy Feets!",width = 500,
                                height = 275
                        ))
                }
                
        }, deleteFile = FALSE)
        
        ImgProcess <- reactive({
                if (is.null(input$picture))
                        return(NULL)
                
                if (input$picture == "Cats") {
                        
                                src = "www/images/pic1.png"
                                img<-readPNG(src)
                        
                } else if (input$picture == "Penguins") {
                       
                                src = "www/images/Penguins.jpg"
                                img<-readJPEG(src)
                     
                } else if (input$picture == "other") {
                
                src = input$MyImage
                img<-readJPEG(src)
                
        }
                
                #return(img)
        })
        
        # image2 sends pre-rendered images
        output$img2print <- renderPrint({
               img1<-ImgProcess()
               list(Dimension=dim(img1), Summary=summary(img1), Mode=mode(img), Type=typeof(img),
                    Heads=head(img1,20),Tails=tail(img1,20))
               
         
                
        })
        
        # plotting image matrix
        output$plot1 <- renderPlot({
                img1<-imagematrix(ImgProcess())
                plot(img1)
                
        })
        
        
       
        
        
})

                
