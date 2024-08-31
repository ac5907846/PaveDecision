my_paragraph <- function() {
  "This is a paragraph of text. It can be used to provide some explanatory text or additional information to users of the app."
}

my_table <- function() {
  data <- data.frame(
    fruit = c("apple", "banana", "orange"),
    price = c(0.5, 0.3, 0.4)
  )
  tableOutput("my_table_output")
}