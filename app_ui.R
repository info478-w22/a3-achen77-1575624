#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library("shiny")
library("shinythemes")
library("tidyverse")
data(mpg)

introduction <- tabPanel(
  titlePanel("Introduction"),
  mainPanel(width = 12,
            h1("COVID-19 Models and Prevention Policy"),
            h2("Introduction"),
            p("At the start of the COVID-19 pandemic, many countries quickly called for national emergencies and
              deployed many preventative policies to hopefully contain the virus and keep it from spreading. Countries
              like China enacted strict quarantine laws, countries like South Korea had very adept contact tracing
              measures, and coutnries like Mexico targetted international flights and hygiene."),
            h2("Vaccinations"),
            p("The first vaccinations available for the public came out around the spring of 2021. Since then,
              multiple boosters have come out, showing high efficacy with low risk of adverse side effects. Though
              there is still much discourse about the safety of the virus, many health professionals recommend
              getting it to curb transmission rates of COVID-19."),
            h2("Mask Wearing"),
            p("Mask wearing is an interesting preventative factor because it is partly culturally relevant. Many
              collectivist countries tend to have mask wearing be much more common even before the COVID-19 pandemic.
              As for how they work, face masks work to reduce the chance of transmissibility for each point of contact
              between people. This is one half of the equation in disease modeling, which requires the number
              of contacts and how likely it is to spread disease with each contact. However, in order for face masks
              to work, widespread compliance needs to happen"),
            uiOutput("intro_img") %>%
              tagAppendAttributes(class = 'intro_img')
  )
)

deterministic <- tabPanel(
  titlePanel("Deterministic"),
  sidebarLayout(
    sidebarPanel(
      sliderTextInput(
        inputId = "plot1var",
        label = "Choose a mask enforcement level:", 
        choices = c("No Mask", "Weak Mask Deployment", "Moderate Mask Deployment", "Strong Mask Deployment")
      ),
      radioGroupButtons(
        inputId = "plot2var",
        label = "Choose vaccination status:",
        choices = c("No vaccination protocol", 
                    "Strict vaccination protocol"),
        justified = TRUE
      )
    ),
    mainPanel(
      plotOutput("plot1"),
      plotOutput("plot2"),
      p("Both of these models do not take into account demography, as the rates of arrival found in the literature
        didn't seem to work very well with the current models. However, they use a population size of
        7,766,925, which was the population size of Washington in 2021 (Office of Financial Management, 2021)."),
      p("Without any sort of preventative protocols and having COVID run its course, we can see that the rates
        of infection would peak after about a month at around 4,500,000 cases in Washington. Afterwards, they
        would decrease at about the same rate it came. If I were able to model demography, we might see large
        rates of population stagnancy considering how there would be many deaths. Changing the slider from 'no mask'
        to 'strong mask deployment' levels the curve enough so that ultimately, less than 1,000,000 people would
        be infected. It would extend the amount of time this were to happen, but would lead to less deaths,"),
      p("With vaccinations, a strict vaccine protocol would level the curve too, to the point where
        Washington would peak at a little more than 2,000,000 cases in 2 months.")
    )
  )
)



stochastic <- tabPanel(
  titlePanel("Stochastic"),
  sidebarLayout(
    sidebarPanel(
      sliderTextInput(
        inputId = "plot3var",
        label = "Choose a mask enforcement level:", 
        choices = c("No Mask", "Weak Mask Deployment", "Moderate Mask Deployment", "Strong Mask Deployment")
      ),
      radioGroupButtons(
        inputId = "plot4var",
        label = "Choose vaccination status:",
        choices = c("No vaccination protocol", 
                    "Strict vaccination protocol"),
        justified = TRUE
      )
    ),
    mainPanel(
      h2("Both of these models may take some time to appear."),
      plotOutput("plot3"),
      plotOutput("plot4"),
      p("Both of these models do not take into account demography, as the rates of arrival found in the literature
        didn't seem to work very well with the current models. They also use a population size of 700,
        as doing much higher would take too long to create plots for."),
      p("Again, having no preventative measures causes the rates of infection to peak early on. In this case,
        with a population of 700, it would peak at around a month with around 100 cases. With mask enforcement,
        stronger mask protocol seemed to eradicate COVID within 2 months with less than 20 cases."),
      p("The results were less drastic with vaccine protocols. It seemed as if having a strict vaccine protocol would
        lessen peak cases to aroudn 100 in a month.")
    )
  )
)


interpretation <- tabPanel(
  titlePanel("Interpretation"),
  mainPanel(width = 12,
            h2("Interpretation"),
            p("In a fixed population, having no preventative measures would cause the rate of infection to
              bubble early on and cause mass amounts of cases. Adding mask mandates or vaccine requirements
              greatly decreases the number of cases in a 1 year time frame."),
            p("In the deterministic models, the peaks of infection were simple parabolas that increased
              slighlty faster than they decreased. The stochastic models had extremely large margins of error,
              and actual rates could fall anywhere inside of the colored regions. The stochastic models are much
              less certain about COVID prospects with preventative measures."),
            h2("Limitations"),
            p("Notably, in both the deterministic and stochastic models, the mask enforcement seemed to be more
              effective than vaccines alone. This could have been possibly due to an error in the models."),
            p("In addition, not being able to create these models while taking into account demography means
              that they are less accurate to the real world where people die from COVID. The arrival rate
              of 0.46 from Diagne et al.'s (2021) models seemed to extend the models so far to where cases
              didn't even increase until well past 300 days."),
            uiOutput("interp_img") %>%
              tagAppendAttributes(class = 'intro_img')
  )
)

references <- tabPanel(
  titlePanel("References"),
  mainPanel(width = 12,
            h1("References") %>%
              tagAppendAttributes(class = 'references'),
            p("Diagne, M. L., Rwezaura, H., Tchoumi, S. Y., & Tchuenche, J. M. (2021).
              A mathematical model of COVID-19 with vaccination and treatment. Computational
              and Mathematical Methods in Medicine, 2021, 1-16. https://doi.org/10.1155/2021/1250129"),
            p("Eikenberry, S. E., Mancuso, M., Iboi, E., Phan, T., Eikenberry, K., Kuang, Y., Kostelich, E., & 
              Gumel, A. B. (2020). To mask or not to mask: Modeling the potential for face mask use by the 
              general public to curtail the COVID-19 pandemic. Infectious Disease Modelling, 5, 293-308. 
              https://doi.org/10.1016/j.idm.2020.04.001"),
            p("Howard, J., Huang, A., Li, Z., Tufekci, Z., Zdimal, V., van der Westhuizen, H.-M., von Delft, A., 
              Price, A., Fridman, L., Tang, L.-H., Tang, V., Watson, G. L., Bax, C. E., Shaikh, R., Questier, F., 
              Hernandez, D., Chu, L. F., Ramirez, C. M., & Rimoin, A. W. (2021). An evidence review of face 
              masks against COVID-19. Proceedings of the National Academy of Sciences, 118(4). 
              https://doi.org/10.1073/pnas.2014564118"),
            p("State population steadily increases, tops 7.7 million residents in. Office of Financial
              Management. (2021, June 30). Retrieved from
              https://ofm.wa.gov/about/news/2021/06/state-population-steadily-increases-tops-77-million-residents-2021"),
            p("Tavilani, A., Abbasi, E., Kian Ara, F., Darini, A., & Asefy, Z. (2021). Covid-19 vaccines: 
              Current evidence and considerations. Metabolism Open, 12, 100124. 
              https://doi.org/10.1016/j.metop.2021.100124")
  )
)

ui <- fluidPage(
  tags$head(
    tags$link(rel = "stylesheet", type = "text/css", href = "style.css")
  ),
  navbarPage(
    theme = shinytheme("superhero"),
    tags$div("Assignment 3"),
    introduction,
    deterministic,
    stochastic,
    interpretation,
    references
  )
)
shinyUI(ui)
