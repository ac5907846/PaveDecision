################################################################################
#Tính Etb trung bình
################################################################################
Etrbinh <- function(E1, E2, E3, E4, E5,
                    h1, h2, h3, h4, h5){
  # Htb
  Htb1 = h1
  Htb2 = h2+Htb1
  Htb3 = h3+Htb2
  Htb4 = h4+Htb3
  Htb5 = h5+Htb4
  
  # k
  k2 = h2/Htb1
  k3 = h3/Htb2
  k4 = h4/Htb3
  k5 = h5/Htb4
  
  # t & Etb
  Etb1 = E1
  
  t2 = E2/Etb1
  Etb2 = Etb1*((1+k2*t2^(1/3))/(1+k2))^3
  
  t3 = E3/Etb2
  Etb3 = Etb2*((1+k3*t3^(1/3))/(1+k3))^3
  
  t4 = E4/Etb3
  Etb4 = Etb3*((1+k4*t4^(1/3))/(1+k4))^3
  
  t5 = E5/Etb4
  Etb5 = Etb4*((1+k5*t5^(1/3))/(1+k5))^3
  
  return(list(
    Etb1 = Etb1,
    Etb2 = Etb2,
    Etb3 = Etb3,
    Etb4 = Etb4,
    Etb5 = Etb5,
    
    Htb1 = Htb1,
    Htb2 = Htb2,
    Htb3 = Htb3,
    Htb4 = Htb4,
    Htb5 = Htb5
  ))
}

# TEST
# Etrbinh(250,300,600,1600,1800,18,17,14,8,6)

################################################################################
# Interpolation function
################################################################################
interpolate_func <- function(x, y, new_x) {
  approx(x, y, xout = new_x)$y
}

################################################################################
# Extrapolation performs linear extrapolation for out-of-range values
################################################################################
extrapolate_func <- function(x, y, new_x) {
  if (new_x < min(x)) {
    idx <- which.min(x)
    slope <- (y[idx + 1] - y[idx]) / (x[idx + 1] - x[idx])
    y_new <- y[idx] - slope * (x[idx] - new_x)
  } else if (new_x > max(x)) {
    idx <- which.max(x)
    slope <- (y[idx] - y[idx - 1]) / (x[idx] - x[idx - 1])
    y_new <- y[idx] + slope * (new_x - x[idx])
  } else {
    y_new <- approx(x, y, xout = new_x)$y
  }
  return(y_new)
}
# # Test
# hd_values <- c(0.5, 0.75, 1, 1.25, 1.5, 1.75, 2)
# beta_values <- c(1.033, 1.069, 1.107, 1.136, 1.178, 1.198, 1.21)
# # Calculate beta
# extrapolate_func(hd_values, beta_values, 0.25)
# interpolate_func(hd_values, beta_values, 0.25)

################################################################################
# Interp of AKIMA library extrapolation (LINEAR)
################################################################################
interp_extra_linear <- function(x, y, z, new_x, new_y) {
  # Limit new_x and new_y to the range of x and y
  new_x_limited <- max(min(new_x, max(x)), min(x))
  new_y_limited <- max(min(new_y, max(y)), min(y))
  
  # cat("new_x_limited", new_x_limited, "\n")
  # cat("new_y_limited", new_y_limited, "\n")
  
  grid <- interp(x, y, z, xo = new_x_limited, yo = new_y_limited, linear = TRUE, extrap = TRUE)
  return(grid$z[1, 1])
}
################################################################################
# Interp of AKIMA library extrapolation
################################################################################
interp_extra <- function(x, y, z, new_x, new_y) {
  # Limit new_x and new_y to the range of x and y
  new_x_limited <- max(min(new_x, max(x)), min(x))
  new_y_limited <- max(min(new_y, max(y)), min(y))
  
  # cat("new_x_limited", new_x_limited, "\n")
  # cat("new_y_limited", new_y_limited, "\n")
  
  grid <- interp(x, y, z, xo = new_x_limited, yo = new_y_limited, linear = FALSE, extrap = TRUE)
  return(grid$z[1, 1])
}

