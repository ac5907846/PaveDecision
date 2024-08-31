# Toán đồ 3.1
UI_graph31_E0_E1 <- numericInput(inputId = "graph31_E0_E1",
                                 label = tags$span("E0/E1:",
                                                   tags$i(
                                                     class = "glyphicon glyphicon-info-sign",
                                                     style = "color:#0072B2;",
                                                     title = "E0/E1"
                                                   )),
                                 value = 0.098,
                                 step = 0.001
)

# Toán đồ 3.1
UI_graph31_H_D <- numericInput(inputId = "graph31_H_D",
                               label = tags$span("H/D:",
                                                   tags$i(
                                                     class = "glyphicon glyphicon-info-sign",
                                                     style = "color:#0072B2;",
                                                     title = "H/D"
                                                   )),
                               value = 1.91,
                               step = 0.01
)

# Toán đồ 3.3 H/D (x axis)
UI_graph33_H_D <- numericInput(inputId = "graph33_H_D",
                                 label = tags$span("H/D:",
                                                   tags$i(
                                                     class = "glyphicon glyphicon-info-sign",
                                                     style = "color:#0072B2;",
                                                     title = "H/D"
                                                   )),
                                 value = 1.91,
                                 step = 0.01
)

# Toán đồ 3.3 E1/E2 (curve line)
UI_graph33_E1_E2 <- numericInput(inputId = "graph33_E1_E2",
                               label = tags$span("E1/E2:",
                                                 tags$i(
                                                   class = "glyphicon glyphicon-info-sign",
                                                   style = "color:#0072B2;",
                                                   title = "E1/E2"
                                                 )),
                               value = 9.50,
                               step = 0.01
)

# Toán đồ 3.3 internal friction angle Phi (curve line)
UI_graph33_Phi <- numericInput(inputId = "graph33_Phi",
                                 label = tags$span("φ:",
                                                   tags$i(
                                                     class = "glyphicon glyphicon-info-sign",
                                                     style = "color:#0072B2;",
                                                     title = "Angle of internal friction φ"
                                                   )),
                                 value = 24,
                                 step = 1
)

# Toán đồ 3.4
UI_graph34_Htb <- numericInput(inputId = "graph34_Htb",
                                 label = tags$span("H",
                                                   tags$i(
                                                     class = "glyphicon glyphicon-info-sign",
                                                     style = "color:#0072B2;",
                                                     title = "Thickness of the whole pavement (cm). Chiều dày mặt đường (cm)."
                                                   )),
                                 value = 50,
                                 step = 1
)

# Toán đồ 3.4
UI_graph34_Phi <- numericInput(inputId = "graph34_Phi",
                               label = tags$span("φ",
                                                 tags$i(
                                                   class = "glyphicon glyphicon-info-sign",
                                                   style = "color:#0072B2;",
                                                   title = "Angle of internal friction φ"
                                                 )),
                               value = 26,
                               step = 1
)

# Toán đồ 3.5
UI_graph35_H_D <- numericInput(inputId = "graph35_H_D",
                               label = tags$span("H/D",
                                                 tags$i(
                                                   class = "glyphicon glyphicon-info-sign",
                                                   style = "color:#0072B2;",
                                                   title = "H/D"
                                                 )),
                               value = 0.182,
                               step = 0.001
)

# Toán đồ 3.5
UI_graph35_E1_Ech <- numericInput(inputId = "graph35_E1_Ech",
                               label = tags$span("E1/Ech.m",
                                                 tags$i(
                                                   class = "glyphicon glyphicon-info-sign",
                                                   style = "color:#0072B2;",
                                                   title = "E1/Ech.m"
                                                 )),
                               value = 8.043,
                               step = 0.001
)

# Toán đồ 3.6
UI_graph36_H_D <- numericInput(inputId = "graph36_H_D",
                               label = tags$span("H/D",
                                                 tags$i(
                                                   class = "glyphicon glyphicon-info-sign",
                                                   style = "color:#0072B2;",
                                                   title = "H/D"
                                                 )),
                               value = 0.848,
                               step = 0.001
)

# Toán đồ 3.6
UI_graph36_E1_E2 <- numericInput(inputId = "graph36_E1_E2",
                               label = tags$span("E1/E2",
                                                 tags$i(
                                                   class = "glyphicon glyphicon-info-sign",
                                                   style = "color:#0072B2;",
                                                   title = "E1/E2"
                                                 )),
                               value = 2.81,
                               step = 0.01
)

# Toán đồ 3.6
UI_graph36_E2_E3 <- numericInput(inputId = "graph36_E2_E3",
                                label = tags$span("E2/E3",
                                                  tags$i(
                                                    class = "glyphicon glyphicon-info-sign",
                                                    style = "color:#0072B2;",
                                                    title = "E2/E3"
                                                  )),
                                value = 5.17,
                                step = 0.01
)

