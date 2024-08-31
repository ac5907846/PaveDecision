# Engineering Economics Functions -----------------------------------------
A_F_convert <- function(i,n){
  output <- i/((1+i)^n-1)
  return (output)
}
P_A_convert <- function(i,n){
  output <- ((1+i)^n-1)/(i*(1+i)^n)
  return (output)
}

# Calculate the total construction cost -----------------------------------
calculate_con_cost <- function(pave1_h, pave2_h, base_h, sbase1_h, sbase2_h,
                               f_pave1_unitcost, f_pave2_unitcost, f_base_unitcost, f_sbase1_unitcost, f_sbase2_unitcost, f_bonding_unitcost,
                               Depth_hc, Depth_hb, Depth_h1,
                               r_pave_unitcost, r_base_unitcost, r_subbase_unitcost, r_long_joint_unitcost, r_tran_joint_unitcost,
                               rebuild_f_pave1, rebuild_f_pave2, rebuild_f_base, rebuild_f_subbase1, rebuild_f_subbase2,
                               rebuild_r_pave, rebuild_r_base, rebuild_r_subbase,
                               lane_width, lane_quantity, road_length, Length_Pave_L){
  
  road_width = lane_width * lane_quantity
  
  # Flexible Cost
  flex_pave1_cost = pave1_h/100 * f_pave1_unitcost * road_width * road_length * 1000
  flex_pave2_cost = pave2_h/100 * f_pave2_unitcost * road_width * road_length * 1000
  flex_base_cost = base_h/100 * f_base_unitcost * road_width * road_length * 1000
  f_sbase1_cost = sbase1_h/100 * f_sbase1_unitcost * road_width * road_length * 1000
  f_sbase2_cost = sbase2_h/100 * f_sbase2_unitcost * road_width * road_length * 1000
  f_bonding1_cost = f_bonding_unitcost * road_width * road_length * 1000
  f_bonding2_cost = f_bonding_unitcost * road_width * road_length * 1000
  flex_cost = flex_pave1_cost + flex_pave2_cost + flex_base_cost + f_sbase1_cost + f_sbase2_cost + f_bonding1_cost + f_bonding2_cost
  # cat("flex_pave1_cost:", flex_pave1_cost, "\n")

  # Rigid Cost
  rigid_pave_cost = Depth_hc/100 * r_pave_unitcost * road_width * road_length * 1000 
  rigid_base_cost = Depth_hb/100 * r_base_unitcost * road_width * road_length * 1000
  rigid_subbase_cost = Depth_h1/100 * r_subbase_unitcost * road_width * road_length * 1000
  rigid_long_joint_cost = r_long_joint_unitcost * (lane_quantity - 1) * road_length * 1000
  rigid_tran_joint_cost = r_tran_joint_unitcost * road_length * 1000 / Length_Pave_L * lane_width * lane_quantity
  rigid_cost = rigid_pave_cost + rigid_base_cost + rigid_subbase_cost + rigid_long_joint_cost + rigid_tran_joint_cost
  
  # Flexible Rebuild Cost
  flex_pave1_cost_rebuild = pave1_h/100 * f_pave1_unitcost * road_width * road_length * 1000 * rebuild_f_pave1
  flex_pave2_cost_rebuild = pave2_h/100 * f_pave2_unitcost * road_width * road_length * 1000 * rebuild_f_pave2
  flex_base_cost_rebuild = base_h/100 * f_base_unitcost * road_width * road_length * 1000 * rebuild_f_base
  f_sbase1_cost_rebuild = sbase1_h/100 * f_sbase1_unitcost * road_width * road_length * 1000 * rebuild_f_subbase1
  f_sbase2_cost_rebuild = sbase2_h/100 * f_sbase2_unitcost * road_width * road_length * 1000 * rebuild_f_subbase2
  f_bonding1_rebuild = f_bonding_unitcost * road_width * road_length * 1000 * rebuild_f_pave1
  f_bonding2_rebuild = f_bonding_unitcost * road_width * road_length * 1000 * rebuild_f_pave2
  flex_cost_rebuild = flex_pave1_cost_rebuild + flex_pave2_cost_rebuild + flex_base_cost_rebuild + f_sbase1_cost_rebuild + f_sbase2_cost_rebuild + f_bonding1_rebuild + f_bonding2_rebuild
  flex_rebuild_count = rebuild_f_pave1 + rebuild_f_pave2 + rebuild_f_base + rebuild_f_subbase1 + rebuild_f_subbase2
  
  # Rigid Rebuild Cost
  rigid_pave_cost_rebuild = Depth_hc/100 * r_pave_unitcost * road_width * road_length * 1000 * rebuild_r_pave
  rigid_base_cost_rebuild = Depth_hb/100 * r_base_unitcost * road_width * road_length * 1000 * rebuild_r_base
  rigid_subbase_cost_rebuild = Depth_h1/100 * r_subbase_unitcost * road_width * road_length * 1000 * rebuild_r_subbase
  rigid_long_joint_cost_rebuild = r_long_joint_unitcost * (lane_quantity - 1) * road_length * 1000 * rebuild_r_pave
  rigid_tran_joint_cost_rebuild = r_tran_joint_unitcost * road_length * 1000 / Length_Pave_L * lane_width * lane_quantity * rebuild_r_pave
  rigid_cost_rebuild = rigid_pave_cost_rebuild + rigid_base_cost_rebuild + rigid_subbase_cost_rebuild + rigid_long_joint_cost_rebuild + rigid_tran_joint_cost_rebuild
  
  rigid_rebuild_count = rebuild_r_pave + rebuild_r_base + rebuild_r_subbase
  
  return(list(
    flex_cost = flex_cost,
    rigid_cost = rigid_cost,
    flex_cost_rebuild = flex_cost_rebuild,
    rigid_cost_rebuild = rigid_cost_rebuild,
    flex_rebuild_count = flex_rebuild_count,
    rigid_rebuild_count = rigid_rebuild_count
  ))
}

