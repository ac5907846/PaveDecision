######################
# RIGID: UNIT COST
######################
## Unit cost of concrete pavement layer
UI_r_pave_unitcost <- numericInput(inputId = "r_pave_unitcost",
                                   label = tags$span("Concrete layer ($/m3)",
                                                     tags$i(
                                                       class = "glyphicon glyphicon-info-sign",
                                                       style = "color:#0072B2;",
                                                       title = "Concrete layer unit cost ($/m3)"
                                                     )),
                                   value = 55.11,
                                   step = 1
)

## Unit cost of base layer
UI_r_base_unitcost <- numericInput(inputId = "r_base_unitcost",
                                   label = tags$span("Base ($/m3)",
                                                     tags$i(
                                                       class = "glyphicon glyphicon-info-sign",
                                                       style = "color:#0072B2;",
                                                       title = "Base unit cost ($/m3)"
                                                     )),
                                   value = 14.84,
                                   step = 1
)

## Unit cost of subbase layer
UI_r_subbase_unitcost <- numericInput(inputId = "r_subbase_unitcost",
                                      label = tags$span("Subbase ($/m3)",
                                                        tags$i(
                                                          class = "glyphicon glyphicon-info-sign",
                                                          style = "color:#0072B2;",
                                                          title = "Subbase unit cost ($/m3)"
                                                        )),
                                      value = 13.99,
                                      step = 1
)

## Unit cost Longitudinal Joint
UI_r_long_joint_unitcost <- numericInput(inputId = "r_long_joint_unitcost",
                                      label = tags$span("Longitudinal Joint ($/m)",
                                                        tags$i(
                                                          class = "glyphicon glyphicon-info-sign",
                                                          style = "color:#0072B2;",
                                                          title = "Longitudinal Joint ($/m)"
                                                        )),
                                      value = 10.00,
                                      step = 1
)

## Unit cost of Transverse Joint
UI_r_tran_joint_unitcost <- numericInput(inputId = "r_tran_joint_unitcost",
                                      label = tags$span("Transverse Joint ($/m)",
                                                        tags$i(
                                                          class = "glyphicon glyphicon-info-sign",
                                                          style = "color:#0072B2;",
                                                          title = "Transverse Joint ($/m)"
                                                        )),
                                      value = 10.00,
                                      step = 1
)

######################
# FLEXIBLE: UNIT COST
######################
## Unit cost of top asphalt layer
UI_f_pave1_unitcost <- numericInput(inputId = "f_pave1_unitcost",
                                    label = tags$span("Top asphalt ($/m3)",
                                                      tags$i(
                                                        class = "glyphicon glyphicon-info-sign",
                                                        style = "color:#0072B2;",
                                                        title = "Top asphalt unit cost ($/m3)"
                                                      )),
                                    value = 76.32,
                                    step = 1
)


## Unit cost of bottom asphalt layer
UI_f_pave2_unitcost <- numericInput(inputId = "f_pave2_unitcost",
                                    label = tags$span("Bottom asphalt ($/m3)",
                                                      tags$i(
                                                        class = "glyphicon glyphicon-info-sign",
                                                        style = "color:#0072B2;",
                                                        title = "Bottom asphalt unit cost ($/m3)"
                                                      )),
                                    value = 76.32,
                                    step = 1
)


## Unit cost of base
UI_f_base_unitcost <- numericInput(inputId = "f_base_unitcost",
                                   label = tags$span("Base ($/m3)",
                                                     tags$i(
                                                       class = "glyphicon glyphicon-info-sign",
                                                       style = "color:#0072B2;",
                                                       title = "Base unit cost ($/m3)"
                                                     )),
                                   value = 14.84,
                                   step = 1
)


## Unit cost of subbase top
UI_f_sbase1_unitcost <- numericInput(inputId = "f_sbase1_unitcost",
                                     label = tags$span("Top subbase ($/m3)",
                                                       tags$i(
                                                         class = "glyphicon glyphicon-info-sign",
                                                         style = "color:#0072B2;",
                                                         title = "Top subbase unit cost ($/m3)"
                                                       )),
                                     value = 13.99,
                                     step = 1
)

