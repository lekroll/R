# Setup R for RKI Analysis and Corporate Identity Graphics (unofficial)
###########################################################
# Version 1.0
# Author: L. E. Kroll from www.rki.de

# Standard Libraries
#===================
library(tidyverse) # All main tidyverse libs in one single package
library(extrafont) # Font library for Graphics
library(haven)     # Stata-Import
library(readxl)    # XLSX-Import
library(httr)      # Solve Problem using curl behind proxy w/o special config
library(survey)    # Survey Methods
library(srvyr)     # Tidy Survey Methods
library(tableone)  # Descriptives Table
library(stargazer) # Regression Table Output
library(labelled)  # Variable labels attribute

# Proxy-Settings (not included due to confidentiality)
# set_config(use_proxy(SERVERNAME , port = SERVERPORT ), override = TRUE)

# RKI-Theme
# =========
# Environment
rki <- new.env()

local({
  # RKI Colors 
  rkihc1 <- rgb(0/255,94/255,184/255) # Blau dunkel
  rkihc2 <- rgb(89/255,150/255,209/255) 
  rkihc3 <- rgb(178/255,206/255,234/255)  # Blau hell
  rkihc4 <- rgb(103/255,103/255,103/255) # Grau dunkel
  rkihc5 <- rgb(150/255,150/255,150/255)
  rkihc6 <- rgb(209/255,209/255,209/255) # Grau Hell
  rkihc7 <- rgb(184/255,0/255,94/255) # rot dunkel
  rkihc8 <- rgb(209/255,89/255,150/255)
  rkihc9 <- rgb(234/255,178/255,206/255) # rot hell
  rkihc10 <- rgb(94/255,184/255,0/255) # grün dunkel
  rkihc11 <- rgb(150/255,209/255,89/255)
  rkihc12 <- rgb(206/255,234/255,178/255) # grün hell
  
  rki1 <- rgb(0/255,94/255,184/255) # Blau dunkel
  rki2 <- rgb(51/255,126/255,194/255) 
  rki3 <- rgb(102/255,158/255,212/255) # Blau mittel 
  rki4 <- rgb(153/255,191/255,227/255) 
  rki5 <- rgb(178/255,206/255,234/255)  # Blau hell
  
  # Schemes
  palette5blues <-  c(rki$rki1, rki$rki2 , rki$rki3 ,rki$rki4 ,rki$rki5)
  palette3c <-  c(rki$rkihc1, rki$rkihc2 , rki$rkihc3)
  palette4c <-  c(rki$rkihc1, rki$rkihc2 , rki$rkihc4, rki$rkihc5)
  palette5c <-  c(rki$rkihc1, rki$rkihc2 , rki$rkihc3, rki$rkihc4, rki$rkihc5, rki$rkihc6)
  palette6c <-  c(rki$rkihc1, rki$rkihc2 , rki$rkihc3, rki$rkihc4, rki$rkihc5, rki$rkihc6)
  palette8c <-  c(rki$rkihc1, rki$rkihc2 , rki$rkihc3, rki$rkihc4, rki$rkihc5,rki$rkihc6,rki$rkihc7,rki$rkihc8)
  palette12c <-  c(rki$rkihc1, rki$rkihc2 , rki$rkihc3, rki$rkihc4, rki$rkihc5,rki$rkihc6,rki$rkihc7,rki$rkihc8,rki$rkihc9, rki$rkihc10 , rki$rkihc11, rki$rkihc12)
  
  rkifill_3c <-  scale_fill_manual(values = c(rki$rkihc1, rki$rkihc2 , rki$rkihc3))
  rkifill_4c <-  scale_fill_manual(values = c(rki$rkihc1, rki$rkihc2 , rki$rkihc4, rki$rkihc5))
  rkifill_5c <-  scale_fill_manual(values = c(rki$rkihc1, rki$rkihc2 , rki$rkihc3, rki$rkihc4, rki$rkihc5, rki$rkihc6))
  rkifill_6c <-  scale_fill_manual(values = c(rki$rkihc1, rki$rkihc2 , rki$rkihc3, rki$rkihc4, rki$rkihc5, rki$rkihc6))
  rkifill_8c <-  scale_fill_manual(values = c(rki$rkihc1, rki$rkihc2 , rki$rkihc3, rki$rkihc4, rki$rkihc5, rki$rkihc6, rki$rkihc7, rki$rkihc8))
  rkifill_blue_red_6 <-  scale_fill_manual(values = c(rki$rkihc1, rki$rkihc2 , rki$rkihc3, rki$rkihc7, rki$rkihc8, rki$rkihc9))  
  rkifill_blue_red_4 <-  scale_fill_manual(values = c(rki$rkihc1, rki$rkihc2 , rki$rkihc7, rki$rkihc8))  
  rkifill_blue_red_4 <-  scale_fill_manual(values = c(rki$rkihc1, rki$rkihc7))  
  
  rkicolour_3c <-  scale_colour_manual(values = c(rki$rkihc1, rki$rkihc2 , rki$rkihc3))
  rkicolour_4c <-  scale_colour_manual(values = c(rki$rkihc1, rki$rkihc2 , rki$rkihc4, rki$rkihc5))
  rkicolour_5c <-  scale_colour_manual(values = c(rki$rkihc1, rki$rkihc2 , rki$rkihc3, rki$rkihc4, rki$rkihc5, rki$rkihc6))
  rkicolour_6c <-  scale_colour_manual(values = c(rki$rkihc1, rki$rkihc2 , rki$rkihc3, rki$rkihc4, rki$rkihc5, rki$rkihc6))
  rkicolour_8c <-  scale_colour_manual(values = c(rki$rkihc1, rki$rkihc2 , rki$rkihc3, rki$rkihc4, rki$rkihc5))
  rkicolour_blue_red_6 <-  scale_colour_manual(values = c(rki$rkihc1, rki$rkihc2 , rki$rkihc3, rki$rkihc7, rki$rkihc8, rki$rkihc9))  
  rkicolour_blue_red_4 <-  scale_colour_manual(values = c(rki$rkihc1, rki$rkihc2 , rki$rkihc7, rki$rkihc8))  
  rkicolour_blue_red_4 <-  scale_colour_manual(values = c(rki$rkihc1, rki$rkihc7))  
  
  
  # Reversed Schemes
  revrkifill_3c <-  scale_fill_manual(values = rev(c(rki$rkihc1, rki$rkihc2 , rki$rkihc3)))
  revrkifill_4c <-  scale_fill_manual(values = rev(c(rki$rkihc1, rki$rkihc2 , rki$rkihc4, rki$rkihc5)))
  revrkifill_5c <-  scale_fill_manual(values = rev(c(rki$rkihc1, rki$rkihc2 , rki$rkihc3, rki$rkihc4, rki$rkihc5, rki$rkihc6)))
  revrkifill_6c <-  scale_fill_manual(values = rev(c(rki$rkihc1, rki$rkihc2 , rki$rkihc3, rki$rkihc4, rki$rkihc5, rki$rkihc6)))
  revrkifill_8c <-  scale_fill_manual(values = rev(c(rki$rkihc1, rki$rkihc2 , rki$rkihc3, rki$rkihc4, rki$rkihc5)))
  revrkifill_blue_red_6 <-  scale_fill_manual(values = rev(c(rki$rkihc1, rki$rkihc2 , rki$rkihc3, rki$rkihc7, rki$rkihc8, rki$rkihc9))  )
  revrkifill_blue_red_4 <-  scale_fill_manual(values = rev(c(rki$rkihc1, rki$rkihc2 , rki$rkihc7, rki$rkihc8))  )
  revrkifill_blue_red_4 <-  scale_fill_manual(values = rev(c(rki$rkihc1, rki$rkihc7))  )
  
  revrkicolour_3c <-  scale_colour_manual(values = rev(c(rki$rkihc1, rki$rkihc2 , rki$rkihc3)))
  revrkicolour_4c <-  scale_colour_manual(values = rev(c(rki$rkihc1, rki$rkihc2 , rki$rkihc4, rki$rkihc5)))
  revrkicolour_5c <-  scale_colour_manual(values = rev(c(rki$rkihc1, rki$rkihc2 , rki$rkihc3, rki$rkihc4, rki$rkihc5, rki$rkihc6)))
  revrkicolour_6c <-  scale_colour_manual(values = rev(c(rki$rkihc1, rki$rkihc2 , rki$rkihc3, rki$rkihc4, rki$rkihc5, rki$rkihc6)))
  revrkicolour_8c <-  scale_colour_manual(values = rev(c(rki$rkihc1, rki$rkihc2 , rki$rkihc3, rki$rkihc4, rki$rkihc5)))
  revrkicolour_blue_red_6 <-  scale_colour_manual(values = rev(c(rki$rkihc1, rki$rkihc2 , rki$rkihc3, rki$rkihc7, rki$rkihc8, rki$rkihc9))  )
  revrkicolour_blue_red_4 <-  scale_colour_manual(values = rev(c(rki$rkihc1, rki$rkihc2 , rki$rkihc7, rki$rkihc8))  )
  revrkicolour_blue_red_4 <-  scale_colour_manual(values = rev(c(rki$rkihc1, rki$rkihc7)))  
  
  # Palettes
  rkicpalette <- colorRampPalette(rki$palette12c)
  rkicpalette_blues <- colorRampPalette(rki$palette5blues)
  
  # Main ggplot-Theme
  ###################
  # If "ScalaLF" is not installed "Calibri"  is a viable alternative on a Standard Windows Desktop. 
  # Check available fonts with 
  # library(extrafont)
  # font_import(prompt = FALSE)
  # loadfonts() 
  # View(fonttable())
  
    rkifont_bold  <- "ScalaSansLF-Bold"   # Alternative "Calibri-Bold"
  rkifont_regular <-"ScalaSansLF-Regular" # Alternative "Calibri"
  
  rkitheme  <-   theme(plot.margin = margin(.5, .5, .5, .5, "cm"),
                       text=element_text(family=rki$rkifont_regular, face="plain"),
                       panel.grid.major.x = element_blank(), 
                       panel.grid.major.y = element_line(colour=rki$rkihc6 ) , 
                       panel.background = element_rect(fill=NA),
                       strip.background = element_rect(fill=NA),                   
                       strip.text = element_text(family=rki$rkifont_bold, face="plain",  size = rel(1.1)),
                       plot.title = element_text(family=rki$rkifont_bold, face="plain",  size = rel(1.2)), 
                       axis.title = element_text(family=rki$rkifont_bold, face="plain",  size = rel(1.1)), 
                       axis.text =  element_text(colour="black", size = rel(1.0)),
                       axis.line = element_line(colour="black", size = 0.3 ) ,
                       axis.ticks.length = unit(.25, "cm") ,
                       legend.key = element_blank(),
                       legend.title = element_text(family=rki$rkifont_bold, face="plain",  size = rel(1.0))) 
  
  
  rkitheme_void  <-   theme(plot.margin = margin(.5, .5, .5, .5, "cm"),
                            text=element_text(family=rki$rkifont_regular, face="plain"),
                            panel.grid.major.x = element_blank(), 
                            panel.grid.major.y = element_blank(), 
                            panel.background = element_rect(fill=NA),
                            strip.background = element_rect(fill=NA),                   
                            strip.text = element_text(family=rki$rkifont_bold, face="plain",  size = rel(1.1)),
                            plot.title = element_text(family=rki$rkifont_bold, face="plain",  size = rel(1.2)), 
                            axis.title = element_blank(), 
                            axis.text =  element_blank(),
                            axis.line = element_blank(), 
                            axis.ticks = element_blank(), 
                            legend.key = element_blank(),
                            legend.title = element_text(family=rki$rkifont_bold, face="plain",  size = rel(1.0))) 
  
  # Some Special Functions
  ## Konditional mutation
  mutate_cond <- function(.data, condition, ..., envir = parent.frame()) {
    condition <- eval(substitute(condition), .data, envir)
    .data[condition, ] <- .data[condition, ] %>% mutate(...)
    .data
  }
  
  ## Describe labelled haven Datasets
  describe <- function(dta) { 
    labels <- unlist(sapply(dta, function(x) attr(x, "label")))
    tibble(name = names(labels),
           label = labels)
  }
  
}, envir = rki )