################################################################################
# Calculate f1 value based on quantity of lane
################################################################################
calculate_Lane_Ratio_f1 <- function(lane_quantity){
  if(lane_quantity == 1){
    return(1)
  }else if(lane_quantity == 2 || lane_quantity == 3){
    return(0.55)
  }else if(lane_quantity == 4 || lane_quantity == 5){
    return(0.35)
  }else{
    return(0.3)
  }
}
# calculate_Lane_Ratio_f1(6)

################################################################################
# CHECK FLEXIBLE DESIGN
################################################################################
check_Flexible_Function <- function(sbase2_h, sbase1_h, base_h, pave2_h, pave1_h,
                                    sgrade_Edel, sbase2_Edel, sbase1_Edel, base_Edel, pave2_Edel, pave1_Edel,
                                    sbase2_Ev, sbase1_Ev, base_Ev, pave2_Ev, pave1_Ev,
                                    sbase2_Eb, sbase1_Eb, base_Eb, pave2_Eb, pave1_Eb,
                                    base_Rku, pave2_Rku, pave1_Rku,
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
                                    Eyc_special){
  
  ##################### TÍNH ĐỘ VÕNG
  Etb_del <- Etrbinh(sbase2_Edel,sbase1_Edel,base_Edel,pave2_Edel,pave1_Edel,
                    sbase2_h,sbase1_h,base_h,pave2_h,pave1_h)
  
  # Đường kính vệt bánh xe D
  if(Standard_Load == 1){
    D = 33
  }else{
    D = 36
  }
  
  # Calculate H/D
  H_D = Etb_del$Htb5/D
  
  
  # #TEST TEST TEST TEST TEST TESTTEST TEST TESTTEST TEST TESTTEST TEST TESTTEST TEST TESTTEST TEST TESTTEST TEST TEST
  # cat("H_D:", H_D, "\n")
  # #TEST TEST TEST TEST TEST TESTTEST TEST TESTTEST TEST TESTTEST TEST TESTTEST TEST TESTTEST TEST TESTTEST TEST TEST
  
  # Tỉ số H/D
  hd_values <- c(0.5, 0.75, 1, 1.25, 1.5, 1.75, 2)
  beta_values <- c(1.033, 1.069, 1.107, 1.136, 1.178, 1.198, 1.21)
  
  # Calculate beta
  beta <- extrapolate_func(hd_values, beta_values, H_D)
  
  # Calculate other variables
  Edctb_del = beta * Etb_del$Etb5
  E0del_Edctb_del = sgrade_Edel/Edctb_del
  
  # Toán đồ 3.1
  interp_graph31 <- interp_extra(graph31$x_E0_E1, graph31$y_H_D, graph31$Ech_E1, E0del_Edctb_del, H_D)
  
  Ech_E1_del = interp_graph31
  
  Ech_del <- interp_graph31 * Edctb_del
  
  # Bàng 2-1 Chọn tầng mặt
  if(roadGrade < 5 & (design_year >= 10 | Total_Axle_Ne > 4e+06)){
    pave1_grade = "Grade A1"
  }else if((roadGrade < 5 | roadGrade > 2) & ((design_year < 10 & design_year > 4) | (Total_Axle_Ne > 1e+5 & Total_Axle_Ne < 2e+6 ))){
    pave1_grade = "Grade A2"
  }else if((roadGrade > 3) & ((design_year < 4 & design_year > 2) | Total_Axle_Ne <= 1e+5)){
    pave1_grade = "Grade B1"
  }else{
    pave1_grade = "Grade B2"
  }
  
  #Bảng 3-4 Trị số module đàn hồi yêu cầu
  table34_Ntt <- c(10,20,50,100,200,500,1000,2000,5000,7000)
  
  table34_10A1 <- c(0,0,133,147,160,178,192,207,224,235)
  table34_10A2 <- c(0,91,110,122,135,153,153,153,153)
  table34_10B1 <- c(0,64,82,94,94,94,94,94,94,94)
  
  table34_12A1 <- c(0,127,146,161,173,190,204,218,235,253)
  table34_12A2 <- c(90,103,120,133,145,163,163,163,163,163)
  table34_12B1 <- c(0,79,98,111,111,111,111,111,111,111)
  
  #Bảng 3-5 Trị số tối thiểu module đàn hồi yêu cầu (MPa)
  table35_roadGrade <- c(0, 1, 2, 3, 4, 5)
  table35_A1 <- c(180, 180, 160, 140, 130, NA)
  table35_A2 <- c(NA, NA, NA, 120, 100, 80)
  table35_B1 <- c(NA, NA, NA, NA, 75, NA)
  table35 <- data.frame(table35_roadGrade, table35_A1, table35_A2, table35_B1)
  
  # Find the values Eyc
  Total_Axle_Ntt = Total_Axle_Ntk * calculate_Lane_Ratio_f1(lane_quantity)
  
  if(Standard_Load == 1 & pave1_grade == "Grade A1"){
    
    Eyc_del = max(extrapolate_func(table34_Ntt, table34_10A1, Total_Axle_Ntt),table35$table35_A1[table35$table35_roadGrade == roadGrade])
    
  }else if(Standard_Load == 1 & pave1_grade == "Grade A2"){
    
    Eyc_del = max(extrapolate_func(table34_Ntt, table34_10A2, Total_Axle_Ntt),table35$table35_A2[table35$table35_roadGrade == roadGrade])
    
  }else if(Standard_Load == 1 & pave1_grade == "Grade B1"){
    
    Eyc_del = max(extrapolate_func(table34_Ntt, table34_10B1, Total_Axle_Ntt),table35$table35_B1[table35$table35_roadGrade == roadGrade])
    
  }else if(Standard_Load == 0.55 & pave1_grade == "Grade A1"){
    
    Eyc_del = max(extrapolate_func(table34_Ntt, table34_12A1, Total_Axle_Ntt),table35$table35_A1[table35$table35_roadGrade == roadGrade])
    
  }else if(Standard_Load == 0.55 & pave1_grade == "Grade A2"){
    
    Eyc_del = max(extrapolate_func(table34_Ntt, table34_12A2, Total_Axle_Ntt),table35$table35_A2[table35$table35_roadGrade == roadGrade])
    
  }else{
    
    Eyc_del = max(extrapolate_func(table34_Ntt, table34_12B1, Total_Axle_Ntt),table35$table35_B1[table35$table35_roadGrade == roadGrade])
    
  }
  
  if(Eyc_special !=	0){
    Eyc_del = Eyc_special
  }
  
  # Find the values Kdv_cd from table 3.3
  if(roadGrade < 3){
    Kdv_cd_del = 1.17
  }else if(roadGrade == 3 | roadGrade == 4){
    Kdv_cd_del = 1.1
  }else{
    Kdv_cd_del =  1.06
  }
  
  Kdv_cd_Eyc_del = Kdv_cd_del * Eyc_del

  # Check deflection
  if (Ech_del >= Kdv_cd_Eyc_del){
    check_deflection = " (OK)"
    check_deflection_sign = " ≤"
  }else{
    check_deflection = " (NOT OK)"
    check_deflection_sign = " ≥"
  }
  
  ##################### TÍNH ĐỘ TRƯỢT
  Etb_v <- Etrbinh(sbase2_Ev,sbase1_Ev,base_Ev,pave2_Ev,pave1_Ev,
                   sbase2_h,sbase1_h,base_h,pave2_h,pave1_h)
  
  # Calculate other variables
  Edctb_v = beta * Etb_v$Etb5
  Etb_E0_v = Edctb_v/sgrade_Edel
  
  # Interpolate y of E
  interp_graph33_E <- interp_extra(graph33$x_H_D_E, graph33$E, graph33$y_E, H_D, Etb_E0_v)

  # Subset graph 33 Phi
  graph33_dfPhi <- graph33[, c("x_H_D_Phi", "y_Phi", "Phi")] %>%
    na.omit()
  
  # Interpolate x of Phi
  interp_graph33_Phi <- interp_extra_linear(graph33_dfPhi$Phi, graph33_dfPhi$y_Phi, graph33_dfPhi$x_H_D_Phi,sgrade_phi,interp_graph33_E)
  
  Tax_p_v = interp_graph33_Phi/100
  Tax_v = Tax_p_v * 0.6

  # Interpolate for Tav
  # interp_graph34 <- interp_extra_linear(graph34$x_Htb, graph34$Phi, graph34$y_Tav,Etb_v$Htb5, sgrade_phi)
  
  graph34_remove0 <- graph34[graph34$y_Tav != 0, ]
  Phi_est <- approx(graph34_remove0$Phi, graph34_remove0$y_Tav, xout = sgrade_phi)$y
  y_Tav_est <- Phi_est/100 * Etb_v$Htb5

  Tav_v = y_Tav_est
  
  # Chọn kết cấu là phần đường xe chạy
  k1_v = 0.6
  
  # Tra bảng 3.8
  if(Total_Axle_Ntt < 100){
    k2_v = 1
  }else if(Total_Axle_Ntt < 1000 & Total_Axle_Ntt >= 100){
    k2_v = 0.8
  }else if(Total_Axle_Ntt < 5000 & Total_Axle_Ntt >= 1000){
    k2_v = 0.65
  }else{
    k2_v = 0.6
  }
  
  # Trị số Ctt
  Ctt_v = sgrade_cohesion * k1_v * k2_v * sgrade_k3_v
  
  Tax_Tav_v = Tax_v + Tav_v
  
  # Find the values Ktr_cd from table 3.3
  if(roadGrade < 3){
    Ktr_cd_v = 1
  }else if(roadGrade == 3 | roadGrade == 4){
    Ktr_cd_v = 0.94
  }else{
    Ktr_cd_v =  0.9
  }
  
  Ctt_Ktr_cd_v = Ctt_v/Ktr_cd_v
  
  # Check deflection
  if (Tax_Tav_v <= Ctt_Ktr_cd_v){
    check_shear = " (OK)"
    check_shear_sign = " ≤"
  } else{
    check_shear = " (NOT OK)"
    check_shear_sign = " ≥"
  }
  
  ##################### TÍNH KÉO UỐN
  
  ##################### TÍNH KÉO UỐN bê tông nhựa dưới
  Etb_b <- Etrbinh(sbase2_Eb,sbase1_Eb,base_Eb,pave2_Eb,pave1_Eb,sbase2_h,sbase1_h,base_h,pave2_h,pave1_h)
  
  H_D_pave2_b <- Etb_b$Htb3/D
  
  # Calculate beta
  beta_pave2_b <- extrapolate_func(hd_values, beta_values, H_D_pave2_b)
  
  # Calculate other variables
  Edctb_pave2_b <- beta_pave2_b * Etb_b$Etb3
  
  E0_Edctb_pave2_b <- sgrade_Edel/Edctb_pave2_b
  
  # Toán đồ 3.1
  interp_graph31_pave2_b <- interp_extra(graph31$x_E0_E1, graph31$y_H_D, graph31$Ech_E1, E0_Edctb_pave2_b, H_D_pave2_b)
  
  Echm_Edctb_pave2_b <- interp_graph31_pave2_b
  
  Echm_pave2_b <- Edctb_pave2_b * Echm_Edctb_pave2_b
  
  H1_D_pave2_b <- base_h/D
  
  pave12_Eb <- (pave1_Eb*pave1_h + pave2_Eb*pave2_h)/(pave1_h + pave2_h)
  
  E1_Echm_pave2 <- pave12_Eb/Echm_pave2_b
  
  interp_graph35_pave2 <- interp_extra(graph35$x_H_D, graph35$E1_Ech, graph35$y_sigma, 
                                       H1_D_pave2_b, E1_Echm_pave2)
  
  phi_bar_ku_pave2 <- interp_graph35_pave2
  
  # Dùng cụm bánh đôi Kb = 0.85. Nếu tính cụm bánh đơn kb = 1.0 trang 49
  # Dùng áp lực p = 0.6 mục 3.2.1
  
  phi_ku_pave2 <- phi_bar_ku_pave2 * 0.6 * 0.85 # công thức 3.10
  

  ##################### TÍNH KÉO UỐN bê tông nhựa trên
  H_D_pave1_b <- Etb_b$Htb4/D
  
  # Calculate beta
  beta_pave1_b <- extrapolate_func(hd_values, beta_values, H_D_pave1_b)
  
  # Calculate other variables
  Edctb_pave1_b <- beta_pave1_b * Etb_b$Etb4
  
  E0_Edctb_pave1_b <- sgrade_Edel/Edctb_pave1_b
  
  # Toán đồ 3.1
  interp_graph31_pave1_b <- interp_extra(graph31$x_E0_E1, graph31$y_H_D, graph31$Ech_E1, E0_Edctb_pave1_b, H_D_pave1_b)
  
  Echm_Edctb_pave1_b <- interp_graph31_pave1_b
  
  Echm_pave1_b <- Edctb_pave1_b * Echm_Edctb_pave1_b
  
  # Tìm Phi_bar_ku ở đáy lớp bê tông nhựa lớp trên bằng cách tra toán đồ 3.5 với
  H1_D_pave1_b <- pave1_h/D # Cần kiểm tra lại công thức tiêu chuẩn chổ này. có thể dùng pave2_h
  
  E1_Echm_pave1 <- pave1_Eb/Echm_pave1_b
  
  interp_graph35_pave1 <- interp_extra(graph35$x_H_D, graph35$E1_Ech, graph35$y_sigma, H1_D_pave1_b, E1_Echm_pave1)
  
  phi_bar_ku_pave1 <- interp_graph35_pave1
  
  # Dùng cụm bánh đôi Kb = 0.85. Nếu tính cụm bánh đơn kb = 1.0 trang 49
  # Dùng áp lực p = 0.6 mục 3.2.1
  
  phi_ku_pave1 <- phi_bar_ku_pave1 * 0.6 * 0.85 # công thức 3.10
  
  
  ##################### TÍNH KÉO UỐN lớp đáy các lớp bê tông nhựa
  # Xác định cường độ chíu kéo uốn tính toán của các lớp bê thông nhựa theo (3-12)
  
  k1_b <- 11.11/Total_Axle_Ne^0.22
  
  # Theo mục 3.6.3 lấy k2 = 1.0, vật liệu gia cố là chất vô cơ, hiện tại chưa dùng hạt nhựa và hạt nhựa polime
  
  # Cường độ chịu kéo uốn cho lớp dưới
  Rku_tt_pave2 <- k1_b * 1.0 * pave2_Rku
  
  # Cường độ chịu kéo uốn cho lớp trên
  Rku_tt_pave1 <- k1_b * 1.0 * pave1_Rku
  
  
  design_bending_pave2 <- Rku_tt_pave2/Ktr_cd_v
  # Kiểm tra kéo uốn nhựa lớp dưới
  if (phi_ku_pave2 <= design_bending_pave2){
    check_bending_pave2 = " (OK)"
    check_bending_pave2_sign = " ≤"
  } else{
    check_bending_pave2 = " (NOT OK)"
    check_bending_pave2_sign = " ≥"
  }
  
  design_bending_pave1 = Rku_tt_pave1/Ktr_cd_v
  # Kiểm tra kéo uốn nhựa lớp trên
  if (phi_ku_pave1 <= design_bending_pave1){
    check_bending_pave1 = " (OK)"
    check_bending_pave1_sign = " ≤"
  } else{
    check_bending_pave1 = " (NOT OK)"
    check_bending_pave1_sign = " ≥"
  }
  
  ##################### TÍNH KÉO UỐN của lớp gia cố xi măng
  H_D_base_b <- Etb_b$Htb2/D

  # Calculate beta
  beta_base_b <- extrapolate_func(hd_values, beta_values, H_D_base_b)

  # Calculate other variables
  Edctb_base_b <- beta_base_b * Etb_b$Etb2

  E0_Edctb_base_b <- sgrade_Edel/Edctb_base_b

  # Toán đồ 3.1
  interp_graph31_base_b <- interp_extra(graph31$x_E0_E1, graph31$y_H_D, graph31$Ech_E1, E0_Edctb_base_b, H_D_base_b)

  Echm_Edctb_base_b <- interp_graph31_base_b

  Echm_base_b <- Edctb_base_b * interp_graph31_base_b

  H1_D_base_b <- (base_h + pave2_h + pave1_h)/D

  # Tìm phi ku bar ở đáy lớp gia cố xi măng bằng cách tra toán đồ Hình 3.6 với
  E1_E2_base_b <- pave12_Eb/base_Eb

  E2_E3_base_b <- base_Eb/Echm_base_b

  graph36_dfE2E3 <- graph36[, c("x_E2E3", "y_E2E3", "E2E3")] %>%
    na.omit()

  #TEST TEST TEST TEST TEST TESTTEST TEST TESTTEST TEST TESTTEST TEST TESTTEST TEST TESTTEST TEST TESTTEST TEST TEST
  # cat("E0_Edctb_base_b: ", E0_Edctb_base_b, "\n")
  # cat("H_D_base_b:", H_D_base_b, "\n")
  #TEST TEST TEST TEST TEST TESTTEST TEST TESTTEST TEST TESTTEST TEST TESTTEST TEST TESTTEST TEST TESTTEST TEST TEST
  
  interp_graph36_E1E2 <- interp_extra(graph36$x_E1E2, graph36$E1E2, graph36$y_E1E2, H1_D_base_b, E1_E2_base_b)
  
  interp_graph36_E2E3 <- interp_extra_linear(graph36_dfE2E3$E2E3, graph36_dfE2E3$y_E2E3, graph36_dfE2E3$x_E2E3, E2_E3_base_b, interp_graph36_E1E2)

  phi_bar_ku_base <- interp_graph36_E2E3/2

  # Dùng cụm bánh đôi Kb = 0.85. Nếu tính cụm bánh đơn kb = 1.0 trang 49
  # Dùng áp lực p = 0.6 mục 3.2.1

  phi_ku_base <- phi_bar_ku_base * 0.6 * 0.85 # công thức 3.10

  # Ở đây trong (3-11) theo mục 3.6.3 xác định được k1 theo công thức 3.13
  k1_base_b <- 2.86/Total_Axle_Ne^0.11

  # Theo mục 3.6.3 lấy k2 = 1.0, vật liệu gia cố là chất vô cơ, hiện tại chưa dùng hạt nhựa và hạt nhựa polime

  # Cường độ chịu kéo uốn cho móng trên base
  Rku_tt_base <- k1_base_b * 1.0 * base_Rku

  # Kiểm tra điều kiện tính toán
  design_bending_base <- Rku_tt_base/Ktr_cd_v
  # Kiểm tra kéo uốn nhựa lớp dưới
  if (phi_ku_base <= design_bending_base){
    check_bending_base = " (OK)"
    check_bending_base_sign = " ≤"
  } else{
    check_bending_base = " (NOT OK)"
    check_bending_base_sign = " ≥"
  }

  
  ########################RETURN ALL
  return(list(
    ########################CHECK DEFLECTION
    H_D = H_D,
    beta = beta,
    E0del_Edctb_del =  E0del_Edctb_del,
    Edctb_del = Edctb_del,
    Ech_del = Ech_del,
    pave1_grade = pave1_grade,
    Ech_E1_del = Ech_E1_del,
    check_deflection = check_deflection, # Result of deflection
    Kdv_cd_Eyc_del = Kdv_cd_Eyc_del,
    check_deflection_sign = check_deflection_sign, # Result of deflection
    ########################CHECK SHEAR
    Etb_v = Etb_v,
    Edctb_v = Edctb_v,
    Etb_E0_v = Etb_E0_v,
    Tax_p_v = Tax_p_v,
    Tax_v = Tax_v,
    Tav_v = Tav_v,
    Tax_Tav_v = Tax_Tav_v,
    Ctt_Ktr_cd_v = Ctt_Ktr_cd_v,
    check_shear_sign = check_shear_sign, # Result of shear
    check_shear = check_shear, # Result of shear
    ########################CHECK BENDING
    # Kiểm tra kéo uốn cho asphalt lớp dưới
    H_D_pave2_b = H_D_pave2_b,
    beta_pave2_b = beta_pave2_b,
    Edctb_pave2_b = Edctb_pave2_b,
    E0_Edctb_pave2_b = E0_Edctb_pave2_b,
    Echm_Edctb_pave2_b = Echm_Edctb_pave2_b,
    Echm_Edctb_pave2_b = Echm_Edctb_pave2_b,
    pave12_Eb = pave12_Eb,
    Echm_pave2_b = Echm_pave2_b,
    H1_D_pave2_b = H1_D_pave2_b,
    E1_Echm_pave2 = E1_Echm_pave2,
    phi_bar_ku_pave2 = phi_bar_ku_pave2,
    phi_ku_pave2 = phi_ku_pave2,
    # Kiểm tra kéo uốn cho asphalt lớp trên
    H_D_pave1_b = H_D_pave1_b,
    beta_pave1_b = beta_pave1_b,
    Edctb_pave1_b = Edctb_pave1_b,
    Echm_Edctb_pave1_b = Echm_Edctb_pave1_b,
    Echm_pave1_b = Echm_pave1_b,
    H1_D_pave1_b = H1_D_pave1_b,
    E1_Echm_pave1 = E1_Echm_pave1,
    phi_bar_ku_pave1 = phi_bar_ku_pave1,
    phi_ku_pave1 = phi_ku_pave1,
    # Kiểm tổng hợp cho asphalt lớp dưới và asphalt lớp trên
    k1_b = k1_b,
    Rku_tt_pave2 = Rku_tt_pave2,
    Rku_tt_pave1 = Rku_tt_pave1,
    Ktr_cd_v = Ktr_cd_v,
    design_bending_pave2 = design_bending_pave2,
    check_bending_pave2 = check_bending_pave2,
    check_bending_pave2_sign = check_bending_pave2_sign,
    design_bending_pave1 = design_bending_pave1,
    check_bending_pave1 = check_bending_pave1,
    check_bending_pave1_sign = check_bending_pave1_sign,
    # Kiểm tra lớp móng trên base
    H_D_base_b = H_D_base_b,
    beta_base_b = beta_base_b,
    Edctb_base_b = Edctb_base_b,
    E0_Edctb_base_b = E0_Edctb_base_b,
    Echm_Edctb_base_b = Echm_Edctb_base_b,
    Echm_base_b = Echm_base_b,
    H1_D_base_b = H1_D_base_b,
    E1_E2_base_b = E1_E2_base_b,
    E2_E3_base_b = E2_E3_base_b,
    phi_bar_ku_base = phi_bar_ku_base,
    phi_ku_base = phi_ku_base,
    design_bending_base = design_bending_base,
    check_bending_base = check_bending_base,
    check_bending_base_sign =check_bending_base_sign
  ))
  
}

