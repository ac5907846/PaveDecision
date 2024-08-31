NhaTrang_CamLam_inputs <- function(session) {
  observeEvent(session$input$NhaTrang_CamLam_button, {
    #################
    # Flexible Inputs
    #################
    hide("Eyc_special")
    
    updateNumericInput(session, "region_Tg", value = 89)
    updateNumericInput(session, "roadGrade", value = 0)
    updateNumericInput(session, "Standard_Load", value = 0.55)
    updateNumericInput(session, "lane_quantity", value = 4)
    updateNumericInput(session, "lane_width", value = 3.5)
    updateNumericInput(session, "road_length", value = 49.11)
    updateNumericInput(session, "design_year", value = 15)
    updateNumericInput(session, "Total_Axle_Ntk", value = 2457)
    updateNumericInput(session, "Vehicle_Growth_q", value = 0.1006)
    updateNumericInput(session, "Total_Axle_Ne", value = 2618608)
    updateNumericInput(session, "sgrade_Edel", value = 50)
    updateNumericInput(session, "sgrade_cohesion", value = 0.0278)
    updateNumericInput(session, "sgrade_phi", value = 24)
    updateNumericInput(session, "Eyc_special", value = 0)
    
    # Bề dày lớp
    updateNumericInput(session, "pave1_h", value = 6)
    updateNumericInput(session, "pave2_h", value = 6)
    updateNumericInput(session, "base_h", value = 10)
    updateNumericInput(session, "sbase1_h", value = 18)
    updateNumericInput(session, "sbase2_h", value = 36)
    
    # Tính về độ võng
    updateNumericInput(session, "pave1_Edel", value = 420)
    updateNumericInput(session, "pave2_Edel", value = 420)
    updateNumericInput(session, "base_Edel", value = 320)
    updateNumericInput(session, "sbase1_Edel", value = 600)
    updateNumericInput(session, "sbase2_Edel", value = 275)
    
    # Tính về trượt
    updateNumericInput(session, "pave1_Ev", value = 300)
    updateNumericInput(session, "pave2_Ev", value = 300)
    updateNumericInput(session, "base_Ev", value = 250)
    updateNumericInput(session, "sbase1_Ev", value = 600)
    updateNumericInput(session, "sbase2_Ev", value = 275)
    
    # Tính về kéo uốn
    updateNumericInput(session, "pave1_Eb", value = 1800)
    updateNumericInput(session, "pave2_Eb", value = 1800)
    updateNumericInput(session, "base_Eb", value = 1600)
    updateNumericInput(session, "sbase1_Eb", value = 600)
    updateNumericInput(session, "sbase2_Eb", value = 275)
    
    # Rku
    updateNumericInput(session, "pave1_Rku", value = 2.8)
    updateNumericInput(session, "pave2_Rku", value = 2.0)
    updateNumericInput(session, "base_Rku", value = 1.6)
    
    # Hệ số k3 trang 48
    updateNumericInput(session, "sgrade_k3_v", value = 1.5) # Cohesive soil
    
    ##############
    # Rigid Inputs
    ##############
    updateNumericInput(session, "Depth_hc", value = 32)
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
    updateNumericInput(session, "f_pave1_unitcost", value = 143.65)
    updateNumericInput(session, "f_pave2_unitcost", value = 152.40)
    updateNumericInput(session, "f_base_unitcost", value = 119.72)
    updateNumericInput(session, "f_sbase1_unitcost", value = 21.26)
    updateNumericInput(session, "f_sbase2_unitcost", value = 11.18)
    updateNumericInput(session, "f_bonding_unitcost", value = 0.48)
    
    updateNumericInput(session, "r_pave_unitcost", value = 113.71)
    updateNumericInput(session, "r_base_unitcost", value = 22.32)
    updateNumericInput(session, "r_subbase_unitcost", value = 11.18)
    updateNumericInput(session, "r_long_joint_unitcost", value = 9.90)
    updateNumericInput(session, "r_tran_joint_unitcost", value = 6.03)
    
    updateNumericInput(session, "f.ir", value = 0.12)
    updateNumericInput(session, "r.ir", value = 0.12)
    
    updateNumericInput(session, "f.n0", value = 15)
    
    updateTabItems(session, "leftSideBar", "pavement_design_tab")
  })
}