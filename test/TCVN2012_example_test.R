TCVN2012_example_inputs <- function(session) {
  observeEvent(session$input$TCVN2012_example_button, {
    # Xác định hệ số co giãn
    updateNumericInput(session, "Expand_ac", value = 10)
    
    updateNumericInput(session, "Largest_Load", value = 180)
    # Đường cấp II
    updateNumericInput(session, "roadGrade", value = 3)
    # Số trục xe quy đổi về trục tiêu chuẩn tích lũy trong thời hạn thiết kết Ne
    updateNumericInput(session, "Total_Axle_Ne", value = 17070000)
    # Trị số gradient nhiệt độ lớn nhất để tính ứng suất nhiệt lớn nhất (Tg)
    updateNumericInput(session, "region_Tg", value = 92)
    # Module Đàn Hồi
    updateNumericInput(session, "Module_Ec", value = 31000) # Tầng Mặt Pavement (Ec) (MPa)
    updateNumericInput(session, "Module_Eb", value = 1300)
    updateNumericInput(session, "Module_E1", value = 300)
    updateNumericInput(session, "sgrade_Edel", value = 45)
    # Hệ số Poisson
    updateNumericInput(session, "Poisson_mc", value = .15)
    updateNumericInput(session, "Poisson_mb", value = .2)
    updateNumericInput(session, "Poisson_m1", value = .35)
    # Chiều dày (m) 
    updateNumericInput(session, "Depth_hc", value = 26)
    updateNumericInput(session, "Depth_hb", value = 20)
    updateNumericInput(session, "Depth_h1", value = 18)
    # Chiều dày tấm bê tông
    updateNumericInput(session, "Length_Pave_L", value = 4.8)
    updateNumericInput(session, "Width_Pave_W", value = 3.5)
    
    updateTabItems(session, "leftSideBar", "pavement_design_tab")
  })
}