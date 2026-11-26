Assignment 4 for BHDS2010

**Assignment Overview:**
The purpose of this assignment is to apply our knowledge of R, we gained in this 
course, to develop an interactive web application that analyzes and visualizes a 
dataset chosen by our group. Our group chose to create an application exploring 
the associations between cardiovascular risk factors and coronary heart disease (CHD), 
using the South African Heart Disease study data. The purpose of the application is 
to provide an accessible way to investigate various cardiovascular risk factors and 
examine their relationships with CHD status through selecting individual risk 
factors and viewing visualizations, descriptive summary statistics, and logistic 
regression results. Each group member will contribute to the assignment using Rstudio 
to branch, commit, and pull their work onto GitHub and lastly, deploy the application 
using ShinyApps.io.

**Group Contributions:**
- **Select a Dataset** by Zaiba Shekh: Choose a dataset relevant to the course content.
- **Plan the Shiny App** by Olivia Varholak: Sketch out the structure of the 
application before coding.
- **Build the Shiny App** by Olivia Varholak: In Rstudio, create a new Shiny 
application project.
- **Test and Refine** by Olivia Varholak and Zaiba Shekh: Test the application, 
debug errors, and optimize code for performance.
- **Deploy the App** by Olivia Varholak and Zaiba Shekh: Choose a platform to 
deploy the Shiny application.

**Assignment Files:**
- **app.R:** The Rscript file containing code for the Shiny application, which 
includes user interface, server logic, visualizations, and data analysis of the 
South African Heart Disease study data.
- **app.RMD:** The R Markdown file to knit and create a reproducible report for 
the collaboration assignment.
- **README.md:** Document describing activities performed throughout the assignment 
and instructions for running the Shiny application.

**Assignment Links:**
- **GitHub Repository:** github.com/Olivia-Varholak/Assignment4.git 
- **Dataset Source:** hastie.su.domains/ElemStatLearn/datasets/SAheart.data 
- **Shiny Application:**

**Data Description:**
The South African Heart Disease study dataset has rows representing each participant 
and includes information detailing their age, systolic blood pressure, LDL cholesterol, 
tobacco use, obesity, family history of coronary heart disease, and other risk factors. 
The outcome variable, coronary heart disease (CHD), will indicate whether an 
individual has CHD or not. The dataset will allow users to compare the distributions 
of cardiovascular risk factors between participants with or without CHD and 
examine associations using logistic regression.

**Instructions for Running the Application:**
1. The GitHub Repository is cloned and the project is opened on Rstudio. 
Use File -> New Project -> Version Control -> Git, paste GitHub repository URL.
2. Within RStudio, open the app.R script.
3. Ensure the South African Heart Disease study data is available in the 
assignment directory.
3. Required R packages are installed and loaded. Use install.packages() to 
install packages (ex. shiny, ggplot2, dplyr, DT, broom). Use library() to 
load the packages and dependencies.
3. Run the application using the “Run App” button in Rstudio or the command 
“shinyApp(ui = ui, server = server).
3. The application will appear as a pop-up and users can use the selection 
features to view corresponding visualizations, summary statistics, and logistic 
regression results. 
3. Knit the app.RMD using R Markdown to create a reproducible report.

**Version Control Workflow:**
1. The GitHub repository was created by Olivia Varholak, where the app.R, 
app.RMD, and README.md were populated. 
2. Zaiba Shekh was invited to join the repository and cloned the repository into Rstudio. 
3. In the main branch, Olivia read in and imported the South African Heart Disease 
dataset as “heart_data” and ensured the data was properly loaded. Olivia defined 
the user interface for the application that draws a histogram, which includes a 
sidebar, main panel, “Analyze” button, and displays of the interactive visualizations, 
summary statistics, and logistic regression results. Olivia defined the server 
logic required to draw a histogram, which includes data management, determining 
participants and if they have CHD, determining selection of risk factor, creating 
interactive plots, calculating summary statistics, and performing logistic regression. 
Olivia provided commentary throughout to explain the usage of each code.
4. In the “App-Code-Update” branch, Zaiba edited any errors throughout the application 
code. Zaiba added in download features for the summary statistics and logistic 
regression, using “downloadButton()” in the user interface and “downloadHandler() 
in the server logic. Zaiba added in variable labels to display full names of 
variables in the corresponding boxplots. Zaiba provided commentary explaining the 
usage of each code and sent a pull request, which was merged by Olivia. 
5. README file was updated with detailed activities for the assignment and 
instructions for running the application, under the “README-Updates” branch. 
Zaiba sent the pull request and Olivia merged. 
6. Once all branches were merged, Olivia and Zaiba pulled the main branch to 
ensure all copies were updated as the repository and ran the application. 
7. Lastly, with all tasks complete, the Rmd file was knitted and a 
finalized reproducible report was created. The Shiny application was deployed 
using ShinyApps.io.

**GitHub Collaboration:**
Each group member is required to create their own branches in Rstudio to work 
independently on their assigned tasks. Once completed, any changes are committed 
and are pushed to GitHub through the member's individual branch. Lastly, pull 
requests are submitted for review and merging into the main branch.

**Data Analysis and Visualizations:** 
The South African Heart Disease dataset outputted 462 observations and 10 variables 
related to cardiovascular health. The Shiny application allows users to select a 
cardiovascular risk factor and view interactive visualizations, summary statistics, 
and logic regression results. Altogether, users can explore and compare the relationship 
between the selected cardiovascular risk factor and CHD status. The interactive 
boxplots display the cardiovascular risk factors numerically and compare distributions 
between individuals with and without CHD. Bar charts display the categorical risk 
factor and compare frequencies between CHD status. Summary statistics are calculated 
for each selected risk factor, such as sample mean, median, standard deviation, 
minimum, maximum, frequencies and percentages. Logistic regression is performed 
to investigate the relationship between a selected cardiovascular risk factor and 
CHD status, showing 95% confidence intervals, p-values, odds ratios, and statistical 
significance. Overall, the purpose of the Shiny application is to allow users to 
explore the association between cardiovascular risk factors and coronary heart disease.

**Conclusions and Remarks:**
This assignment challenged how we applied our knowledge of R by creating a Shiny 
application and broadening our skills in collaborative work through GitHub. 
Throughout the assignment, we were able to refine our R coding and communicative 
skills. We became more familiarized with GitHub and were more comfortable pushing, 
pulling, committing, and merging. We were able to effectively create and deploy 
our Shiny application and produce a completed reproducible report by actively 
providing constructive feedback and corrections. Altogether, this assignment gave 
us the opportunity to better understand R.  


