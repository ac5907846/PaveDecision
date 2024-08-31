check_Rigid_Function <- function(Depth_h1, Module_E1, sgrade_Edel, Module_Ec, Depth_hc,
                                 Poisson_mc, Module_Eb, Depth_hb, Poisson_mb, Standard_Load, Largest_Load,
                                 roadGrade, Length_Pave_L, Expand_ac,
                                 region_Tg, Total_Axle_Ne){
  
  Depth_h1 <- Depth_h1/100
  Depth_hc <- Depth_hc/100
  Depth_hb <- Depth_hb/100
  
  # Calculate the standard load
  if(Standard_Load == 1){
    Ps = 100
  }else{
    Ps = 120
  }
  
  # Cường độ kéo uốn thiết kế yêu cầu của BTXM làm tầng mặt (fr)
  if(roadGrade < 4){
    fr = 5
  }else{
    fr = 4.5
  }
  
  # Cấp đường ảnh hưởng đến kc
  if (roadGrade == 0) {
    roadGrade_kc = 1.15
  } else if (roadGrade == 1 | roadGrade == 2) {
    roadGrade_kc = 1.1
  } else if (roadGrade == 3) {
    roadGrade_kc = 1.05
  } else{
    roadGrade_kc = 1
  }
  
  # Cấp đường ảnh hưởng đến gamma r
  if (roadGrade == 0) {
    gamma_r = 1.5
  } else if (roadGrade == 1 | roadGrade == 2) {
    gamma_r = 1.23
  } else if (roadGrade == 3) {
    gamma_r = 1.13
  } else{
    gamma_r = 1.07
  }
  
  # Calculate variables
  Ex = Depth_h1^2*Module_E1/Depth_h1^2
  hx = Depth_h1
  alpha = .86 + .26*log(hx, base = exp(1))
  Et = (Ex/sgrade_Edel)^alpha*sgrade_Edel
  Dc = Module_Ec*Depth_hc^3/(12*(1-Poisson_mc^2))
  Db = Module_Eb*Depth_hb^3/(12*(1-Poisson_mb^2))
  rg = 1.21*((Dc + Db)/Et)^(1/3)
  sigma_ps = 1.45*10^(-3)/(1+Db/Dc)*rg^.65*Depth_hc^(-2)*Ps^.94
  sigma_pm = 1.45*10^(-3)/(1+Db/Dc)*rg^.65*Depth_hc^(-2)*Largest_Load^.94
  sigma_pr = .87*Total_Axle_Ne^0.057*roadGrade_kc*sigma_ps
  sigma_pmax = .87*roadGrade_kc*sigma_pm
  kn = 1/2*(Depth_hc/Module_Ec + Depth_hb/Module_Eb)^(-1)
  r_beta = (Dc * Db/(Dc + Db)/kn)^(1/4)
  epxilon = -((kn*rg^4-Dc)*r_beta^3/((kn*r_beta^4-Dc)*rg^3))
  t = Length_Pave_L/3/rg
  CL = 1-1/(1+epxilon)*(sinh(t)*cos(t)+cosh(t)*sin(t))/(cos(t)*sin(t)+sinh(t)*cosh(t))
  BL = 1.77*exp(-4.48*Depth_hc)*CL-.131*(1-CL)
  
  Expand_ac <- Expand_ac * 10^-6
  
  # Kiểm tra điều kiện biên
  if (Expand_ac * Depth_hc * Module_Ec * region_Tg / 2 * BL > 0){
    sigma_tmax = Expand_ac * Depth_hc * Module_Ec * region_Tg / 2 * BL
    kt = max(fr/sigma_tmax*(.841*(sigma_tmax/fr)^1.323-0.058),fr/sigma_tmax*(.871*(sigma_tmax/fr)^1.287-0.071))
    sigma_tr = kt * sigma_tmax
  }else{
    sigma_tmax = 0
    kt = 0
    sigma_tr = 0
  }
  
  actual_bending_standard_load = gamma_r*(sigma_pr + sigma_tr)
  actual_bending_largest_load = gamma_r*(sigma_pmax + sigma_tmax)
  if (actual_bending_standard_load <= fr){
    check_standard = " (OK)"
    check_standard_sign = " ≤"
  } else{
    check_standard = " (NOT OK)"
    check_standard_sign = " ≥"
  }
  if (actual_bending_largest_load <= fr){
    check_largest = " (OK)"
    check_largest_sign = " ≤"
  } else{
    check_largest = " (NOT OK)"
    check_largest_sign = " ≥"
  }
  return(list(
    # Check result to make sure calculation is correct
    Ex = Ex,
    hx = hx,
    alpha = alpha,
    Et = Et,
    Dc = Dc,
    Module_Eb = Module_Eb,
    Depth_hb = Depth_hb,
    Poisson_mb = Poisson_mb,
    Db = Db,
    rg = rg,
    sigma_ps = sigma_ps,
    sigma_pm = sigma_pm,
    sigma_pr = sigma_pr,
    sigma_pmax = sigma_pmax,
    kn = kn,
    r_beta = r_beta,
    epxilon = epxilon,
    t = t,
    CL = CL,
    BL = BL,
    sigma_tmax = sigma_tmax,
    kt = kt,
    sigma_tr = sigma_tr,
    fr = fr,
    # Result
    actual_bending_standard_load = actual_bending_standard_load,
    actual_bending_largest_load = actual_bending_largest_load,
    check_standard = check_standard,
    check_largest = check_largest,
    check_standard_sign = check_standard_sign,
    check_largest_sign = check_largest_sign
  ))
}

# Debug function
# check_Rigid_Function(.18, 300, 45, 31000, .26, .15, 1300, .2, .2, 1, 180, 1.05, 4.8, 0.00001, 92, 17070000)