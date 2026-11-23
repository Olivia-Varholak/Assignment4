#Set working directory
#setwd("~/Desktop/BHDS2010/Assignment4")

#Install all necessary packages for project. shiny will create the interactive
#application. ggplot2 will generate visualizations. dplyr will manage data and 
#calculate the summary statistics. DT will create interactive data tables. broom 
#organizes logistic regression results.
#Once installed you can comment out the installation code to help the program run 
#more smoothly
#install.packages("shiny")
#install.packages("ggplot2")
#install.packages("dplyr")
#install.packages("DT")
#install.packages("broom")

#Load all the packages
library(shiny)
library(ggplot2)
library(dplyr)
library(DT)
library(broom)

#Import data set and set it to an object called heart_data
heart_data <- read.table("https://hastie.su.domains/ElemStatLearn/datasets/SAheart.data",
                         sep=",",head=T,row.names=1)
#Ensuring that the data loaded into the object correctly
#View(heart_data)

#Determining the number of observations in the data set
nrow(heart_data)
#The output shows that there are a total of 462 observations in the data set

#Determining the names of the variables in the data set
str(heart_data)
#The output shows that there are 10 variables in this data set. The names of those
#variables are as follows: sbp, tobacco, ldl, adiposity, famhist, typea, obesity,
#alcohol, age, and chd.

#Checking to see if any values are missing from the data 
colSums(is.na(heart_data))
#The output shows that there are no missing values anywhere in the data

#Determine if the family history variable is a factor
is.factor(heart_data$famhist)
#The output shows FALSE, meaning that the family history variable is not a factor

#Convert the family history variable into a factor
heart_data$famhist <- as.factor(heart_data$famhist)

#Confirm that the family history variable is now a factor
is.factor(heart_data$famhist)
#The output shows that the code above did turn the family history variable into 
#a factor 

#Determine if the CHD variable is a factor
is.factor(heart_data$chd)
#The output shows FALSE, meaning the CHD variable is not a factor

#Create a categorical variable for CHD status while keeping the original numerical
#variable for logistic regression
heart_data$chd_status <- factor(heart_data$chd, levels=c(0,1),labels=c("No CHD", "CHD"))

#Confirm that the CHD variable is now a factor
is.factor(heart_data$chd_status)
#The output shows that the code above did turn the CHD variable into a factor

#Determine the number of individuals with and without CHD
table(heart_data$chd_status)
#The output shows that there are 302 individuals with no CHD and 160 individuals 
#with CHD

#Determine the percentage of individuals with and without CHD
prop.table(table(heart_data$chd_status))*100
#The output shows that the percentage of individuals without CHD in this data set 
#is 65.36797. The percentage of individuals with CHD in this data set is 34.63203.



