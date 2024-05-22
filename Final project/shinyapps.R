library(rsconnect)

setwd("~/Desktop/Final project")


rsconnect::setAccountInfo(name='grismaniraula', 
                          token='10D8E367066F8276D2FCC84E1C3B3B6A', 
                          secret='+oDtsFCs8n9XY1LkbVRQPdyfxAL5pTpPk4Myk4IH')

rsconnect::deployApp(appDir  = getwd())
rsconnect::deployApp()
