TrungLuong_MyThuan_inputs <- function(session) {
  observeEvent(session$input$TrungLuong_MyThuan_button, {
    #################
    # Flexible Inputs
    #################
    updateNumericInput(session, "region_Tg", value = 92)
    updateNumericInput(session, "roadGrade", value = 0)
    updateNumericInput(session, "Standard_Load", value = 1)
    updateNumericInput(session, "lane_quantity", value = 4)
    updateNumericInput(session, "lane_width", value = 3.125)
    updateNumericInput(session, "road_length", value = 51.1)
    updateNumericInput(session, "design_year", value = 15)
    updateNumericInput(session, "Total_Axle_Ntk", value = 2243)
    updateNumericInput(session, "Vehicle_Growth_q", value = 0.0915)
    updateNumericInput(session, "Total_Axle_Ne", value = 2498907)
    updateNumericInput(session, "sgrade_Edel", value = 40)
    updateNumericInput(session, "sgrade_cohesion", value = 0.028)
    updateNumericInput(session, "sgrade_phi", value = 21)
    updateNumericInput(session, "Eyc_special", value = 160)
    
    # Bề dày lớp
    updateNumericInput(session, "pave1_h", value = 6)
    updateNumericInput(session, "pave2_h", value = 8)
    updateNumericInput(session, "base_h", value = 13)
    updateNumericInput(session, "sbase1_h", value = 0)
    updateNumericInput(session, "sbase2_h", value = 26)
    
    # Tính về độ võng
    updateNumericInput(session, "pave1_Edel", value = 350)
    updateNumericInput(session, "pave2_Edel", value = 420)
    updateNumericInput(session, "base_Edel", value = 600)
    updateNumericInput(session, "sbase1_Edel", value = 0)
    updateNumericInput(session, "sbase2_Edel", value = 280)
    
    # Tính về trượt
    updateNumericInput(session, "pave1_Ev", value = 250)
    updateNumericInput(session, "pave2_Ev", value = 300)
    updateNumericInput(session, "base_Ev", value = 600)
    updateNumericInput(session, "sbase1_Ev", value = 0)
    updateNumericInput(session, "sbase2_Ev", value = 280)
    
    # Tính về kéo uốn
    updateNumericInput(session, "pave1_Eb", value = 1600)
    updateNumericInput(session, "pave2_Eb", value = 1800)
    updateNumericInput(session, "base_Eb", value = 600)
    updateNumericInput(session, "sbase1_Eb", value = 0)
    updateNumericInput(session, "sbase2_Eb", value = 280)
    
    # Rku
    updateNumericInput(session, "pave1_Rku", value = 2.8)
    updateNumericInput(session, "pave2_Rku", value = 2.8)
    updateNumericInput(session, "base_Rku", value = 0.8)
    
    # Hệ số k3 trang 48
    updateNumericInput(session, "sgrade_k3_v", value = 1.5) # Cohesive soil
    
    ##############
    # Rigid Inputs
    ##############
    updateNumericInput(session, "Depth_hc", value = 29)
    updateNumericInput(session, "Depth_hb", value = 15)
    updateNumericInput(session, "Depth_h1", value = 24)
    
    updateNumericInput(session, "Module_Ec", value = 31000)
    updateNumericInput(session, "Module_Eb", value = 1300)
    updateNumericInput(session, "Module_E1", value = 300)
    
    updateNumericInput(session, "Poisson_mc", value = 0.35)
    updateNumericInput(session, "Poisson_mb", value = 0.6)
    updateNumericInput(session, "Poisson_m1", value = 0.15)
    
    ###########
    # Economics
    ###########
    updateNumericInput(session, "f_pave1_unitcost", value = 124.63)
    updateNumericInput(session, "f_pave2_unitcost", value = 123.73)
    updateNumericInput(session, "f_base_unitcost", value = 26.73)
    updateNumericInput(session, "f_sbase1_unitcost", value = 0)
    updateNumericInput(session, "f_sbase2_unitcost", value = 17.38)
    updateNumericInput(session, "f_bonding_unitcost", value = 0.46)
    
    updateNumericInput(session, "r_pave_unitcost", value = 84.68)
    updateNumericInput(session, "r_base_unitcost", value = 29.64)
    updateNumericInput(session, "r_subbase_unitcost", value = 17.38)
    updateNumericInput(session, "r_long_joint_unitcost", value = 8.93)
    updateNumericInput(session, "r_tran_joint_unitcost", value = 5.85)
    
    updateNumericInput(session, "f.ir", value = 0.10335)
    updateNumericInput(session, "r.ir", value = 0.10335)
    
    updateNumericInput(session, "f.n0", value = 15)
    
    updateTabItems(session, "leftSideBar", "pavement_design_tab")
  })
}