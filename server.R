# Source the input.R file -------------------------------------------------
source("SV_graph.R")
source("SV_rigid.R")
source("SV_flexible.R")
source("SV_economic.R")
source("test/TCVN2006_example_test.R")
source("test/TCVN2012_example_test.R")
source("test/CamLam_VinhHao.R")
source("test/LongThanh_DauGiay.R")
source("test/NhaTrang_CamLam.R")
source("test/TrungLuong_MyThuan.R")

server <- function(input, output, session) {
  ##########################################
  # BUTTON: TEST TCVN (2006) and TCVN (2012)
  ##########################################
  TCVN2006_example_inputs(session)
  TCVN2012_example_inputs(session)
  CamLam_VinhHao_inputs(session)
  LongThanh_DauGiay_inputs(session)
  NhaTrang_CamLam_inputs(session)
  TrungLuong_MyThuan_inputs(session)
  
  ##########################################
  # BUTTON: CHANGE LANGUAGE
  ##########################################
  
  current_language <- reactiveVal("English")
  
  observeEvent(input$language_Vietnamese, {
    current_language("Vietnamese")
  })
  
  observeEvent(input$language_English, {
    current_language("English")
  })
  
  output$TCVN2006_content <- renderUI({
    if (current_language() == "English") {
      includeHTML("html/TCVN2006_example_test_English.html")
    } else {
      includeHTML("html/TCVN2006_example_test_Vietnamese.html")
    }
  })
  
  output$TCVN2012_content <- renderUI({
    if (current_language() == "English") {
      includeHTML("html/TCVN2012_example_test_English.html")
    } else {
      includeHTML("html/TCVN2012_example_test_Vietnamese.html")
    }
  })
  
  #########################################
  # BUTTON: Update the Total Axle Ne Value
  ########################################
  hide("Total_Axle_Ne")
  observeEvent(input$Total_Axle_Ne_button, {
    toggle("Total_Axle_Ne")
    # Calculate the new value of Total_Axle_Ne_button
    new_Ntt <- calculate_Lane_Ratio_f1(input$lane_quantity) * input$Total_Axle_Ntk
    # Calculate q
    new_q <- input$Vehicle_Growth_q
    # Calculate t
    new_t <- input$design_year
    # Calculate Ne
    new_Ne <- ((1+new_q)^new_t-1)/new_q/(1+new_q)^(new_t-1)*365*new_Ntt
    # Update the value of Total_Axle_Ne_button
    updateNumericInput(session, "Total_Axle_Ne", value = new_Ne)
  })
  #########################################
  # BUTTON: Display the Eyc
  ########################################
  hide("Eyc_special")
  observeEvent(input$Eyc_special_button, {
    toggle("Eyc_special")
  })
  
  ########################
  # FUNCTION: Check RIGID
  ########################
  check_Rigid <- reactive({
    Standard_Load <- input$Standard_Load
    Standard_Load <- as.numeric(Standard_Load)
    roadGrade <- input$roadGrade
    roadGrade <- as.numeric(roadGrade)
    Expand_ac <- input$Expand_ac
    Expand_ac <- as.numeric(Expand_ac)
    region_Tg <- input$region_Tg
    region_Tg <- as.numeric(region_Tg)
    check_Rigid <- check_Rigid_Function(input$Depth_h1,input$Module_E1,input$sgrade_Edel,input$Module_Ec,
                                        input$Depth_hc,input$Poisson_mc,input$Module_Eb,input$Depth_hb,
                                        input$Poisson_mb,Standard_Load,input$Largest_Load,
                                        roadGrade,input$Length_Pave_L,Expand_ac,
                                        region_Tg,input$Total_Axle_Ne)
    return(check_Rigid)
  })
  
  #####################################
  # OUTPUT: Check rigid STANDARD stress
  #####################################
  output$check_rigid_standard_stress_result <- renderText({
    if(check_Rigid()$check_standard == " (OK)"){
      return(paste0("<span style=\"color:green\">Actual Stress: γ<sub>r</sub>(σ<sub>pr</sub> + σ<sub>tr</sub>) = ",
                    round(check_Rigid()$actual_bending_standard_load,3),
                    check_Rigid()$check_standard_sign,
                    " Design Stress: f<sub>r</sub> = ",
                    check_Rigid()$fr,
                    check_Rigid()$check_standard))
    }else{
      return(paste0("<span style=\"color:red\">Actual Stress: γ<sub>r</sub>(σ<sub>pr</sub> + σ<sub>tr</sub>) = ",
                    round(check_Rigid()$actual_bending_standard_load,3),
                    check_Rigid()$check_standard_sign,
                    " Design Stress f<sub>r</sub> = ",
                    check_Rigid()$fr,
                    check_Rigid()$check_standard))
    }
  })
  
  #####################################
  # OUTPUT: Check rigid LARGEST stress
  #####################################
  output$check_rigid_largest_stress_result <- renderText({
    if(check_Rigid()$check_largest == " (OK)"){
      return(paste0("<span style=\"color:green\">Actual Stress: γ<sub>r</sub>(σ<sub>pmax</sub> + σ<sub>tmax</sub>) = ",
                    round(check_Rigid()$actual_bending_largest_load,3),
                    check_Rigid()$check_largest_sign,
                    " Design Stress f<sub>r</sub> = ",
                    check_Rigid()$fr,
                    check_Rigid()$check_largest))
    }else{
      return(paste0("<span style=\"color:red\">Actual Stress: γ<sub>r</sub>(σ<sub>pmax</sub> + σ<sub>tmax</sub>) = ",
                    round(check_Rigid()$actual_bending_largest_load,3),
                    check_Rigid()$check_largest_sign,
                    " Design Stress f<sub>r</sub> = ",
                    check_Rigid()$fr,
                    check_Rigid()$check_largest))
    }
  })
  
  ###########################
  # FUNCTION: Check flexible
  ###########################
  check_Flexible <- reactive({
    sbase2_h <- input$sbase2_h
    sbase1_h <- input$sbase1_h
    base_h <- input$base_h
    pave2_h <- input$pave2_h
    pave1_h <- input$pave1_h
    sgrade_Edel <- input$sgrade_Edel
    sbase2_Edel <- input$sbase2_Edel
    sbase1_Edel <- input$sbase1_Edel
    base_Edel <- input$base_Edel
    pave2_Edel <- input$pave2_Edel
    pave1_Edel <- input$pave1_Edel
    sbase2_Ev <- input$sbase2_Ev
    sbase1_Ev <- input$sbase1_Ev
    base_Ev <- input$base_Ev
    pave2_Ev <- input$pave2_Ev
    pave1_Ev <- input$pave1_Ev
    sbase2_Eb <- input$sbase2_Eb
    sbase1_Eb <- input$sbase1_Eb
    base_Eb <- input$base_Eb
    pave2_Eb <- input$pave2_Eb
    pave1_Eb <- input$pave1_Eb
    base_Rku <- input$base_Rku
    pave2_Rku <- input$pave2_Rku
    pave1_Rku <- input$pave1_Rku
    sgrade_cohesion <- input$sgrade_cohesion
    sgrade_phi <- input$sgrade_phi
    
    design_year <- input$design_year
    Total_Axle_Ntk <- input$Total_Axle_Ntk
    Total_Axle_Ne <- input$Total_Axle_Ne
    lane_quantity <- input$lane_quantity
    
    roadGrade <- input$roadGrade
    roadGrade <- as.numeric(roadGrade)
    
    Standard_Load <- input$Standard_Load
    Standard_Load <- as.numeric(Standard_Load)
    
    sgrade_k3_v <- input$sgrade_k3_v
    sgrade_k3_v <- as.numeric(sgrade_k3_v)
    
    Eyc_special <- input$Eyc_special
    
    check_Flexible <- check_Flexible_Function(sbase2_h,sbase1_h,base_h,pave2_h,pave1_h,
                                              sgrade_Edel,sbase2_Edel,sbase1_Edel,base_Edel,pave2_Edel,pave1_Edel,
                                              sbase2_Ev,sbase1_Ev,base_Ev,pave2_Ev,pave1_Ev,
                                              sbase2_Eb,sbase1_Eb,base_Eb,pave2_Eb,pave1_Eb,
                                              base_Rku,pave2_Rku,pave1_Rku,
                                              sgrade_cohesion,
                                              sgrade_phi,
                                              Standard_Load,
                                              roadGrade,
                                              design_year,
                                              Total_Axle_Ntk,
                                              Total_Axle_Ne,
                                              lane_quantity,
                                              sgrade_k3_v,
                                              graph31, graph33, graph34, graph35, graph36,
                                              Eyc_special)
    
    return(check_Flexible)
  })
  
  ################################################
  # OUTPUT: Check Deflection of Flexible Pavement
  ###############################################
  output$check_flexible_deflection_result <- renderText({
    if(check_Flexible()$check_deflection == " (OK)"){
      return(paste0("<span style=\"color:green\">Actual: K<sub>dv_cd</sub> * E<sub>yc</sub> = ",
                    round(check_Flexible()$Kdv_cd_Eyc_del,3),
                    check_Flexible()$check_deflection_sign,
                    " Design: E<sub>ch</sub> = ",
                    round(check_Flexible()$Ech_del,3),
                    check_Flexible()$check_deflection))
    }else{
      return(paste0("<span style=\"color:red\">Actual: K<sub>dv_cd</sub> * E<sub>yc</sub> = ",
                    round(check_Flexible()$Kdv_cd_Eyc_del,3),
                    check_Flexible()$check_deflection_sign,
                    " Design: E<sub>ch</sub> = ",
                    round(check_Flexible()$Ech_del,3),
                    check_Flexible()$check_deflection))
    }
  })
  
  ##########################################
  # OUTPUT: Check Shear of Flexible Pavement
  ##########################################
  output$check_flexible_shear_result <- renderText({
    if(check_Flexible()$check_shear == " (OK)"){
      return(paste0("<span style=\"color:green\">Actual: T<sub>ax</sub> + T<sub>av</sub> = ",
                    round(check_Flexible()$Tax_Tav_v,4),
                    check_Flexible()$check_shear_sign,
                    " Design: C<sub>tt</sub>/k<sub>tr_cd</sub> = ",
                    round(check_Flexible()$Ctt_Ktr_cd_v,3),
                    check_Flexible()$check_shear))
    }else{
      return(paste0("<span style=\"color:red\">Actual: T<sub>ax</sub> + T<sub>av</sub> = ",
                    round(check_Flexible()$Tax_Tav_v,3),
                    check_Flexible()$check_shear_sign,
                    " Design: C<sub>tt</sub>/k<sub>tr_cd</sub> = ",
                    round(check_Flexible()$Ctt_Ktr_cd_v,3),
                    check_Flexible()$check_shear))
    }
  })
  
  ########################################################
  # OUTPUT: Check Bending of Bottom Asphalt Layer (Pave2)
  ########################################################
  output$check_flexible_bending_pave2_result <- renderText({
    if(check_Flexible()$check_bending_pave2 == " (OK)"){
      return(paste0("<span style=\"color:green\">Actual: φ<sub>ku</sub> = ",
                    round(check_Flexible()$phi_ku_pave2,3),
                    check_Flexible()$check_bending_pave2_sign,
                    " Design: R<sub>ku_tt</sub>/K<sub>ku_cd</sub> = ",
                    round(check_Flexible()$design_bending_pave2,3),
                    check_Flexible()$check_bending_pave2))
    }else{
      return(paste0("<span style=\"color:red\">Actual: φ<sub>ku</sub> = ",
                    round(check_Flexible()$phi_ku_pave2,3),
                    check_Flexible()$check_bending_pave2_sign,
                    " Design: R<sub>ku_tt</sub>/K<sub>ku_cd</sub> = ",
                    round(check_Flexible()$design_bending_pave2,3),
                    check_Flexible()$check_bending_pave2))
    }
  })
  
  #######################################################
  # OUTPUT: Check Bending of Bottom Asphalt Layer (Pave1)
  #######################################################
  output$check_flexible_bending_pave1_result <- renderText({
    if(check_Flexible()$check_bending_pave1 == " (OK)"){
      return(paste0("<span style=\"color:green\">Actual: φ<sub>ku</sub> = ",
                    round(check_Flexible()$phi_ku_pave1,3),
                    check_Flexible()$check_bending_pave1_sign,
                    " Design: R<sub>ku_tt</sub>/K<sub>ku_cd</sub> = ",
                    round(check_Flexible()$design_bending_pave1,3),
                    check_Flexible()$check_bending_pave1))
    }else{
      return(paste0("<span style=\"color:red\">Actual: φ<sub>ku</sub> = ",
                    round(check_Flexible()$phi_ku_pave1,3),
                    check_Flexible()$check_bending_pave1_sign,
                    " Design: R<sub>ku_tt</sub>/K<sub>ku_cd</sub> = ",
                    round(check_Flexible()$design_bending_pave1,3),
                    check_Flexible()$check_bending_pave1))
    }
  })
  ######################################
  # OUTPUT: Check Bending of Base Layer
  ######################################
  output$check_flexible_bending_base_result <- renderText({
    if(check_Flexible()$check_bending_base == " (OK)"){
      return(paste0("<span style=\"color:green\">Actual: φ<sub>ku</sub> = ",
                    round(check_Flexible()$phi_ku_base,3),
                    check_Flexible()$check_bending_base_sign,
                    " Design: R<sub>ku_tt</sub>/K<sub>ku_cd</sub> = ",
                    round(check_Flexible()$design_bending_base,3),
                    check_Flexible()$check_bending_base))
    }else{
      return(paste0("<span style=\"color:red\">Actual: φ<sub>ku</sub> = ",
                    round(check_Flexible()$phi_ku_base,3),
                    check_Flexible()$check_bending_base_sign,
                    " Design: R<sub>ku_tt</sub>/K<sub>ku_cd</sub> = ",
                    round(check_Flexible()$design_bending_base,3),
                    check_Flexible()$check_bending_base))
    }
  })
  
  ###############################
  # OUTPUT: the Construction Cost
  ###############################
  total_con_cost <- reactive({
    total_con_cost <- calculate_con_cost(input$pave1_h, input$pave2_h, input$base_h, input$sbase1_h, input$sbase2_h,
                                         input$f_pave1_unitcost, input$f_pave2_unitcost, input$f_base_unitcost, input$f_sbase1_unitcost, input$f_sbase2_unitcost, input$f_bonding_unitcost,
                                         input$Depth_hc, input$Depth_hb, input$Depth_h1,
                                         input$r_pave_unitcost, input$r_base_unitcost, input$r_subbase_unitcost, input$r_long_joint_unitcost, input$r_tran_joint_unitcost,
                                         input$rebuild_f_pave1, input$rebuild_f_pave2, input$rebuild_f_base, input$rebuild_f_subbase1, input$rebuild_f_subbase2,
                                         input$rebuild_r_pave, input$rebuild_r_base, input$rebuild_r_subbase,
                                         input$lane_width, input$lane_quantity, input$road_length, input$Length_Pave_L)
    return(total_con_cost)
  })
  
  cashflow_diagram <- reactive({
    cashflow_diagram <- calculate_cashflow_diagram(total_con_cost()$flex_cost, input$f.M1P, input$f.M2P, input$f.M3P, input$f.na, input$f.n0, input$f.n1, input$f.n2, input$f.n3, input$f.ir,
                                                   total_con_cost()$rigid_cost, input$r.M1P, input$r.M2P, input$r.M3P, input$r.na, input$r.n0, input$r.n1, input$r.n2, input$r.n3, input$r.ir,
                                                   total_con_cost()$flex_cost_rebuild, total_con_cost()$rigid_cost_rebuild,
                                                   total_con_cost()$flex_rebuild_count, total_con_cost()$rigid_rebuild_count)
    return(cashflow_diagram)
  })
  
  ###################################
  # OUTPUT: Initial Construction Cost
  ###################################
  output$total_con_cost_flex_result <- renderText({
    return(dollar(round(total_con_cost()$flex_cost, 0), prefix = "$"))
  })
  
  output$total_con_cost_rigid_result <- renderText({
    return(dollar(round(total_con_cost()$rigid_cost, 0), prefix = "$"))
  })
  
  # Percent different between two
  output$different_con_cost_result <- renderText({
    different_con_cost <- (total_con_cost()$rigid_cost - total_con_cost()$flex_cost)/total_con_cost()$rigid_cost * 100
    return(paste0("Percent Different: ", round(different_con_cost, 2),"%"))
  })
  
  #######################
  # OUTPUT: Rebuild Cost
  #######################
  output$total_rebuild_cost_flex_result <- renderText({
    return(dollar(round(total_con_cost()$flex_cost_rebuild, 0), prefix = "$"))
  })
  
  output$total_rebuild_cost_rigid_result <- renderText({
    return(dollar(round(total_con_cost()$rigid_cost_rebuild, 0), prefix = "$"))
  })
  
  #########################
  # OUTPUT: Life Cycle Cost
  #########################
  output$life_cost_flex_result <- renderText({
    return(dollar(round(cashflow_diagram()$flex_NPV, 0), prefix = "$"))
  })
  
  output$life_cost_rigid_result <- renderText({
    return(dollar(round(cashflow_diagram()$rigid_NPV, 0), prefix = "$"))
  })
  
  # Percent different between two
  output$different_life_cost_result <- renderText({
    different_life_cost <- (cashflow_diagram()$rigid_NPV - cashflow_diagram()$flex_NPV)/cashflow_diagram()$rigid_NPV * 100
    return(paste0("Percent Different: ", round(different_life_cost, 2),"%"))
  })

  ###############################################
  # OUTPUT: Draw cash flow diagram rigid pavement
  ###############################################
  output$rigid_cashflow_output <- renderPlot({
    return(cashflow_diagram()$rigid_con_cashflow)
  })
  
  #####################################################
  # OUTPUT: Draw cash flow diagram flexibility pavement
  #####################################################
  output$flex_cashflow_output <- renderPlot({
    return(cashflow_diagram()$flex_con_cashflow)
  })
  
  ########################
  # OUTPUT: Draw graph 3.1
  ########################
  output$graph31 <- renderPlot({
    if (!is.numeric(input$graph31_E0_E1) || !is.numeric(input$graph31_H_D)) {
      return(NULL)
    } else {
      rendergraph31(input$graph31_E0_E1,input$graph31_H_D,graph31,graph31_plot)
    }
  })
  
  ########################
  # OUTPUT: Draw graph 3.3
  ########################
  output$graph33 <- renderPlot({
    if (!is.numeric(input$graph33_H_D) || !is.numeric(input$graph33_E1_E2) || !is.numeric(input$graph33_Phi)) {
      return(NULL)
    } else {
      rendergraph33(input$graph33_H_D,input$graph33_E1_E2,input$graph33_Phi,graph33,graph33_plot)
    }
  })
  
  ########################
  # OUTPUT: Draw graph 3.4
  ########################
  output$graph34 <- renderPlot({
    if (!is.numeric(input$graph34_Htb) || !is.numeric(input$graph34_Phi)) {
      return(NULL)
    } else {
      rendergraph34(input$graph34_Htb,input$graph34_Phi,graph34,graph34_plot)
    }
  })
  
  ########################
  # OUTPUT: Draw graph 3.5
  ########################
  output$graph35 <- renderPlot({
    if (!is.numeric(input$graph35_H_D) || !is.numeric(input$graph35_E1_Ech)) {
      return(NULL)
    } else {
      rendergraph35(input$graph35_H_D,input$graph35_E1_Ech,graph35,graph35_plot)
    }
  })
  
  ########################
  # OUTPUT: Draw graph 3.6
  ########################
  output$graph36 <- renderPlot({
    if (!is.numeric(input$graph36_H_D) || !is.numeric(input$graph36_E1_E2) || !is.numeric(input$graph36_E2_E3)) {
      return(NULL)
    } else {
      rendergraph36(input$graph36_H_D,input$graph36_E1_E2,input$graph36_E2_E3,graph36,graph36_plot)
    }
  })
  
}