## Unit cost of subbase bottom
UI_f_sbase2_unitcost <- numericInput(inputId = "f_sbase2_unitcost",
                               label = tags$span("Bottom subbase ($/m3)",
                                                 tags$i(
                                                   class = "glyphicon glyphicon-info-sign",
                                                   style = "color:#0072B2;",
                                                   title = "Bottom subbase unit cost ($/m3)"
                                                 )),
                               value = 11.02,
                               step = 1
)

## Unit cost of subbase bottom
UI_f_bonding_unitcost <- numericInput(inputId = "f_bonding_unitcost",
                                     label = tags$span("Bonding Layer ($/m2)",
                                                       tags$i(
                                                         class = "glyphicon glyphicon-info-sign",
                                                         style = "color:#0072B2;",
                                                         title = "Bonding Layer ($/m2)"
                                                       )),
                                     value = 0.3,
                                     step = 1
)

###########################
# Rebuild Rigid Pavement
###########################
UI_rebuild_r_pave <- checkboxInput(inputId = "rebuild_r_pave",
                                   label = tags$span("Rebuild Concrete",
                                                     tags$i(
                                                       class = "glyphicon glyphicon-info-sign",
                                                       style = "color:#0072B2;",
                                                       title = "Include concrete layer when reconstruct the rigid pavement structure"
                                                     )),
                                   value = TRUE
)

UI_rebuild_r_base <- checkboxInput(inputId = "rebuild_r_base",
                                   label = tags$span("Rebuild Base",
                                                     tags$i(
                                                       class = "glyphicon glyphicon-info-sign",
                                                       style = "color:#0072B2;",
                                                       title = "Include base when reconstruct the rigid pavement structure"
                                                     )),
                                   value = FALSE
)

UI_rebuild_r_subbase <- checkboxInput(inputId = "rebuild_r_subbase",
                                      label = tags$span("Rebuild Subbase",
                                                        tags$i(
                                                          class = "glyphicon glyphicon-info-sign",
                                                          style = "color:#0072B2;",
                                                          title = "Include subbase when reconstruct the rigid pavement structure"
                                                        )),
                                      value = FALSE
)

###########################
# Rebuild Flexible Pavement
###########################
UI_rebuild_f_pave1 <- checkboxInput(inputId = "rebuild_f_pave1",
                                   label = tags$span("Rebuild Top Aphalt",
                                                     tags$i(
                                                       class = "glyphicon glyphicon-info-sign",
                                                       style = "color:#0072B2;",
                                                       title = "Include top aphalt layer when reconstruct the flexible pavement structure"
                                                     )),
                                   value = TRUE
)

UI_rebuild_f_pave2 <- checkboxInput(inputId = "rebuild_f_pave2",
                                   label = tags$span("Rebuild Bottom Aphalt",
                                                     tags$i(
                                                       class = "glyphicon glyphicon-info-sign",
                                                       style = "color:#0072B2;",
                                                       title = "Include bottom aphalt layer when reconstruct the flexible pavement structure"
                                                     )),
                                   value = TRUE
)

UI_rebuild_f_base <- checkboxInput(inputId = "rebuild_f_base",
                                   label = tags$span("Rebuild Base",
                                                     tags$i(
                                                       class = "glyphicon glyphicon-info-sign",
                                                       style = "color:#0072B2;",
                                                       title = "Include base layer when reconstruct the flexible pavement structure"
                                                     )),
                                   value = FALSE
)

UI_rebuild_f_subbase1 <- checkboxInput(inputId = "rebuild_f_subbase1",
                                   label = tags$span("Rebuild Top Subbase",
                                                     tags$i(
                                                       class = "glyphicon glyphicon-info-sign",
                                                       style = "color:#0072B2;",
                                                       title = "Include top subbase layer when reconstruct the flexible pavement structure"
                                                     )),
                                   value = FALSE
)

UI_rebuild_f_subbase2 <- checkboxInput(inputId = "rebuild_f_subbase2",
                                   label = tags$span("Rebuild Bottom Subbase",
                                                     tags$i(
                                                       class = "glyphicon glyphicon-info-sign",
                                                       style = "color:#0072B2;",
                                                       title = "Include bottom subbase layer when reconstruct the flexible pavement structure"
                                                     )),
                                   value = FALSE
)

