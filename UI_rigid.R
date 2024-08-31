# Trị số gradient nhiệt độ lớn nhất để tính ứng suất nhiệt lớn nhất (Tg)
UI_region_Tg <- selectInput(inputId = "region_Tg",
                            label = tags$span("Select the Region:",
                                              tags$i(
                                                class = "glyphicon glyphicon-info-sign",
                                                style = "color:#0072B2;",
                                                title = "Chọn vùng Bắc Trung Nam. Cái này dùng để tính trị số gradient nhiệt độ lớn nhất để tính ứng suất nhiệt lớn nhất (Tg)"
                              )),
                            choices = c("North Region" = 86,
                                        "Central Region" = 89,
                                        "South Region" = 92),
                            selected = 92
                            )

# Hệ số tổng hợp xét đến ảnh hưởng của tác dụng động và các yếu tố sai khác giữa lý thuyết và thực tế chịu lực của tấm BTXM (kc)
UI_roadGrade <- selectInput(inputId = "roadGrade",
                               label = tags$span("Select Roadway Grade:",
                                                 tags$i(
                                                   class = "glyphicon glyphicon-info-sign",
                                                   style = "color:#0072B2;",
                                                   title = "Chọn cấp đường. Cái này dùng để tính đến hệ số tổng hợp xét đến ảnh hưởng của tác dụng động và các yếu tố sai khác giữa lý thuyết và thực tế chịu lực của tấm BTXM (kc)"
                                                 )),
                               choices = c("Expressway (i.e., freeway)" = 0,
                                           "Roadway grade I" = 1,
                                           "Roadway grade II" = 2,
                                           "Roadway grade III" = 3,
                                           "Roadway grade IV" = 4,
                                           "Other roadways" = 5),
                               selected = 3
                               )

# Thời hạn thiết kế (năm)
UI_design_year <- numericInput(inputId = "design_year",
                               label = tags$span("Design Service Life:",
                                                 tags$i(
                                                   class = "glyphicon glyphicon-info-sign",
                                                   style = "color:#0072B2;",
                                                   title = "Thời hạn thiết kế (năm)"
                                                 )),
                               value = 15
)

# Hệ số f1 của các làn xe trên phần xe chạy
UI_lane_quantity <- numericInput(inputId = "lane_quantity",
                                label = tags$span("Quantity of Lane:",
                                                  tags$i(
                                                    class = "glyphicon glyphicon-info-sign",
                                                    style = "color:#0072B2;",
                                                    title = "Số lượng làn xe"
                                                  )),
                                value = 4
)

# Chiều rộng đường
UI_lane_width <- numericInput(inputId = "lane_width",
                              label = tags$span("Road width (m):",
                                                tags$i(
                                                  class = "glyphicon glyphicon-info-sign",
                                                  style = "color:#0072B2;",
                                                  title = "Chiều rộng của cả đoạn đường (m)"
                                                )),
                              value = 3.5,
                              step = 1
)

# Chiều dài đường
UI_road_length <- numericInput(inputId = "road_length",
                               label = tags$span("Road length (km):",
                                                 tags$i(
                                                   class = "glyphicon glyphicon-info-sign",
                                                   style = "color:#0072B2;",
                                                   title = "Chiều dài của cả đoạn đường (km)"
                                                 )),
                               value = 54,
                               step = 1
)

# Tải trục tiêu chuẩn
UI_Stardard_Load <- selectInput(inputId = "Standard_Load",
                                label = tags$span("Standard Load (kN):",
                                                  tags$i(
                                                    class = "glyphicon glyphicon-info-sign",
                                                    style = "color:#0072B2;",
                                                    title = "Tải trục tiêu chuẩn"
                                                  )),
                                choices = c("100 kN" = 1,
                                            "120 kN" = 0.55),
                                selected = 1
)

# Tải trục xe nặng nhất (Rigid)
UI_Largest_Load <- numericInput(inputId = "Largest_Load",
                                label = tags$span("Largest Load (kN):",
                                                  tags$i(
                                                    class = "glyphicon glyphicon-info-sign",
                                                    style = "color:#0072B2;",
                                                    title = "Tải trục xe nặng nhất (Rigid)"
                                                  )),
                                value = 180
)

