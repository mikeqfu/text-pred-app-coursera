library(shiny)
library(shinyjs)

shinyUI(
    fluidPage(
        
        titlePanel(
			"A simple app for text prediction"
		),
        
		sidebarLayout(
            sidebarPanel(
                h3("Introduction"),
                p("This simple Shiny app is created for the ", 
                  a(strong("Capstone Project"),
                    href="https://www.coursera.org/learn/data-science-project/",
                    target="_blank"), "of the", 
                  a(strong("Data Science"), 
                    href=paste0("https://www.coursera.org/specializations/", 
                                "jhu-data-science"),
                    target="_blank"), 
                  "Coursera course. It contains a predictive text model that 
                  may guess the most likely word following a given text message 
                  and, in addition, also provide several alternatives for what 
                  the next word might be."), 
				p("For example, when we type: \"It was nice\", the next word 
				  might be most likely to be \"to\"; or it might be something 
				  like \"meeting\", \"seeing\", ..."),
				p("In this app, the predictions are based on machine learning 
				  from written text data sourced from Internet blogs, news and 
				  twitter. The data set is available here:", 
				  a("Coursera-SwiftKey.zip", 
				    href=paste0("https://d396qusza40orc.cloudfront.net/", 
				                "dsscapstone/dataset/Coursera-SwiftKey.zip"))), 
				p("For more details about how the algorithm used to make the 
				  prediction, see", 
				  a("A simple app for text prediction", 
				    href="https://rpubs.com/mikeqfu/textPredCoursera",
				    target="_blank"), "and a", 
				  a("Milestone report", 
				    href="http://rpubs.com/mikeqfu/ds_cap_milestone_report",
				    target="_blank"), "for this project."),
				hr(), 
				helpText(h3("Instructions:")), 
				helpText("- An example for our text prediction has been already 
				         presented. (See the right side of this page 
				         (i.e. the main panel).)"),
				helpText("- To begin a new prediction task, simply delete any 
				         existing texts in the provided textbox below", 
				         strong('"Type English text below";')),
				helpText("- For any prediction tasks, type English texts 
				         (at least a single word) in the textbox; Note that 
				         the app might not be able to make a prediction for 
				         misspelled input;", "a link to the free online Oxford 
				         Dictionaries is provided in case needed;"), 
				helpText('- As we type, the most-likely next word will 
				         show and update at the same time below', 
				         strong('"The next word might be";')), 
				helpText("- In addition, more alternative words will also be 
				         available below", 
				         strong('"More alternatives of the next word";')),
				helpText("- If we would like to check up on the histogram, 
				         based on which the next words are predicted, and/or 
				         have a look at even more alternatives, just click the",
				         strong('"Show/Update'), 'histogram (with even more 
				         alternatives) for predicting the next word"',
				         "button."),
				helpText("- Note that the histogram will not be updated 
				         automatically. We must click the", 
				         strong('"Show/Update'), 'histogram (with even more 
				         alternatives) for predicting the next word"', 
				         "button again to update the histogram"),
				helpText("- The", strong('"Hide/Display"'), "button can be used 
				         to hide or display the current histogram again."),
				width=4
            ),
            
            mainPanel(
				h3("Type English text below:"),
				textInput(inputId="textInput", 
				          label="", 
				          value="It was nice to "),
				tags$head(
				    tags$style(type="text/css", "#textInput {width: 650px}")),
				p("Check with", a("Oxford Dictionaries", 
				                  href="http://www.oxforddictionaries.com/", 
				                  target="_blank")),
				hr(),
				h3("The next word might be:"),
				textOutput(outputId = "nextWord"),
				h3("More alternatives:"),
				textOutput(outputId="nextWord2"), 
				textOutput(outputId="nextWord3"), 
				textOutput(outputId="nextWord4"), 
				textOutput(outputId="nextWord5"), 
				textOutput(outputId="nextWord6"),
				textOutput(outputId="nextWord7"),
				br(),
				actionButton(
				    inputId="histWithMore", 
				    # strong("Show/Update"),
				    label="histogram (with even more alternatives) 
				    for predicting the next word"), 
				useShinyjs(), 
				actionButton(inputId="hide", label=strong("Hide/Display")),
				br(),
				br(),
				p("(Note that the", 
				  strong('"Frequency"'), 
				  "will be based on the input text and", 
				  "the corpus produced from the data)"),
                plotOutput(outputId="histgram", width="66%", height="450px"),
				textOutput(outputId="noMore")
            )
        )
		
    )
)
