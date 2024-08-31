rendergraph31 <- function(graph31_E0_E1,graph31_H_D,graph31,graph31_plot){
  new_x <- graph31_E0_E1
  new_y <- graph31_H_D
  # Interpolate the data to create a grid
  interp_graph31 <- interp_extra(graph31$x_E0_E1, graph31$y_H_D, graph31$Ech_E1, new_x, new_y)
  
  graph31_plot <- graph31_plot +
    geom_point(aes(x = new_x, y = new_y), size = 5, color = "red") +
    geom_label(aes(x = new_x, y = new_y, label = round(interp_graph31, 3)), vjust = -0.5, fill = "pink") +
    geom_segment(aes(x = new_x, y = new_y, xend = 0, yend = new_y), color = "blue", linetype = "dashed") +
    geom_segment(aes(x = new_x, y = new_y, xend = new_x, yend = 0), color = "blue", linetype = "dashed") +
    geom_label(aes(x = new_x, y = 0, label = round(new_x, 3)), vjust = -0.5, fill = "green") +
    geom_label(aes(x = 0, y = new_y, label = round(new_y, 3)), hjust = 1, fill = "green") +
    theme(axis.text.x = element_text(size = 15),
          axis.text.y = element_text(size = 15),
          axis.title.x = element_text(size = 15),
          axis.title.y = element_text(size = 15),
          plot.title = element_text(size = 15))
  return(graph31_plot)
}

rendergraph33 <- function(graph33_H_D,graph33_E1_E2,graph33_Phi,graph33,graph33_plot){
  # Subset graph 33 Phi
  graph33_dfPhi <- graph33[, c("x_H_D_Phi", "y_Phi", "Phi")] %>%
    na.omit()
  
  # Interpolate y of E
  interp_E <- interp_extra(graph33$x_H_D_E, graph33$E, graph33$y_E, graph33_H_D, graph33_E1_E2)
  # Interpolate x of Phi
  interp_Phi <- interp_extra_linear(graph33_dfPhi$Phi, graph33_dfPhi$y_Phi, graph33_dfPhi$x_H_D_Phi, graph33_Phi, interp_E)
  
  graph33_plot <- graph33_plot +
    geom_point(aes(x = graph33_H_D, y = interp_E), size = 3, color = "red") + #intercept between vertical and E
    geom_point(aes(x = interp_Phi, y = interp_E), size = 3, color = "red") + #intercept between vertical and Phi
    geom_label(aes(x = graph33_H_D, y = interp_E, label = round(graph33_E1_E2, 2)), vjust = -0.5, fill = "pink") +
    geom_label(aes(x = interp_Phi, y = interp_E, label = graph33_Phi), vjust = -0.5, fill = "pink") +
    geom_segment(aes(x = graph33_H_D, y = interp_E, xend = graph33_H_D, yend = 0), color = "blue", size = 0.8, linetype = "dashed") + # vertical to E
    geom_segment(aes(x = graph33_H_D, y = interp_E, xend = interp_Phi, yend = interp_E), color = "blue", size = 0.8, linetype = "dashed") + # horizontal to Phi
    geom_segment(aes(x = interp_Phi, y = interp_E, xend = interp_Phi, yend = 0), color = "blue", size = 0.8, linetype = "dashed") + # vertical to x
    geom_label(aes(x = graph33_H_D, y = 0, label = round(graph33_H_D, 3)), fill = "green") +
    geom_label(aes(x = interp_Phi, y = 0, label = round(interp_Phi/100, 4)), fill = "green") +
    theme(axis.text.x = element_text(size = 14),
          axis.text.y = element_blank(),
          axis.title.x = element_text(size = 14)) +
    scale_x_continuous(breaks = seq(0, 4, by = 0.5), 
                       sec.axis = sec_axis(~ . * 0.01,
                                           name="Tax/p",
                                           breaks = seq(0, 0.04, by = 0.005)))
  return(graph33_plot)
}