###################################
# Find the Middle Value of a Column
###################################
middle_values <- function(column) {
  sorted_column <- sort(column)
  length_column <- length(sorted_column)
  
  if (length_column %% 2 == 1) {
    middle_value <- sorted_column[(length_column + 1) / 2]
  } else {
    middle_value <- sorted_column[length_column / 2]
  }
  
  return(middle_value)
}

# calculate_con_cost(6,8,14,17,18,
#                    76.32, 76.32, 14.84, 13.99, 11.02,
#                    26, 20, 18,
#                    55.11, 14.84, 13.99,
#                    FALSE, FALSE, FALSE, FALSE, FALSE,
#                    FALSE, FALSE, FALSE, 
#                    3.5, 4, 54)
# 
# calculate_con_cost(6,8,14,17,18,
#                    76.32, 76.32, 14.84, 13.99, 11.02,
#                    26, 20, 18,
#                    55.11, 14.84, 13.99,
#                    1, 1, 1, 1, 1,
#                    1, 1, 1, 
#                    3.5, 4, 54)


# Get the quotient of total year and frequency ----------------------------
quotient_year <- function(total_year, freq_year, amount_year){
  if(total_year %% freq_year == 0){
    n_year <- total_year %/% freq_year - 1
    vector_year_construction <- seq(0, total_year - 1, by = freq_year)
    vector_amount_construction <- c(rep(amount_year, n_year + 1))
    vector_year_maintenance <- seq(freq_year, total_year - 1, by = freq_year)
    vector_amount_maintenance <- c(rep(amount_year, n_year))
  } else {
    n_year <- total_year %/% freq_year
    vector_year_construction <- seq(0, total_year, by = freq_year)
    vector_amount_construction <- c(rep(amount_year, n_year + 1))
    vector_year_maintenance <- seq(freq_year, total_year, by = freq_year)
    vector_amount_maintenance <- c(rep(amount_year, n_year))
  }
  return(list(
    n_year = n_year,
    vector_year_construction = vector_year_construction,
    vector_amount_construction = vector_amount_construction,
    vector_year_maintenance = vector_year_maintenance,
    vector_amount_maintenance = vector_amount_maintenance
  ))
}

# ## TEST
# quotient_year(70,14,20000)$n_year


