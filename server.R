library(ggplot2)
source("functions.R")


shinyServer(
    function(input, output) {
        # The code of "withProgress/incProgress" functions was learnt from, 
        # though slightly cut based on, 
        # https://github.com/ivanliu1989/SwiftKey-Natural-language/blob/master/Shiny_App/SwiftKey-Language-Modelling/server.R
        withProgress(message="App Initializing ...", value=NULL, {
            withProgress(message="Loading Data", value=0, {
                load("nGramDF.RData", .GlobalEnv)
                for (i in 1:20) {
                    incProgress(0.05, detail=paste(":", i*5, "%"))
                    Sys.sleep(0.15)
                }
            })
            # Increment the top-level progress indicator
            incProgress(0.1)
        })
        
        preds <- reactive(predictNextWord(input$textInput))
        
        topPreds <- reactive(preds()[[1]])

        output$nextWord <- renderText({topPreds()[1]})
        
        output$nextWord2 <- renderText({topPreds()[2]})
        output$nextWord3 <- renderText({topPreds()[3]})
        output$nextWord4 <- renderText({topPreds()[4]})
        output$nextWord5 <- renderText({topPreds()[5]})
        output$nextWord6 <- renderText({topPreds()[6]})
        output$nextWord7 <- renderText({"..."})
        
        # Plot
        showHist <- eventReactive(input$histWithMore, {
            morePreds <- reactive(preds()[[2]])
            data <- reactive({
                validate(
                    need(is.data.frame(morePreds()), 
                         "More options are not available!")
                )
                morePreds()
            })
            showUpdateHist(data())
        })
        
        showUpdate <- reactive(showHist())
        
        output$histgram <- renderPlot({
            if (input$textInput != "") {
                showUpdate()
            }
        })
        
        observeEvent(input$hide, {
            # alternate between hiding and showing
            shinyjs::toggle(id="histgram", 
                            anim=TRUE, animType="slide", time=NULL, 
                            condition=NULL, selector=NULL) 
            # hide("plot")
        })
    }
)