rendergraph34 <- function(graph34_Htb,graph34_Phi,graph34,graph34_plot){

  # Interpolate for Tav
  graph34_remove0 <- graph34[graph34$y_Tav != 0, ]
  Phi_est <- approx(graph34_remove0$Phi, graph34_remove0$y_Tav, xout = graph34_Phi)$y
  y_Tav_est <- Phi_est/100 * graph34_Htb
  
  graph34_plot <- graph34_plot +
    geom_point(aes(x = graph34_Htb, y = y_Tav_est), size = 3, color = "red") +
    geom_segment(aes(x = 0, y = 0, xend = 100, yend = Phi_est), size = 0.8, linetype = "dashed") + # line to the pink box
    geom_label(aes(x = 100, y = Phi_est, label = graph34_Phi), fill = "pink") +
    geom_segment(aes(x = graph34_Htb, y = y_Tav_est, xend = graph34_Htb, yend = 0), color = "blue", size = 0.8, linetype = "dashed") + # vertical to E
    geom_segment(aes(x = graph34_Htb, y = y_Tav_est, xend = 0, yend = y_Tav_est), color = "blue", size = 0.8, linetype = "dashed") + # vertical to E
    geom_label(aes(x = graph34_Htb, y = 0, label = graph34_Htb), fill = "green") +
    geom_label(aes(x = 0, y = y_Tav_est, label = round(y_Tav_est,5)), hjust = 0, fill = "green") +
    theme(axis.text.x = element_text(size = 14),
          axis.text.y = element_text(size = 14),
          axis.title.x = element_text(size = 14),
          axis.title.y = element_text(size = 14)) +
    scale_x_continuous(breaks = seq(0, 100, by = 20)) +
    scale_y_continuous(breaks = seq(-0.008, 0.004, by = 0.001))
  return(graph34_plot)
}

rendergraph35 <- function(graph35_H_D,graph35_E1_Ech,graph35,graph35_plot){
  
  # Interpolate the data to create a grid
  interp_sigma_z <- interp_extra(graph35$x_H_D, graph35$E1_Ech, graph35$y_sigma, graph35_H_D, graph35_E1_Ech)
  
  graph35_plot <- graph35_plot +
    geom_point(aes(x = graph35_H_D, y = interp_sigma_z), size = 3, color = "red") +
    geom_label(aes(x = graph35_H_D, y = interp_sigma_z, label = round(graph35_E1_Ech, 3)), vjust = -0.5, fill = "pink") +
    geom_segment(aes(x = graph35_H_D, y = interp_sigma_z, xend = 0, yend = interp_sigma_z), color = "blue", size = 0.8, linetype = "dashed") +
    geom_segment(aes(x = graph35_H_D, y = interp_sigma_z, xend = graph35_H_D, yend = 0), color = "blue", size = 0.8, linetype = "dashed") +
    geom_label(aes(x = graph35_H_D, y = 0, label = round(graph35_H_D, 3)), fill = "green") +
    geom_label(aes(x = 0, y = interp_sigma_z, label = round(interp_sigma_z, 3)), fill = "green")
  return(graph35_plot)
}

rendergraph36 <- function(graph36_H_D,graph36_E1_E2,graph36_E2_E3,graph36,graph36_plot){
  
  graph36_dfE2E3 <- graph36[, c("x_E2E3", "y_E2E3", "E2E3")] %>%
    na.omit()
  
  # Interpolate the data to create a grid
  interp_E1E2 <- interp_extra(graph36$x_E1E2, graph36$E1E2, graph36$y_E1E2, graph36_H_D, graph36_E1_E2)
  
  # Interpolate the data to create a grid
  interp_E2E3 <- interp_extra_linear(graph36_dfE2E3$E2E3, graph36_dfE2E3$y_E2E3, graph36_dfE2E3$x_E2E3, graph36_E2_E3, interp_E1E2)
  
  interp_E2E3_real <- interp_E2E3/2
  
  graph36_plot <- graph36_plot +
    geom_point(aes(x = graph36_H_D, y = interp_E1E2), size = 3, color = "red") + #intercept between vertical and E
    geom_point(aes(x = interp_E2E3, y = interp_E1E2), size = 3, color = "red") + #intercept between vertical and E2E3
    geom_label(aes(x = graph36_H_D, y = interp_E1E2, label = round(graph36_E1_E2, 2)), vjust = -0.5, fill = "pink") +
    geom_label(aes(x = interp_E2E3, y = interp_E1E2, label = graph36_E2_E3), vjust = -0.5, fill = "pink") +
    geom_segment(aes(x = graph36_H_D, y = interp_E1E2, xend = graph36_H_D, yend = 0), color = "blue", size = 0.8, linetype = "dashed") + # vertical to E
    geom_segment(aes(x = graph36_H_D, y = interp_E1E2, xend = interp_E2E3, yend = interp_E1E2), color = "blue", size = 0.8, linetype = "dashed") +# horizontal to E2E3
    geom_segment(aes(x = interp_E2E3, y = interp_E1E2, xend = interp_E2E3, yend = 0), color = "blue", size = 0.8, linetype = "dashed") + # vertical to x
    geom_label(aes(x = graph36_H_D, y = 0, label = round(graph36_H_D, 3)), fill = "green") +
    geom_label(aes(x = interp_E2E3, y = 0, label = round(interp_E2E3_real, 3)), fill = "green")
  return(graph36_plot)
}