# 
# check_Flexible_Function(18,17,14,42,15,
#                         42,250,300,600,350,420,
#                         250,300,600,250,300,
#                         250,300,600,1600,1800,
#                         0.8,2,2.8,
#                         0.032,
#                         24,
#                         1,
#                         0,
#                         15,
#                         1638,
#                         2154272,
#                         0.35,
#                         1.5,
#                         graph31, graph33, graph34, graph35, graph36)
# 
# 
# 
# 
# #TEST TEST TEST TEST TEST TESTTEST TEST TESTTEST TEST TESTTEST TEST TESTTEST TEST TESTTEST TEST TESTTEST TEST TEST
# cat("H1_D_base_b:", H1_D_base_b, "\n")
# cat("E1_E2_base_b:", E1_E2_base_b, "\n")
# cat("E2_E3_base_b:", E2_E3_base_b, "\n")
# #TEST TEST TEST TEST TEST TESTTEST TEST TESTTEST TEST TESTTEST TEST TESTTEST TEST TESTTEST TEST TESTTEST TEST TEST













# # # Etrbinh(250,300,600,1600,1800,18,17,14,8,6)
# #
# check_Flexible_Function(30,40,14,8,6,
#                         42,250,300,600,350,420,
#                         250,300,600,250,300,
#                         250,300,600,1600,1800,
#                         0.8,2,2.8,
#                         0.032,
#                         24,
#                         1,
#                         0,
#                         15,
#                         1638,
#                         2154272,
#                         0.35,
#                         1.5,
#                         graph31, graph33, graph34, graph35, graph36)