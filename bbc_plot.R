


bbc_plot <- function(){
  
  font <- "Helvetica"
  
  ggplot2::theme(
    plot.title = ggplot2::element_text(
      family = font
      ,size = 28
      ,face = "bold"
      ,color = "#222222")
    ,plot.subtitle = ggplot2::element_text(
      family = font
      ,size = 22
      ,margin = ggplot2::margin(9, 0, 9, 0))
    ,plot.caption = ggplot2::element_blank()
    ,legend.position = "top"
    ,legend.text.align = 0
    ,legend.background = ggplot2::element_blank()
    ,legend.title = ggplot2::element_blank()
    ,legend.key = ggplot2::element_blank()
    ,legend.text = ggplot2::element_text(
      family = font
      , size = 18
      ,color = "#222222")
    , axis.title = ggplot2::element_blank()
    ,axis.text = ggplot2::element_text(
      family = font
      ,size = 18
      ,color = "#222222")
    ,axis.text.x = ggplot2::element_text(
      margin = ggplot2::margin(5,b = 10))
    ,axis.ticks = ggplot2::element_blank()
    ,axis.line = ggplot2::element_blank()
    ,panel.grid.minor = ggplot2::element_blank()
    ,panel.grid.major.y = ggplot2::element_line(color = "#cbcbcb")
    ,panel.grid.major.x = ggplot2::element_blank()
    ,panel.background = ggplot2::element_blank()
    ,strip.background = ggplot2::element_rect(fill = "white")
    ,strip.text = ggplot2::element_text(size = 22, hjust = 0))
}