################################
# FLEXIBLE: MAINTENANCE + REPAIR
################################
# Maintenance cost % of flexible pavement
UI_flexible_f.M1P <- formatNumericInput(inputId = "f.M1P",
                                        label = tags$span("% Maintenance Cost:",
                                                          tags$i(
                                                            class = "glyphicon glyphicon-info-sign",
                                                            style = "color:#0072B2;",
                                                            title = "Maintenance cost % of flexible pavement"
                                                          )),
                                        format = "percentageUS2dec",
                                        value = 0.0006,
                                        align = "left"
)

# % Minor Repair cost of flexible pavement
UI_flexible_f.M2P <- formatNumericInput(inputId = "f.M2P",
                                        label = tags$span("% Minor Repair Cost:",
                                                          tags$i(
                                                            class = "glyphicon glyphicon-info-sign",
                                                            style = "color:#0072B2;",
                                                            title = "% Minor repair cost of flexible pavement"
                                                          )),
                                        format = "percentageUS2dec",
                                        value = 0.05,
                                        align = "left"
)

# % Major Repair cost of flexible pavement
UI_flexible_f.M3P <- formatNumericInput(inputId = "f.M3P",
                                        label = tags$span("% Major Repair Cost:",
                                                          tags$i(
                                                            class = "glyphicon glyphicon-info-sign",
                                                            style = "color:#0072B2;",
                                                            title = "% Major repair cost of flexible pavement"
                                                          )),
                                        format = "percentageUS2dec",
                                        value = 0.35,
                                        align = "left"
)

# Assessment time (yr) of flexible pavement
UI_flexible_f.na <- numericInput(inputId = "f.na",
                                 label = tags$span("Assesment Time (yr):",
                                                   tags$i(
                                                     class = "glyphicon glyphicon-info-sign",
                                                     style = "color:#0072B2;",
                                                     title = "Assessment time (yr) of flexible pavement"
                                                   )),
                                 value = 70
)

# Life-cycle time (yr) of flexible pavement
UI_flexible_f.n0 <- numericInput(inputId = "f.n0",
                                 label = tags$span("Life-Cycle Time (yr):",
                                                   tags$i(
                                                     class = "glyphicon glyphicon-info-sign",
                                                     style = "color:#0072B2;",
                                                     title = "Life-cycle time (yr) of flexible pavement"
                                                   )),
                                 value = 14
)

# Maintenance frequency (yr) of flexible pavement
UI_flexible_f.n1 <- numericInput(inputId = "f.n1",
                                 label = tags$span("Maintenance Freq. (yr):",
                                                   tags$i(
                                                     class = "glyphicon glyphicon-info-sign",
                                                     style = "color:#0072B2;",
                                                     title = "Maintenance frequency (yr) of flexible pavement"
                                                   )),
                                 value = 1
)

# Minor Repair frequency (yr) of flexible pavement
UI_flexible_f.n2 <- numericInput(inputId = "f.n2",
                                 label = tags$span("Minor Repair Freq. (yr):",
                                                   tags$i(
                                                     class = "glyphicon glyphicon-info-sign",
                                                     style = "color:#0072B2;",
                                                     title = "Minor repair frequency (yr) of flexible pavement"
                                                   )),
                                 value = 5
)

# Major Repair frequency (yr) of flexible pavement
UI_flexible_f.n3 <- numericInput(inputId = "f.n3",
                                 label = tags$span("Major Repair Freq. (yr):",
                                                   tags$i(
                                                     class = "glyphicon glyphicon-info-sign",
                                                     style = "color:#0072B2;",
                                                     title = "Major repair frequency (yr) of flexible pavement"
                                                   )),
                                 value = 12
)

# % Discount rate of flexible pavement
UI_flexible_f.ir <- formatNumericInput(inputId = "f.ir",
                                       label = tags$span("% Discount Rate:",
                                                         tags$i(
                                                           class = "glyphicon glyphicon-info-sign",
                                                           style = "color:#0072B2;",
                                                           title = "% Discount rate of flexible pavement"
                                                         )),
                                       format = "percentageUS2dec",
                                       value = 0.07,
                                       align = "left"
)