# Define UI for application that draws a histogram
ui <- fluidPage(
  #Creating the title of the Shiny App dashboard
  titlePanel("South African Heart Disease Dashboard"),
  
  #Creating a section that allows the user to understand the purpose of the dashboard
  p("Investigating assocaitions between cardiovascular risk factors and coronary
    heart disease (CHD)."),
  
  #Create a layout with a sidebar and a main panel
  sidebarLayout(
    #Create a sidebar that allows for user inputs
    sidebarPanel(
      #The h3 function has to do with the sizing of the headings within the app
      h3("User Inputs"),
      #Creating a dropdown menu that allows for users to select Variable A
      selectInput(
        inputId="variableA",
        label="Variable A: Select a Cardiovascular Risk Factor",
        choices=c("Systolic Blood Pressure"="sbp", "Tobacco Consumption"="tobacco",
                  "LDL Cholesterol"="ldl", "Adiposity"="adiposity", "Family History"="famhist",
                  "Type A Behavior"="typea", "Obesity"="obesity", "Alcohol Consumption"="alcohol",
                  "Age"="age")
      ),
      
        #Set Variable B to a fixed variable
        #The h4 function has to do with the sizing of the headings within the app.
        #This heading is smaller than others
        h4("Variable B:"),
        p("Coronary Heart Disease (CHD)"),
        
        #Create the Analyze button using the actionButton function
        actionButton(inputId="analyze", label="Analyze")
      ),
      
      #Create a main panel
      mainPanel(
        #Display general statistics about the data set
        #The fluidRow function allows the outputs to be on the same row
        fluidRow(
          
          #Display the total number of individuals
          #The h4 function creates the heading
          column(4,
                 #The h4 function is creating a smaller font heading 
                 h4("Total Participants"),
                 #The textOutput function is creating a place in the UI to display
                 #the results
                 textOutput("totalParticipants")),
          
          #Display the number of individuals with CHD
          column(4,
                 #The h4 function is creating a smaller font heading 
                 h4("CHD Cases"),
                 #The textOutput function is creating a place in the UI to display
                 #the results
                 textOutput("chdCases")),
          
          #Display the percentage of individuals with CHD
          column(4,
                 #The h4 function is creating a smaller font heading
                 h4("CHD Percentage"),
                 #The textOutput function is creating a place in the UI to display
                 #the results
                 textOutput("chdPercentage"))
        ),
        
        #Create a horizontal line to separate sections using the hr function
        hr(),
        
        #Display interactive visualizations
        #The h3 function is creating a heading
        h3("Interactive Visualization"),
        #The plotOutput function is creating a place in the UI to display the plot
        #that is created in the server section
        plotOutput("riskPlot"),
        
        #Create a horizontal line to separate sections using the hr function
        hr(),
        
        #Display the summary statistics
        #The h3 function is creating a heading
        h3("Summary Statistics"),
        #The plotOutput function is creating a place in the UI to display the plot
        #that is created in the server section
        DTOutput("summaryStats"),
        
        #The downloadButton will allow users to download the summary statistics
        downloadButton("downloadSummary", "Download Summary Statistics"),
        
        #Create a horizontal line to separate sections using the hr function
        hr(),
        
        #Display logistic regression results
        #The h3 function is creating a heading
        h3("Logistic Regression Results"),
        #The plotOutput function is creating a place in the UI to display the plot
        #that is created in the server section
        DTOutput("regressionResults"),
        
        #The downloadButton will allow used to download the logistic regression results
        downloadButton("downloadRegression", "Download Logistic Regression Results")
      )
      )
    )


  

# Define server logic required to draw a histogram
server <- function(input, output) {
  #Data management
  #The reactive function below allows the Shiny application to access data and
  #then respond to changes that have been made in that data
  Data <- reactive({
    heart_data
  })
  
  #Determine the total number of participants
  #The renderText function converts the calculated results and turn it into a 
  #displayable text for the Shiny app
  #The output$totalParticipants assigns the output to a object that can be accessed
  #in the UI
  output$totalParticipants <- renderText({
    nrow(Data())
  })
  
  #Determine the number of participants with CHD
  #The renderText function converts the calculated results and turn it into a 
  #displayable text for the Shiny app
  #The output$chdCases assigns the output to a object that can be accessed
  #in the UI
  output$chdCases <- renderText({
    #The table function counts the number of individuals with CHD and without CHD
    table(Data()$chd_status)["CHD"]
  })

  #Determine the percentage of participants with CHD
  #The renderText() function converts the results into displayable text
  output$chdPercentage <- renderText({
    #The table function counts the number of individuals with CHD and without CHD
    #The prop.table() function converts the counts into proportions which are then 
    #multiplied by 100 to make into a percentage 
    percentage <- prop.table(table(Data()$chd_status))*100
    #The percentage is rounded to 2 decimal places. The paste0 function allows
    #for the percent symbol to be added to the end of the result
    paste0(round(percentage["CHD"],2),"%")
  })
  
  #Determine which cardiovascular risk factor the user selected
  #when the Analyze button is clicked
  selectedVariable <- eventReactive(input$analyze, {
    #The following code will retrieve the variable that the user selected from the 
    #dropdown menu
    input$variableA
  }, ignoreNULL = FALSE)
  
  #Create an interactive plot for the Shiny app
  #the rederPlot function creates the plot that will be displayed in the UI
  output$riskPlot <- renderPlot({
    
    #Identify which cardiovascular risk factor the user selected
    variable <- selectedVariable()
    
    #Determine if the selected variable is numerical
    if (is.numeric(Data()[[variable]])) {
  
    #Create a boxplot to compare the selected cardiovascular risk factor between
    #individuals with and without CHD. The .data[[variable]] section of the code 
    #allows the y-axis to change based on the user input. The fill section changes
    #the color of the boxes based on the CHD group(with CHD and without CHD)
    ggplot(Data(), aes(x=chd_status, y=.data[[variable]],
                     fill=chd_status)) +
     geom_boxplot() +
    
      #Adding, variable labels, a title and axis labels to the boxplot
labs(title=paste(switch(variable,
                        sbp="Systolic Blood Pressure",
                        tobacco="Tobacco Consumption",
                        ldl="LDL Cholesterol",
                        adiposity="Adiposity",
                        typea="Type A Behavior",
                        obesity="Obesity",
                        alcohol="Alcohol Consumption",
                        age="Age"),
                 "by CHD Status"),
     x="Coronary Heart Disease Status",
     y=switch(variable,
              sbp="Systolic Blood Pressure",
              tobacco="Tobacco Consumption",
              ldl="LDL Cholesterol",
              adiposity="Adiposity",
              typea="Type A Behavior",
              obesity="Obesity",
              alcohol="Alcohol Consumption",
              age="Age"),
     fill="CHD Status")
    } else {
      
      #Create a bar chart if the selected cardiovascular risk factor is categorical
      ggplot(Data(), aes(x=.data[[variable]], fill=chd_status)) +
        #Setting dodge as the position allows the bars to placed next to each other
        geom_bar(position="dodge") + 
        
        #Add a title and axis labels to the bar chart
        labs(title="Family History by CHD Status",
             x="Family History",
             y="Frequency",
             fill="CHD Status")
    }
  })
  
    #Calculate the summary statistics. The renderDt function allows the data table
    #to be shown in the UI
    output$summaryStats <- renderDT({
      #Need to identify which risk factor that the user selected
      variable <- selectedVariable()
      
      #Determine if the selected variable is numerical
      if (is.numeric(Data()[[variable]])) {
        
        #Calculate summary statistics by CHD status. %>%, also known as the pipe
        #operator allows the results of this function to be passed directly into
        #the next function
        Data() %>%
          #The group_by function groups based on the CHD status of the individuals 
          #in the data set (without CHD and with CHD)
          group_by(chd_status) %>%
          #The summaries function will calculate the summary statistics based on the 
          #groups summarized above. 
          summarise(
            Sample_Size = n(),
            Mean = round(mean(.data[[variable]]),2),
            Median = round(median(.data[[variable]]),2),
            SD = round(sd(.data[[variable]]),2),
            Minimum = round(min(.data[[variable]]),2),
            Maximum = round(max(.data[[variable]]),2)
          )
      } else {
        
        #Calculate summary statistics for categorical variables
        Data() %>%
          #The group_by function will group based on CHD status as well as family history
          group_by(chd_status, famhist) %>%
          #The frequency is calculated based on the groups listed above.
          #.groups="drop_last" allows for the CHD grouping to stay
          summarise(Frequency = n(), .groups="drop_last") %>%
          #The mutate function creates a new column called Percentage
          mutate(Percentage = round(Frequency/sum(Frequency)*100,2)) %>%
          #The ungroup function removes the remaining grouping
          ungroup()
      }
    })
    
     #Perform logistic regression
      output$regressionResults <- renderDT({
      
      #Identify which cardiovascular risk factor the user selected
      variable <- selectedVariable()
      
        #Create a dynamic logistic regression formula
        #The as.formula function converts the text into a statistical formula
        formula <- as.formula(paste("chd ~", variable))
      
        #Perform binary logistic regression
        #The glm function fits a generalized linear model
        #The family=binomial specifies binary logistic regression
        model <- glm(formula, data=Data(), family=binomial)
      
        #Calculate odds ratios and 95% confidence intervals
        #The tidy function organizes the regression results into a table
        tidy(model, exponentiate=TRUE, conf.int=TRUE, conf.level=0.95) %>%
          
          #Remove the intercept from the table
          filter(term != "(Intercept)") %>%
          
          #Select and rename the columns of interest
          select(
            Risk_Factor = term,
            Odds_Ratio = estimate,
            Lower_CI = conf.low,
            Upper_CI = conf.high,
            P_Value = p.value
          ) %>%
          
          #Determine statistical significance and round the regression results
          #The mutate function creates or modifies columns
          mutate(
            #The ifelse function determines statistical significance by comparing 
            #the p-value to a significance level of 0.05
            Significance = ifelse(P_Value < 0.05,
                                  "Statistically Significant",
                                  "Not Statistically Significant"),
            #Round the following to 3 decimal places
            Odds_Ratio = round(Odds_Ratio,3),
            Lower_CI = round(Lower_CI,3),
            Upper_CI = round(Upper_CI,3),
            #The signif function rounds the p-value to three significant figures 
            #rather than three decimal places
            P_Value = signif(P_Value,3)
            
          )
    })
      
      #Allow users to download the summary statistics
      output$downloadSummary <- downloadHandler(
        
        #Name the downloaded file
        filename = function() {
          "Summary_Statistics.csv"
        },
        
        #Create the downloadable CSV file
        content = function(file) {
          
          #Identify the selected cardiovascular risk factor
          variable <- selectedVariable()
          
          #Calculate summary statistics for numerical variables
          if (is.numeric(Data()[[variable]])) {
            
            summaryData <- Data() %>%
              group_by(chd_status) %>%
              summarise(
                Sample_Size = n(),
                Mean = round(mean(.data[[variable]]),2),
                Median = round(median(.data[[variable]]),2),
                SD = round(sd(.data[[variable]]),2),
                Minimum = round(min(.data[[variable]]),2),
                Maximum = round(max(.data[[variable]]),2)
              )
            
          } else {
            
            #Calculate frequencies and percentages for categorical variables
            summaryData <- Data() %>%
              group_by(chd_status, famhist) %>%
              summarise(Frequency = n(), .groups="drop_last") %>%
              mutate(Percentage = round(Frequency/sum(Frequency)*100,2)) %>%
              ungroup()
          }
          
          #Write the results into a CSV file
          write.csv(summaryData, file, row.names=FALSE)
        }
      )
      
      #Allow users to download the logistic regression results
      output$downloadRegression <- downloadHandler(
        
        #Name the downloaded file
        filename = function() {
          "Logistic_Regression_Results.csv"
        },
        
        #Create the downloadable CSV file
        content = function(file) {
          
          #Identify the selected cardiovascular risk factor
          variable <- selectedVariable()
          
          #Create the logistic regression formula
          formula <- as.formula(paste("chd ~", variable))
          
          #Perform binary logistic regression
          model <- glm(formula, data=Data(), family=binomial)
          
          #Calculate odds ratios and 95% confidence intervals
          regressionData <- tidy(model, exponentiate=TRUE,
                                 conf.int=TRUE, conf.level=0.95) %>%
            
            #Remove the intercept
            filter(term != "(Intercept)") %>%
            
            #Select and rename the columns
            select(
              Risk_Factor = term,
              Odds_Ratio = estimate,
              Lower_CI = conf.low,
              Upper_CI = conf.high,
              P_Value = p.value
            ) %>%
            
            #Determine statistical significance and round results
            mutate(
              Significance = ifelse(P_Value < 0.05,
                                    "Statistically Significant",
                                    "Not Statistically Significant"),
              Odds_Ratio = round(Odds_Ratio,3),
              Lower_CI = round(Lower_CI,3),
              Upper_CI = round(Upper_CI,3),
              P_Value = signif(P_Value,3)
            )
          
          #Write the results into a CSV file
          write.csv(regressionData, file, row.names=FALSE)
        }
      )
}
  
#Run the application 
shinyApp(ui = ui, server = server)
