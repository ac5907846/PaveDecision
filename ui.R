# Source the input.R file -------------------------------------------------
source("UI_rigid.R")
source("UI_flexible.R")
source("UI_graph.R")
source("UI_economic.R")
source("UI_examples.R")

dashboardPage(
  
  ## Header ------------------------------------------------------------------
  dashboardHeader(title = "Pave Decision"),
  
  ## Sidebar content ---------------------------------------------------------
  dashboardSidebar(
    sidebarMenu(
      id = "leftSideBar",
      menuItem("Pavement Design", tabName = "pavement_design_tab"),
      menuItem("Digitized Charts", tabName = "graph_search_tab"),
      menuItem("System Testing", tabName = "test_system_tab"),
      menuItem("Case Studies", tabName = "case_study_tab")
    )
  ),
  
  ## Body content ------------------------------------------------------------
  dashboardBody(
    ## link to css file
    tags$head(
      tags$link(rel = "stylesheet", type = "text/css", href = "styles.css")
    ),
    
    tabItems(
      ## First tab content
      tabItem(tabName = "pavement_design_tab",
              # Title here
              div(class = "my-title", "Rigid and Flexible Pavement Design"),
              #############################
              # General Requirements Panel
              ############################
              fluidRow(
                box(title = "Road Grade and Dimmention", status = "primary", solidHeader = TRUE, width = 4,
                    fluidRow(
                      column(width = 6,
                             UI_region_Tg, # Chọn vùng miền
                             UI_design_year, # Thời hạn thiết kế (năm)
                             UI_roadGrade # Chọn cấp đường
                      ),
                      column(width = 6,
                             UI_lane_width, # Chiều rộng đường
                             UI_lane_quantity, # Hệ số f1 của các làn xe trên phần xe chạy, số lane
                             UI_road_length # Chiều dài đường
                      )
                    )
                ),
                useShinyjs(),  # Set up shinyjs
                box(title = "Traffic", status = "primary", solidHeader = TRUE, width = 4,
                    fluidRow(
                      column(width = 6,
                             UI_Vehicle_Growth_q, # Luật tăng trưởng xe trung bình (%/năm)
                             UI_Total_Axle_Ntk, # số trục xe quy đổi về trục số tiêu chuẩn 100 kN trục/làn.ngày đêm
                             UI_Total_Axle_Ne, # Calculate Ne manually
                             actionButton(inputId = "Total_Axle_Ne_button",
                                          label = "Calculate Total Axle Mannually",
                                          class = "my-button-blue")
                      ),
                      column(width = 6,
                             UI_Stardard_Load, # Tải trục tiêu chuẩn
                             UI_Largest_Load, # Tải trục xe nặng nhất (Rigid)
                             UI_Eyc_special, # Show the Eyc input
                             actionButton(inputId = "Eyc_special_button",
                                          label = HTML("Input E<sub>yc</sub> Manually"),
                                          class = "my-button-blue")
                      )
                    )
                ),
                box(title = "Subgrade", status = "primary", solidHeader = TRUE, width = 4,
                    fluidRow(
                      column(width = 6,
                             UI_sgrade_k3_v
                      ),
                      column(width = 6,
                             UI_sgrade_cohesion,
                             UI_sgrade_Edel,
                             UI_sgrade_phi
                      )
                    )
                )
              ),
              #######################
              # Rigid Pavement Design
              #######################
              fluidRow(
                box(title = "Rigid Pavement Design Inputs", status = "primary", solidHeader = TRUE, width = 8,
                    fluidRow(
                      column(width = 2,
                             tags$p("Concrete:",style = "padding-top: 3.4em; color: #32368F; font-weight: bold;text-align: right;"),
                             tags$p("Base:",style = "padding-top: 1.3em; color: #32368F; font-weight: bold;text-align: right;"),
                             tags$p("Subbase:",style = "padding-top: 1.3em; color: #32368F; font-weight: bold;text-align: right;"),
                      ),
                      column(width = 2,
                             infoIconSpan("h (cm)", "Thickness of each layers (cm). Bề dày lớp (cm)"),
                             UI_Depth_Pave_hc, # Chiều dày tầng mặt Pavement (hc) (m)
                             UI_Depth_Base_hb, # Chiều dày móng trên Base (hb) (m)
                             UI_Depth_Subbase_h1 # Chiều dày móng dưới Subbase (h1) (m)
                      ),
                      column(width = 2,
                             infoIconSpan("E (MPa)", "Elastic modulus (MPa)"),
                             UI_Module_Pave_Ec, # Module Đàn Hồi Tầng Mặt Pavement (Ec) (MPa)
                             UI_Module_Base_Eb, # Module Đàn Hồi Móng Trên Base (Eb) (MPa)
                             UI_Module_Subbase_E1, # Module Đàn Hồi Móng Dưới Subbase (E1) (MPa)
                      ),
                      column(width = 2,
                             infoIconSpan("Poission", "Poisson's ratio"),
                             UI_Poisson_Pave_mc, # Hệ số Poisson Tầng Mặt Pavement (µc)
                             UI_Poisson_Base_mb, # Hệ số Poisson Móng Trên Base (µb)
                             UI_Poisson_Subbase_m1 # Hệ số Poisson Móng Dưới Subbase (µ1)
                      ),
                      column(width = 2,
                             UI_Length_Pave_L # Chiều dày tấm BT tầng mặt Pave (L) (m)
                      ),
                      column(width = 2,
                             UI_Expand_ac # Hệ số dãn nỡ một chiều của BTXM (αc)
                      )
                    )
                ),
                box(title = "Rigid Pavement Design Outputs", status = "primary", solidHeader = TRUE, width = 4,
                    fluidRow(
                      column(width = 12,
                             tags$p("Check Bending Stress from Standard Load", style = "font-weight: bold;margin-bottom: 0.1em; font-size: 1.2em;"),
                             htmlOutput(outputId = "check_rigid_standard_stress_result",
                                        style = "margin-bottom: 0.2em; font-size: 1.2em;"),
                             tags$p("Check Bending Stress from Largest Load", style = "font-weight: bold;margin-bottom: 0.1em; font-size: 1.2em;"),
                             htmlOutput(outputId = "check_rigid_largest_stress_result",
                                        style = "margin-bottom: 0.2em; font-size: 1.2em;")
                      )
                    )     
                )
              ),
              ##########################
              # Flexible Pavement Design
              ##########################
              fluidRow(
                box(title = "Flexible Pavement Design Inputs", status = "primary", solidHeader = TRUE, width = 8,
                    fluidRow(
                      column(width = 2,
                             tags$p("Asphalt Top:",style = "padding-top: 3.4em; color: #32368F; font-weight: bold;text-align: right;"),
                             tags$p("Asphalt Bottom:",style = "padding-top: 1.3em; color: #32368F; font-weight: bold;text-align: right;"),
                             tags$p("Base:",style = "padding-top: 1.3em; color: #32368F; font-weight: bold;text-align: right;"),
                             tags$p("Subbase Top:",style = "padding-top: 1.3em; color: #32368F; font-weight: bold;text-align: right;"),
                             tags$p("Subbase Bottom:",style = "padding-top: 1.3em; color: #32368F; font-weight: bold;text-align: right;"),
                      ),
                      
                      column(width = 2,
                             infoIconSpan("h (cm)", "Thickness of each layers (cm). Bề dày lớp (cm)"),
                             UI_pave1_h, # Chiều dày asphalt layer 1 (cm)
                             UI_pave2_h, # Chiều dày asphalt layer 2 (cm)
                             UI_base_h, # Chiều dày móng trên (cm)
                             UI_sbase1_h, # Chiều dày móng dưới subbase lớp 1 (cm)
                             UI_sbase2_h, # Chiều dày móng dưới subbase lớp 2 (cm)
                      ),
                      column(width = 2,
                             infoIconSpan("EΔ (MPa)", "Elastic modulus of deflection (MPa). Module đàn hồi của độ võng (MPa)"),
                             UI_pave1_Edel, # E võng của asphalt lớp 1 (MPa)
                             UI_pave2_Edel, # E võng của asphalt lớp 2 (MPa)
                             UI_base_Edel, # E võng của móng trên (MPa)
                             UI_sbase1_Edel, # E võng của móng dưới lớp 1 (MPa)
                             UI_sbase2_Edel, # E võng của móng dưới lớp 2 (MPa)
                      ),
                      column(width = 2,
                             infoIconSpan("Ev (MPa)", "Elastic modulus of shear (MPa). Module đàn hồi của trượt (MPa)"),
                             UI_pave1_Ev, # E trượt của asphalt lớp 1 (MPa)
                             UI_pave2_Ev, # E trượt của asphalt lớp 2 (MPa)
                             UI_base_Ev, # E trượt của móng trên (MPa)
                             UI_sbase1_Ev, # E trượt của móng dưới lớp 1 (MPa)
                             UI_sbase2_Ev, # E trượt của móng dưới lớp 2 (MPa)
                      ),
                      column(width = 2,
                             infoIconSpan("Eb (MPa)", "Elastic modulus of bending (MPa). Module đàn hồi của kéo uốn (MPa)"),
                             UI_pave1_Eb, # E kéo uốn của asphalt lớp 1 (MPa)
                             UI_pave2_Eb, # E kéo uốn của asphalt lớp 2 (MPa)
                             UI_base_Eb, # E kéo uốn của móng trên (MPa)
                             UI_sbase1_Eb, # E kéo uốn của móng dưới lớp 1 (MPa)
                             UI_sbase2_Eb, # E kéo uốn của móng dưới lớp 2 (MPa)
                      ),
                      column(width = 2,
                             infoIconSpan("Rku (MPa)", "Bending limit (Rku) (MPa). Cường độ kéo uốn giới hạn (Rku) (MPa)"),
                             UI_pave1_Rku, # Cường độ kéo uốn giới hạn của asphalt lớp 1 (MPa)
                             UI_pave2_Rku, # Cường độ kéo uốn giới hạn của asphalt lớp 2 (MPa)
                             UI_base_Rku, # Cường độ kéo uốn giới hạn của móng trên (MPa)
                      )
                    )
                ),
                box(title = "Flexible Pavement Design Outputs", status = "primary", solidHeader = TRUE, width = 4,
                    fluidRow(
                      column(width = 12,
                      tags$p("Check Deflection", style = "font-weight: bold;margin-bottom: 0.1em; font-size: 1.2em;"),
                      htmlOutput(outputId = "check_flexible_deflection_result",
                                 style = "margin-bottom: 0.2em; font-size: 1.2em;"),
                      tags$p("Check Shear", style = "font-weight: bold; margin-bottom: 0.2em; font-size: 1.2em;"),
                      htmlOutput(outputId = "check_flexible_shear_result",
                                 style = "margin-bottom: 0.2em; font-size: 1.2em;"),
                      tags$p("Check Bending of Bottom Asphalt Layer", style = "font-weight: bold; margin-bottom: 0.2em; font-size: 1.2em;"),
                      htmlOutput(outputId = "check_flexible_bending_pave2_result",
                                 style = "margin-bottom: 0.2em; font-size: 1.2em;"),
                      tags$p("Check Bending of Top Asphalt Layer", style = "font-weight: bold; margin-bottom: 0.2em; font-size: 1.2em;"),
                      htmlOutput(outputId = "check_flexible_bending_pave1_result",
                                 style = "margin-bottom: 0.2em; font-size: 1.2em;"),
                      tags$p("Check Bending of Base Layer", style = "font-weight: bold; margin-bottom: 0.2em; font-size: 1.2em;"),
                      htmlOutput(outputId = "check_flexible_bending_base_result",
                                 style = "margin-bottom: 0.2em; font-size: 1.2em;")
                      )
                    ))
              ),
              #####################
              # Unit Cost Estimate
              #####################
              fluidRow(
                box(title = "Unit Cost Estimate", status = "primary", solidHeader = TRUE, width = 4,
                    tabBox(width = 12,
                           tabPanel("Unit Cost",
                                    fluidRow(
                                      column(width = 6,
                                             tags$p("Rigid:",style = "font-weight: bold; text-align: left; font-size: 2.0em;"),
                                             fluidRow(
                                               box(width = 12, background = "maroon",
                                                   "Initial Construction Cost ($):", br(),
                                                   htmlOutput(outputId = "total_con_cost_rigid_result")
                                               )
                                             ),
                                             UI_r_pave_unitcost,
                                             UI_r_base_unitcost,
                                             UI_r_subbase_unitcost,
                                             UI_r_long_joint_unitcost,
                                             UI_r_tran_joint_unitcost
                                      ), 
                                      column(width = 6,
                                             tags$p("Flexible:",style = "font-weight: bold; text-align: left; font-size: 2.0em;"),
                                             fluidRow(
                                               box(width = 12, background = "maroon",
                                                   "Initial Construction Cost ($):", br(),
                                                   htmlOutput(outputId = "total_con_cost_flex_result")
                                               )
                                             ),
                                             UI_f_pave1_unitcost,
                                             UI_f_pave2_unitcost,
                                             UI_f_base_unitcost,
                                             UI_f_sbase1_unitcost,
                                             UI_f_sbase2_unitcost,
                                             UI_f_bonding_unitcost
                                      ) 
                                    ),
                                    fluidRow(
                                      box(width = 12, background = "maroon",
                                          htmlOutput(outputId = "different_con_cost_result")
                                      )
                                    )
                           ),
                           tabPanel("Rebuild",
                                    fluidRow(
                                      column(width = 6,
                                             tags$p("Rigid:",style = "font-weight: bold; text-align: left; font-size: 2.0em;"),
                                             fluidRow(
                                               box(width = 12, background = "olive",
                                                   "Rebuild Cost ($):", br(),
                                                   htmlOutput(outputId = "total_rebuild_cost_rigid_result")
                                               )
                                             ),
                                             UI_rebuild_r_pave,
                                             UI_rebuild_r_base,
                                             UI_rebuild_r_subbase,
                                      ), 
                                      column(width = 6,
                                             tags$p("Flexible:",style = "font-weight: bold; text-align: left; font-size: 2.0em;"),
                                             fluidRow(
                                               box(width = 12, background = "olive",
                                                   "Rebuild Cost ($):", br(), htmlOutput(outputId = "total_rebuild_cost_flex_result")
                                               )
                                             ),
                                             UI_rebuild_f_pave1,
                                             UI_rebuild_f_pave2,
                                             UI_rebuild_f_base,
                                             UI_rebuild_f_subbase1,
                                             UI_rebuild_f_subbase2,
                                      ) 
                                    )
                           ),
                           tabPanel("Life Cycle Costs",
                                    fluidRow(
                                      column(width = 6,
                                             tags$p("Rigid:",style = "font-weight: bold; text-align: left; font-size: 2.0em;"),
                                             fluidRow(
                                               box(width = 12, background = "blue",
                                                   "Life Cycle Cost ($):", br(),
                                                   htmlOutput(outputId = "life_cost_rigid_result")
                                               )
                                             ),
                                             UI_rigid_r.M1P, # Maintenance cost % of rigid pavement
                                             UI_rigid_r.M2P, # % Minor rehabilitation cost of rigid pavement
                                             UI_rigid_r.M3P, # % Major rehabilitation cost of rigid pavement
                                             UI_rigid_r.na, # Assessment time (yr) of rigid pavement
                                             UI_rigid_r.n0, # Life-cycle time (yr) of rigid pavement
                                             UI_rigid_r.n1, # Maintenance frequency (yr) of rigid pavement
                                             UI_rigid_r.n2, # Minor rehabilitation frequency (yr) of rigid pavement
                                             UI_rigid_r.n3, # Major rehabilitation frequency (yr) of rigid pavement
                                             UI_rigid_r.ir # % Discount rate of rigid pavement
                                      ), 
                                      column(width = 6,
                                             tags$p("Flexible:",style = "font-weight: bold; text-align: left; font-size: 2.0em;"),
                                             fluidRow(
                                               box(width = 12, background = "blue",
                                                   "Life Cycle Cost ($):", br(),
                                                   htmlOutput(outputId = "life_cost_flex_result")
                                               )
                                             ),
                                             UI_flexible_f.M1P, # Maintenance cost % of flexible pavement
                                             UI_flexible_f.M2P, # % Minor rehabilitation cost of flexible pavement
                                             UI_flexible_f.M3P, # % Major rehabilitation cost of flexible pavement
                                             UI_flexible_f.na, # Assessment time (yr) of flexible pavement
                                             UI_flexible_f.n0, # Life-cycle time (yr) of flexible pavement
                                             UI_flexible_f.n1, # Maintenance frequency (yr) of flexible pavement
                                             UI_flexible_f.n2, # Minor rehabilitation frequency (yr) of flexible pavement
                                             UI_flexible_f.n3, # Major rehabilitation frequency (yr) of flexible pavement
                                             UI_flexible_f.ir # % Discount rate of flexible pavement
                                      )  
                                    ),
                                    fluidRow(
                                      box(width = 12, background = "blue",
                                          htmlOutput(outputId = "different_life_cost_result")
                                      )
                                    )
                           )
                    )
                ),
                column(width = 8,
                       box(title = "Cash Flow Diagram of Rigid Pavement", status = "primary", solidHeader = TRUE, width = 12,
                           plotOutput("rigid_cashflow_output")
                       ),
                       box(title = "Cash Flow Diagram of Flexible Pavement", status = "primary", solidHeader = TRUE, width = 12,
                           plotOutput("flex_cashflow_output")
                       )
                )
              )
      ),
      
      # Second tab content
      tabItem(tabName = "graph_search_tab",
              div(class = "my-title", "Manually Find Design Values from Graph"),
              #################
              # Graph 3.1 panel
              #################
              fluidRow(
                box(title = "Inputs for Graph 3.1", status = "primary", solidHeader = TRUE, width = 4,
                    UI_graph31_E0_E1,
                    UI_graph31_H_D
                ),
                box(width = 8,
                    plotOutput("graph31")
                ),
              ),
              #################
              # Graph 3.3 panel
              #################
              fluidRow(
                box(title = "Inputs for Graph 3.3", status = "primary", solidHeader = TRUE, width = 4,
                    UI_graph33_H_D,
                    UI_graph33_E1_E2,
                    UI_graph33_Phi
                ),
                box(width = 8,
                    plotOutput("graph33")
                ),
              ),
              #################
              # Graph 3.4 panel
              #################
              fluidRow(
                box(title = "Inputs for Graph 3.4", status = "primary", solidHeader = TRUE, width = 4,
                    UI_graph34_Htb,
                    UI_graph34_Phi
                ),
                box(width = 8,
                    plotOutput("graph34")
                ),
              ),
              #################
              # Graph 3.5 panel
              #################
              fluidRow(
                box(title = "Inputs for Graph 3.5", status = "primary", solidHeader = TRUE, width = 4,
                    UI_graph35_H_D,
                    UI_graph35_E1_Ech
                ),
                box(width = 8,
                    plotOutput("graph35")
                ),
              ),
              #################
              # Graph 3.6 panel
              #################
              fluidRow(
                box(title = "Inputs for Graph 3.6", status = "primary", solidHeader = TRUE, width = 4,
                    UI_graph36_H_D,
                    UI_graph36_E1_E2,
                    UI_graph36_E2_E3
                ),
                box(width = 8,
                    plotOutput("graph36")
                ),
              )
      ),
      # Second tab content
      tabItem(tabName = "test_system_tab",
              fluidRow(
                column(width = 10,
                       div(class = "my-title", "Test System with Design Standards")
                       ),
                column(width = 2,
                       actionButton(inputId = "language_Vietnamese",
                                    label = "Vietnamese",
                                    class = "my-button-red"),
                       actionButton(inputId = "language_English",
                                    label = "English",
                                    class = "my-button-red")
                       )
              ),
              fluidRow(
                column(width = 10,
                       box(title = "Example Calculation from TCVN (2006)", status = "primary", solidHeader = TRUE, width = 12,
                           uiOutput("TCVN2006_content")
                       ),
                ),
                column(width = 2,
                       actionButton(inputId = "TCVN2006_example_button",
                                    label = "Test with TCVN (2006) Example",
                                    class = "my-button-red")
                       )
                ),
              fluidRow(
                column(width = 10,
                       box(title = "Example Calculation from TCVN (2012)", status = "primary", solidHeader = TRUE, width = 12,
                           uiOutput("TCVN2012_content")
                       ),
                ),
                column(width = 2,
                       actionButton(inputId = "TCVN2012_example_button",
                                    label = "Test with TCVN (2012) Example",
                                    class = "my-button-red")
                )
              )
                
              ),
      # Second tab content
      tabItem(tabName = "case_study_tab",
              div(class = "my-title", "Case Studies"),
              fluidRow(
                column(width = 10,
                       box(title = "Cam Lam - Vinh Hao", status = "primary", solidHeader = TRUE, width = 12,
                           includeHTML("html/CamLam_VinhHao.html")
                       ),
                ),
                column(width = 2,
                       actionButton(inputId = "CamLam_VinhHao_button",
                                    label = "Check Cam Lam - Vinh Hao",
                                    class = "my-button-red")
                )
              ),
              fluidRow(
                column(width = 10,
                       box(title = "Nha Trang - Cam Lam", status = "primary", solidHeader = TRUE, width = 12,
                           includeHTML("html/NhaTrang_CamLam.html")
                       ),
                ),
                column(width = 2,
                       actionButton(inputId = "NhaTrang_CamLam_button",
                                    label = "Check Nha Trang - Cam Lam",
                                    class = "my-button-red")
                )
              ),
              fluidRow(
                column(width = 10,
                       box(title = "Long Thanh - Dau Giay", status = "primary", solidHeader = TRUE, width = 12,
                           includeHTML("html/LongThanh_DauGiay.html")
                       ),
                ),
                column(width = 2,
                       actionButton(inputId = "LongThanh_DauGiay_button",
                                    label = "Check Long Thanh - Dau Giay",
                                    class = "my-button-red")
                )
              ),
              fluidRow(
                column(width = 10,
                       box(title = "Trung Luong - My Thuan", status = "primary", solidHeader = TRUE, width = 12,
                           includeHTML("html/TrungLuong_MyThuan.html")
                       ),
                ),
                column(width = 2,
                       actionButton(inputId = "TrungLuong_MyThuan_button",
                                    label = "Check Trung Luong - My Thuan",
                                    class = "my-button-red")
                )
              )
      )
      ),
  )
)