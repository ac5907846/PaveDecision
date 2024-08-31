TCVN2006_example_inputs <- function(session) {
  observeEvent(session$input$TCVN2006_example_button, {
    # Đường cấp II
    updateNumericInput(session, "roadGrade", value = 2)
    # Tải trọng tiêu chuẩn 100 kN
    updateNumericInput(session, "Standard_Load", value = 1)
    # Hệ số f1 của các làn xe trên phần xe chạy, số lane
    updateNumericInput(session, "lane_quantity", value = 4)
    # Trục xe tiêu chuẩn Ntk = 1,637 trục/ngày đêm
    updateNumericInput(session, "Total_Axle_Ntk", value = 1637)
    # Trục xe tiêu chuẩn q = 6%/năm
    updateNumericInput(session, "Vehicle_Growth_q", value = 0.06)
    # Tải trọng xe tích lũy trong 15 năm
    updateNumericInput(session, "Total_Axle_Ne", value = 2160000)
    # Thời gian thiết kế 15 năm
    updateNumericInput(session, "design_year", value = 15)
    # Bề dày lớp
    updateNumericInput(session, "sbase2_h", value = 18)
    updateNumericInput(session, "sbase1_h", value = 17)
    updateNumericInput(session, "base_h", value = 14)
    updateNumericInput(session, "pave2_h", value = 8)
    updateNumericInput(session, "pave1_h", value = 6)
    # Tính về độ võng
    updateNumericInput(session, "sgrade_Edel", value = 42)
    updateNumericInput(session, "sbase2_Edel", value = 250)
    updateNumericInput(session, "sbase1_Edel", value = 300)
    updateNumericInput(session, "base_Edel", value = 600)
    updateNumericInput(session, "pave2_Edel", value = 350)
    updateNumericInput(session, "pave1_Edel", value = 420)
    # Tính về trượt
    updateNumericInput(session, "sbase2_Ev", value = 250)
    updateNumericInput(session, "sbase1_Ev", value = 300)
    updateNumericInput(session, "base_Ev", value = 600)
    updateNumericInput(session, "pave2_Ev", value = 250)
    updateNumericInput(session, "pave1_Ev", value = 300)
    # Tính về kéo uốn
    updateNumericInput(session, "sbase2_Eb", value = 250)
    updateNumericInput(session, "sbase1_Eb", value = 300)
    updateNumericInput(session, "base_Eb", value = 600)
    updateNumericInput(session, "pave2_Eb", value = 1600)
    updateNumericInput(session, "pave1_Eb", value = 1800)
    # Rku
    updateNumericInput(session, "base_Rku", value = 0.8)
    updateNumericInput(session, "pave2_Rku", value = 2.0)
    updateNumericInput(session, "pave1_Rku", value = 2.8)
    # C
    updateNumericInput(session, "sgrade_cohesion", value = 0.032)
    # Phi (độ)
    updateNumericInput(session, "sgrade_phi", value = 24)
    # Hệ số k3 trang 48
    updateNumericInput(session, "sgrade_k3_v", value = 1.5)
    
    updateTabItems(session, "leftSideBar", "pavement_design_tab")
  })
}