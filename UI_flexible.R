# Helper function to create info icon span elements
infoIconSpan <- function(label, title, margin_bottom = "1em") {
  tags$p(
    label,
    tags$i(
      class = "glyphicon glyphicon-info-sign",
      style = "color:#0072B2;",
      title = title
    ),
    style = paste0("font-weight: bold; margin-bottom: ", margin_bottom, ";")
  )
}

# Chiều dày móng dưới subbase lớp 2 (cm)
UI_sbase2_h <- numericInput(inputId = "sbase2_h",label = NULL,value = 18)

# Chiều dày móng dưới subbase lớp 1 (cm)
UI_sbase1_h <- numericInput(inputId = "sbase1_h",label = NULL,value = 17)

# Chiều dày móng trên (cm)
UI_base_h <- numericInput(inputId = "base_h",label = NULL,value = 14)

# Chiều dày asphalt layer 2 (cm)
UI_pave2_h <- numericInput(inputId = "pave2_h",label = NULL,value = 8)

# Chiều dày asphalt layer 1 (cm)
UI_pave1_h <- numericInput(inputId = "pave1_h",label = NULL,value = 6)

# E võng của móng dưới lớp 2 (MPa)
UI_sbase2_Edel <- numericInput(inputId = "sbase2_Edel",label = NULL,value = 250)

# E võng của móng dưới lớp 1 (MPa)
UI_sbase1_Edel <- numericInput(inputId = "sbase1_Edel",label = NULL,value = 300)

# E võng của móng trên (MPa)
UI_base_Edel <- numericInput(inputId = "base_Edel",label = NULL,value = 600)

# E võng của asphalt lớp 2 (MPa)
UI_pave2_Edel <- numericInput(inputId = "pave2_Edel",label = NULL,value = 350)

# E võng của asphalt lớp 1 (MPa)
UI_pave1_Edel <- numericInput(inputId = "pave1_Edel",label = NULL,value = 420)

# E trượt của móng dưới lớp 2 (MPa)
UI_sbase2_Ev <- numericInput(inputId = "sbase2_Ev",label = NULL,value = 250)

# E trượt của móng dưới lớp 1 (MPa)
UI_sbase1_Ev <- numericInput(inputId = "sbase1_Ev",label = NULL,value = 300)

# E trượt của móng trên (MPa)
UI_base_Ev <- numericInput(inputId = "base_Ev",label = NULL,value = 600)

# E trượt của asphalt lớp 2 (MPa)
UI_pave2_Ev <- numericInput(inputId = "pave2_Ev",label = NULL,value = 250)

# E trượt của asphalt lớp 1 (MPa)
UI_pave1_Ev <- numericInput(inputId = "pave1_Ev",label = NULL,value = 300)

# E kéo uốn của móng dưới lớp 2 (MPa)
UI_sbase2_Eb <- numericInput(inputId = "sbase2_Eb",label = NULL,value = 250)

# E kéo uốn của móng dưới lớp 1 (MPa)
UI_sbase1_Eb <- numericInput(inputId = "sbase1_Eb",label = NULL,value = 300)

# E kéo uốn của móng trên (MPa)
UI_base_Eb <- numericInput(inputId = "base_Eb",label = NULL,value = 600)

# E kéo uốn của asphalt lớp 2 (MPa)
UI_pave2_Eb <- numericInput(inputId = "pave2_Eb",label = NULL,value = 1600)

# E kéo uốn của asphalt lớp 1 (MPa)
UI_pave1_Eb <- numericInput(inputId = "pave1_Eb",label = NULL,value = 1800)

# Cường độ kéo uốn giới hạn của móng trên (MPa)
UI_base_Rku <- numericInput(inputId = "base_Rku",label = NULL,value = 0.8)

# Cường độ kéo uốn giới hạn của asphalt lớp 2 (MPa)
UI_pave2_Rku <- numericInput(inputId = "pave2_Rku",label = NULL,value = 2.0)

# Cường độ kéo uốn giới hạn của asphalt lớp 1 (MPa)
UI_pave1_Rku <- numericInput(inputId = "pave1_Rku",label = NULL,value = 2.8)

# E võng của đất nền (MPa)
UI_sgrade_Edel <- numericInput(inputId = "sgrade_Edel",
                               label = tags$span("Subgrade Elastic Modulus (MPa)",
                                              tags$i(
                                                class = "glyphicon glyphicon-info-sign",
                                                style = "color:#0072B2;",
                                                title = "Xác định hệ số k3 dựa trên loại đất nền"
                                              )),
                               value = 42
)

# Độ dính của của đất nền (MPa)
UI_sgrade_cohesion <- numericInput(inputId = "sgrade_cohesion",
                                   label = tags$span("Subgrade Cohesion c (MPa)",
                                                  tags$i(
                                                    class = "glyphicon glyphicon-info-sign",
                                                    style = "color:#0072B2;",
                                                    title = "Độ dính của của đất nền c (MPa)"
                                                  )),
                                   value = 0.032
)

# Góc ma sát trong của của đất nền (°)
UI_sgrade_phi <- numericInput(inputId = "sgrade_phi",
                              label = tags$span("Subgrade Internal Friction φ (°)",
                                             tags$i(
                                               class = "glyphicon glyphicon-info-sign",
                                               style = "color:#0072B2;",
                                               title = "Góc ma sát trong của của đất nền φ (°)"
                                             )),
                              value = 24
)

# Hệ số k3 trang 48
UI_sgrade_k3_v <- selectInput(inputId = "sgrade_k3_v",
                       label = tags$span("Type of subgrade soil",
                                      tags$i(
                                        class = "glyphicon glyphicon-info-sign",
                                        style = "color:#0072B2;",
                                        title = "Xác định hệ số k3 dựa trên loại đất nền"
                                      )),
                       choices = c("Cohesive soil" = 1.5,
                                   "Small grain sand" = 3.0,
                                   "Medium grain sand" = 6.0,
                                   "Large grain sand" = 7.0),
                       selected = 1.5
)

# Overwirte the Eyc
UI_Eyc_special <- numericInput(inputId = "Eyc_special",
                               label = tags$span("Overwrite the Eyc",
                                                 tags$i(
                                                   class = "glyphicon glyphicon-info-sign",
                                                   style = "color:#0072B2;",
                                                   title = "Trường hợp đặt biệc của Eyc"
                                                 )),
                               value = 0
)