# Calculate cashflow diagram ----------------------------------------------
calculate_cashflow_diagram <- function(f.C,f.M1P,f.M2P,f.M3P,f.na,f.n0,f.n1,f.n2,f.n3,f.ir,
                                       r.C,r.M1P,r.M2P,r.M3P,r.na,r.n0,r.n1,r.n2,r.n3,r.ir,
                                       flex_cost_rebuild, rigid_cost_rebuild,
                                       flex_rebuild_count, rigid_rebuild_count){

  # Calculate Flexible NPV Columns
  f.M1 <- f.C * f.M1P #Maintenance Cost
  f.M2 <- f.C * f.M2P #Minor Rehabilitation Cost
  f.M3 <- f.C * f.M3P #Major Rehabilitation Cost
  
  f.P.rebuild   <- flex_cost_rebuild * A_F_convert(f.ir, f.n0) * P_A_convert(f.ir, quotient_year(f.na, f.n0, 1)$n_year * f.n0) #NPV of Project Construction Cost
  f.P.M1  <- f.M1 * A_F_convert(f.ir, f.n1) * P_A_convert(f.ir, quotient_year(f.na, f.n1, 1)$n_year * f.n1) #NPV of Maintenance Cost
  f.P.M2  <- f.M2 * A_F_convert(f.ir, f.n2) * P_A_convert(f.ir, quotient_year(f.na, f.n2, 1)$n_year * f.n2) #NPV of Minor Rehabilitation Cost
  f.P.M3  <- f.M3 * A_F_convert(f.ir, f.n3) * P_A_convert(f.ir, quotient_year(f.na, f.n3, 1)$n_year * f.n3) #NPV of Major Rehabilitation Cost
  f.NPV   <- f.C + f.P.rebuild + f.P.M1 + f.P.M2 + f.P.M3 #Total NPV
  
  #Calculate Rigid NPV Columns
  r.M1 <- r.C * r.M1P #Maintenance Cost
  r.M2 <- r.C * r.M2P #Minor Rehabilitation Cost
  r.M3 <- r.C * r.M3P #Major Rehabilitation Cost
  
  r.P.rebuild   <- rigid_cost_rebuild * A_F_convert(r.ir, r.n0) * P_A_convert(r.ir, quotient_year(r.na, r.n0, 1)$n_year * r.n0)#NPV of Project Construction Cost
  r.P.M1  <- r.M1 * A_F_convert(r.ir, r.n1) * P_A_convert(r.ir, quotient_year(r.na, r.n1, 1)$n_year * r.n1) #NPV of Maintenance Cost
  r.P.M2  <- r.M2 * A_F_convert(r.ir, r.n2) * P_A_convert(r.ir, quotient_year(r.na, r.n2, 1)$n_year * r.n2) #NPV of Minor Rehabilitation Cost
  r.P.M3  <- r.M3 * A_F_convert(r.ir, r.n3) * P_A_convert(r.ir, quotient_year(r.na, r.n3, 1)$n_year * r.n3) #NPV of Major Rehabilitation Cost
  r.NPV   <- r.C + r.P.rebuild + r.P.M1 + r.P.M2 + r.P.M3 #Total NPV
  
  
  ##########################
  # DATA: CASHFLOW FLEXIBLE
  ##########################
  flex_A_rebuild <- tibble(
    Year = quotient_year(f.na, f.n0, 8)$vector_year_maintenance,
    Amount = quotient_year(f.na, f.n0, 8)$vector_amount_maintenance
  )
  
  flex_A_maintenance <- tibble(
    Year = quotient_year(f.na, f.n1, 2)$vector_year_maintenance,
    Amount = quotient_year(f.na, f.n1, 2)$vector_amount_maintenance
  )
  
  flex_A_minor <- tibble(
    Year = quotient_year(f.na, f.n2, 4)$vector_year_maintenance,
    Amount = quotient_year(f.na, f.n2, 4)$vector_amount_maintenance
  )
  
  flex_A_major <- tibble(
    Year = quotient_year(f.na, f.n3, 6)$vector_year_maintenance,
    Amount = quotient_year(f.na, f.n3, 6)$vector_amount_maintenance
  )
  #######################
  # DATA: CASHFLOW RIGID
  #######################
  rigid_P_rebuild <- tibble(
    Year = quotient_year(r.na, r.n0, 8)$vector_year_maintenance,
    Amount = quotient_year(r.na, r.n0, 8)$vector_amount_maintenance
  )
  
  rigid_A_maintenance <- tibble(
    Year = quotient_year(r.na, r.n1, 2)$vector_year_maintenance,
    Amount = quotient_year(r.na, r.n1, 2)$vector_amount_maintenance
  )
  
  rigid_A_minor <- tibble(
    Year = quotient_year(r.na, r.n2, 4)$vector_year_maintenance,
    Amount = quotient_year(r.na, r.n2, 4)$vector_amount_maintenance
  )
  
  rigid_A_major <- tibble(
    Year = quotient_year(r.na, r.n3, 6)$vector_year_maintenance,
    Amount = quotient_year(r.na, r.n3, 6)$vector_amount_maintenance
  )
  
  
  #####################################
  # PLOT: CASHFLOW FLEXIBLE
  ####################################
  flex_con_cashflow <- ggplot() +
    ylim(-11, 0) +
    geom_point(aes(x = 0, y = 0), size = 5, color = "black") +
    scale_x_continuous(breaks = seq(0, f.na, 5)) +
    labs(title = paste0("Life cycle cost = ", dollar(round(f.NPV, 0), prefix = "$")),
         x = "Year",
         y = "Cash Flow ($)") +
    geom_segment(aes(x = 0, y = 0, xend = f.na + 2, yend = 0),
                 arrow = grid::arrow(length = unit(0.4, "cm")), 
                 size = 2,
                 color = "black") +
    geom_segment(aes(x = 0, y = -2, xend = f.na, yend = -2), linetype ="dashed",
                 size = 1,
                 color = "black") +
    geom_segment(aes(x = 0, y = -4, xend = f.na, yend = -4), linetype ="dashed",
                 size = 1,
                 color = "black") +
    geom_segment(aes(x = 0, y = -6, xend = f.na, yend = -6), linetype ="dashed",
                 size = 1,
                 color = "black") +
    theme(panel.grid.major = element_blank(), 
          panel.grid.minor = element_blank(),
          axis.text.y = element_blank(),
          axis.ticks.y = element_blank(),
          axis.title.y = element_blank(),
          axis.text.x = element_text(size = 15),
          axis.title.x = element_text(size = 15),
          plot.title = element_text(face = "bold", size = 22, color = "#2C71B6")) +
    # Construction
    geom_segment(aes(x = 0, xend = 0, y = 0, yend = -8),
                 arrow = grid::arrow(length = unit(0.5, "cm")),
                 size = 3,
                 color = "#D02B61") +
    geom_label(aes(x = 0,
                   y = -9,
                   label = paste0("Initial Construction: ", dollar(round(f.C/1000, 0), prefix = "$"), suffix ="k")
                   ),
               fill = "#D02B61",
               color = "white",
               size = 7, hjust = 0) +
    # Rebuild
    geom_segment(data = flex_A_rebuild,
                 aes(x = Year, xend = Year, y = -6, yend = -8),
                 arrow = grid::arrow(length = unit(0.5, "cm")),
                 size = 3,
                 color = "#CB09A8") +
    geom_label(aes(x = middle_values(flex_A_rebuild$Year),
                   y = -7,
                   label = paste0("Rebuild: ", dollar(round(flex_cost_rebuild/1000, 0), prefix = "$", suffix ="k"), " / ",f.n0," yrs")
                   ),
               fill = "#AB058D",
               color = "white",
               size = 7) +
    # Maintenance
    geom_segment(data = flex_A_maintenance,
                 aes(x = Year, xend = Year, y = 0, yend = -2),
                 arrow = grid::arrow(length = unit(0.15, "cm")),
                 size = 0.5,
                 color = "black") +
    geom_label(aes(x = middle_values(flex_A_maintenance$Year),
                   y = -1,
                   label = paste0("Maintenance: ", dollar(round(f.M1/1000, 0), prefix = "$", suffix ="k"), " / ",f.n1," yrs")
                   ),
               fill = "black",
               color = "white",
               size = 7) +
    # Minor
    geom_segment(data = flex_A_minor,
                 aes(x = Year, xend = Year, y = -2, yend = -4),
                 arrow = grid::arrow(length = unit(0.25, "cm")),
                 size = 1,
                 color = "#0D9C21") +
    geom_label(aes(x = middle_values(flex_A_minor$Year),
                   y = -3,
                   label = paste0("Minor Repair: ", dollar(round(f.M2/1000, 0), prefix = "$", suffix ="k"), " / ",f.n2," yrs")
                   ),
               fill = "#047609",
               color = "white",
               size = 7) +
    # Major
    geom_segment(data = flex_A_major,
                 aes(x = Year, xend = Year, y = -4, yend = -6),
                 arrow = grid::arrow(length = unit(0.35, "cm")),
                 size = 1.5,
                 color = "blue") +
    geom_label(aes(x = middle_values(flex_A_major$Year),
                   y = -5,
                   label = paste0("Major Repair: ", dollar(round(f.M3/1000, 0), prefix = "$", suffix ="k"), " / ",f.n3," yrs")
                   ),
               fill = "blue",
               color = "white",
               size = 7)
  
  #####################################
  # PLOT: CASHFLOW RIGID
  ####################################
  rigid_con_cashflow <- ggplot() +
    ylim(-11, 0) +
    geom_point(aes(x = 0, y = 0), size = 5, color = "black") +
    scale_x_continuous(breaks = seq(0, r.na, 5)) +
    labs(title = paste0("Life cycle cost = ", dollar(round(r.NPV, 0), prefix = "$")),
         x = "Year",
         y = "Cash Flow ($)") +
    geom_segment(aes(x = 0, y = 0, xend = r.na + 2, yend = 0),
                 arrow = grid::arrow(length = unit(0.4, "cm")), 
                 size = 2,
                 color = "black") +
    geom_segment(aes(x = 0, y = -2, xend = r.na, yend = -2), linetype ="dashed",
                 size = 1,
                 color = "black") +
    geom_segment(aes(x = 0, y = -4, xend = r.na, yend = -4), linetype ="dashed",
                 size = 1,
                 color = "black") +
    geom_segment(aes(x = 0, y = -6, xend = r.na, yend = -6), linetype ="dashed",
                 size = 1,
                 color = "black") +
    theme(panel.grid.major = element_blank(), 
          panel.grid.minor = element_blank(),
          axis.text.y = element_blank(),
          axis.ticks.y = element_blank(),
          axis.title.y = element_blank(),
          axis.text.x = element_text(size = 15),
          axis.title.x = element_text(size = 15),
          plot.title = element_text(face = "bold", size = 22, color = "#2C71B6")) +
    # Construction
    geom_segment(aes(x = 0, xend = 0, y = 0, yend = -8),
                 arrow = grid::arrow(length = unit(0.5, "cm")),
                 size = 3,
                 color = "#D02B61") +
    geom_label(aes(x = 0,
                   y = -9,
                   label = paste0("Initial Construction: ", dollar(round(r.C/1000, 0), prefix = "$", suffix ="k"))
                   ),
               fill = "#D02B61",
               color = "white",
               size = 7, hjust = 0) +
    # Rebuild
    geom_segment(data = rigid_P_rebuild,
                 aes(x = Year, xend = Year, y = -6, yend = -8),
                 arrow = grid::arrow(length = unit(0.5, "cm")),
                 size = 3,
                 color = "#CB09A8") +
    geom_label(aes(x = middle_values(rigid_P_rebuild$Year),
                   y = -7,
                   label = paste0("Rebuild: ", dollar(round(rigid_cost_rebuild/1000, 0), prefix = "$", suffix ="k"), " / ", r.n0, " yrs")
                   ),
               fill = "#AB058D",
               color = "white",
               size = 7) +
    # Maintenance
    geom_segment(data = rigid_A_maintenance,
                 aes(x = Year, xend = Year, y = 0, yend = -2),
                 arrow = grid::arrow(length = unit(0.15, "cm")),
                 size = 0.5,
                 color = "black") +
    geom_label(aes(x = middle_values(rigid_A_maintenance$Year),
                   y = -1,
                   label = paste0("Maintenance: ", dollar(round(r.M1/1000, 0), prefix = "$", suffix ="k"), " / ", r.n1, " yrs")
                   ),
               fill = "black",
               color = "white",
               size = 7) +
    # Minor
    geom_segment(data = rigid_A_minor,
                 aes(x = Year, xend = Year, y = -2, yend = -4),
                 arrow = grid::arrow(length = unit(0.25, "cm")),
                 size = 1,
                 color = "#0D9C21") +
    geom_label(aes(x = middle_values(rigid_A_minor$Year),
                   y = -3,
                   label = paste0("Minor Repair: ", dollar(round(r.M2/1000, 0), prefix = "$", suffix ="k"), " / ", r.n2, " yrs")
                   ),
               fill = "#047609",
               color = "white",
               size = 7) +
    # Major
    geom_segment(data = rigid_A_major,
                 aes(x = Year, xend = Year, y = -4, yend = -6),
                 arrow = grid::arrow(length = unit(0.35, "cm")),
                 size = 1.5,
                 color = "blue") +
    geom_label(aes(x = middle_values(rigid_A_major$Year),
                   y = -5,
                   label = paste0("Major Repair: ", dollar(round(r.M3/1000, 0), prefix = "$", suffix ="k"), " / ", r.n3, " yrs")
                   ),
               fill = "blue",
               color = "white",
               size = 7)
  return(list(
    f.P.M1 = f.P.M1,
    f.P.M2 = f.P.M2,
    f.P.M3 = f.P.M3,
    flex_NPV = f.NPV,
    r.P.M1 = r.P.M1,
    r.P.M2 = r.P.M2,
    r.P.M3 = r.P.M3,
    rigid_NPV = r.NPV,
    flex_con_cashflow = flex_con_cashflow,
    rigid_con_cashflow = rigid_con_cashflow
  ))
}

# # # TEST
# calculate_cashflow_diagram( 22193092.8, 0.0006, 0.05, 0.35, 70, 14, 1, 5, 12, 0.07,
#                             25679980.8, 0.0004, 0.07, 0.45, 70, 30, 1, 9, 20, 0.07,
#                             22193092.8, 25679980.8)