# số trục xe quy đổi về trục số tiêu chuẩn 100 kN trục/làn.ngày đêm
UI_Total_Axle_Ntk <- numericInput(inputId = "Total_Axle_Ntk",
                                  label = tags$span("Total Axle per Day (Axle/Day):",
                                                    tags$i(
                                                      class = "glyphicon glyphicon-info-sign",
                                                      style = "color:#0072B2;",
                                                      title = "số trục xe quy đổi về trục số tiêu chuẩn 100 kN trục/làn.ngày đêm"
                                                    )),
                                  value = 1638
)

# Luật tăng trưởng xe trung bình (%/năm)
UI_Vehicle_Growth_q <- formatNumericInput(inputId = "Vehicle_Growth_q",
                                          label = tags$span("Vehicle Growth Rate (%/year):",
                                                            tags$i(
                                                              class = "glyphicon glyphicon-info-sign",
                                                              style = "color:#0072B2;",
                                                              title = "Luật tăng trưởng xe trung bình (%/năm). E.g., 6%, 7%, 8%"
                                                            )),
                                          format = "percentageUS2dec",
                                          value = 0.06,
                                          align = "left"
)

# Số trục xe quy đổi về trục tiêu chuẩn tích lũy trong thời hạn thiết kết Ne
UI_Total_Axle_Ne <- formatNumericInput(inputId = "Total_Axle_Ne",
                                       label = tags$span("Total Axle of Design Year:",
                                                         tags$i(
                                                           class = "glyphicon glyphicon-info-sign",
                                                           style = "color:#0072B2;",
                                                           title = "Số trục xe quy đổi về trục tiêu chuẩn tích lũy trong thời hạn thiết kết Ne"
                                                         )),
                                       value = 17070000,
                                       format = "dotDecimalCharCommaSeparator",
                                       align = "left"
)

# Chiều dày tầng mặt Pavement (hb) (m) 
UI_Depth_Pave_hc <- numericInput(inputId = "Depth_hc", label = NULL, value = 26, step = 1)

# Chiều dày móng trên Base (hb) (m) 
UI_Depth_Base_hb <- numericInput(inputId = "Depth_hb", label = NULL, value = 20, step = 1)

# Chiều dày móng dưới Subbase (hb) (m) 
UI_Depth_Subbase_h1 <- numericInput(inputId = "Depth_h1", label = NULL, value = 18, step = 1)

# Module Đàn Hồi Tầng Mặt Pavement (Ec) (MPa)
UI_Module_Pave_Ec <- numericInput(inputId = "Module_Ec", label = NULL, value = 31000)

# Module Đàn Hồi Móng Trên Base (Eb) (MPa)
UI_Module_Base_Eb <- numericInput(inputId = "Module_Eb", label = NULL, value = 1300)

# Module Đàn Hồi Móng Dưới Subbase (E1) (MPa)
UI_Module_Subbase_E1 <- numericInput(inputId = "Module_E1", label = NULL, value = 300)

# Hệ số Poisson Tầng Mặt Pavement (µc) 
UI_Poisson_Pave_mc <- numericInput(inputId = "Poisson_mc", label = NULL, value = .15)

# Hệ số Poisson Móng Trên Base (µb) 
UI_Poisson_Base_mb <- numericInput(inputId = "Poisson_mb", label = NULL, value = .2)

# Hệ số Poisson Móng Dưới Subbase (µ1) 
UI_Poisson_Subbase_m1 <- numericInput(inputId = "Poisson_m1", label = NULL, value = .35)

# Chiều dày tấm BT tầng mặt Pave (L) (m) 
UI_Length_Pave_L <- numericInput(inputId = "Length_Pave_L",
                                 label = tags$p("Slab Length (m):",
                                                   tags$i(
                                                     class = "glyphicon glyphicon-info-sign",
                                                     style = "color:#0072B2;",
                                                     title = "Chiều dày tấm BT tầng mặt Pave (L) (m)"
                                                   )),
                                 value = 4.8,
                                 step = 0.1
)

# Hệ số dãn nỡ một chiều của BTXM (αc)
UI_Expand_ac <- selectInput(inputId = "Expand_ac",
                            label = tags$p("Agrregate:",
                                              tags$i(
                                                class = "glyphicon glyphicon-info-sign",
                                                style = "color:#0072B2;",
                                                title = "Hệ số dãn nỡ một chiều của BTXM (αc)"
                                              )),
                            choices = c("Silica Rocks or Sandstone" = 12,
                                        "Gravel" = 11,
                                        "Granite" = 10,
                                        "Limestone" = 7),
                            selected = 10
)