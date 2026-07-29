variable "aws_region" {
  description = "Region de AWS donde se crean los recursos."
  type        = string
}

variable "lambda_name" {
  description = "Nombre de la funcion Lambda."
  type        = string
}

variable "student_initials" {
  description = "Iniciales del alumno o grupo."
  type        = string
}