################################
# RIGID: MAINTENANCE + REPAIR
################################
# Maintenance cost % of rigid pavement
UI_rigid_r.M1P <- formatNumericInput(inputId = "r.M1P",
                                     label = tags$span("% Maintenance Cost:",
                                                       tags$i(
                                                         class = "glyphicon glyphicon-info-sign",
                                                         style = "color:#0072B2;",
                                                         title = "Maintenance cost % of rigid pavement"
                                                       )),
                                     format = "percentageUS2dec",
                                     value = 0.0004,
                                     align = "left"
)

# % Minor Repair cost of rigid pavement
UI_rigid_r.M2P <- formatNumericInput(inputId = "r.M2P",
                                     label = tags$span("% Minor Repair Cost:",
                                                       tags$i(
                                                         class = "glyphicon glyphicon-info-sign",
                                                         style = "color:#0072B2;",
                                                         title = "% Minor repair cost of rigid pavement"
                                                       )),
                                     format = "percentageUS2dec",
                                     value = 0.07,
                                     align = "left"
)

# % Major Repair cost of rigid pavement
UI_rigid_r.M3P <- formatNumericInput(inputId = "r.M3P",
                                     label = tags$span("% Major Repair Cost:",
                                                       tags$i(
                                                         class = "glyphicon glyphicon-info-sign",
                                                         style = "color:#0072B2;",
                                                         title = "% Major repair cost of rigid pavement"
                                                       )),
                                     format = "percentageUS2dec",
                                     value = 0.45,
                                     align = "left"
)

# Assessment time (yr) of rigid pavement
UI_rigid_r.na <- numericInput(inputId = "r.na",
                              label = tags$span("Assesment Time (yr):",
                                                tags$i(
                                                  class = "glyphicon glyphicon-info-sign",
                                                  style = "color:#0072B2;",
                                                  title = "Assessment time (yr) of rigid pavement"
                                                )),
                              value = 70
)

# Life-cycle time (yr) of rigid pavement
UI_rigid_r.n0 <- numericInput(inputId = "r.n0",
                              label = tags$span("Life-Cycle Time (yr):",
                                                tags$i(
                                                  class = "glyphicon glyphicon-info-sign",
                                                  style = "color:#0072B2;",
                                                  title = "Life-cycle time (yr) of rigid pavement"
                                                )),
                              value = 30
)

# Maintenance frequency (yr) of rigid pavement
UI_rigid_r.n1 <- numericInput(inputId = "r.n1",
                              label = tags$span("Maintenance Freq. (yr):",
                                                tags$i(
                                                  class = "glyphicon glyphicon-info-sign",
                                                  style = "color:#0072B2;",
                                                  title = "Maintenance frequency (yr) of rigid pavement"
                                                )),
                              value = 1
)

# Minor Repair frequency (yr) of rigid pavement
UI_rigid_r.n2 <- numericInput(inputId = "r.n2",
                              label = tags$span("Minor Repair Freq. (yr):",
                                                tags$i(
                                                  class = "glyphicon glyphicon-info-sign",
                                                  style = "color:#0072B2;",
                                                  title = "Minor repair frequency (yr) of rigid pavement"
                                                )),
                              value = 9
)

# Major Repair frequency (yr) of rigid pavement
UI_rigid_r.n3 <- numericInput(inputId = "r.n3",
                              label = tags$span("Major Repair Freq. (yr):",
                                                tags$i(
                                                  class = "glyphicon glyphicon-info-sign",
                                                  style = "color:#0072B2;",
                                                  title = "Major repair frequency (yr) of rigid pavement"
                                                )),
                              value = 20
)

# % Discount rate of rigid pavement
UI_rigid_r.ir <- formatNumericInput(inputId = "r.ir",
                                    label = tags$span("% Discount Rate:",
                                                      tags$i(
                                                        class = "glyphicon glyphicon-info-sign",
                                                        style = "color:#0072B2;",
                                                        title = "% Discount rate of rigid pavement"
                                                      )),
                                    format = "percentageUS2dec",
                                    value = 0.07,
                                    align = "left"
)