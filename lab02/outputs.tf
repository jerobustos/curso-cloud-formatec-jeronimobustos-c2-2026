output "lambda_function_name" {
  description = "Nombre de la funcion Lambda creada."
  value       = aws_lambda_function.hola.function_name
}

output "lambda_function_arn" {
  description = "ARN de la funcion Lambda creada."
  value       = aws_lambda_function.hola.arn
}

output "invoke_command" {
  description = "Comando AWS CLI para invocar la funcion Lambda."
  value       = "aws lambda invoke --function-name ${aws_lambda_function.hola.function_name} --payload '{}' --cli-binary-format raw-in-base64-out response.json"
}