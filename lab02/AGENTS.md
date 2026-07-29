# iac-lab02-lambda

## Descripción

Laboratorio de infraestructura como código (IaC) que provisiona una función **AWS Lambda** con Python usando **Terraform**. El objetivo es aprender a desplegar una función Lambda simple, asignarle un rol IAM con los permisos mínimos necesarios y verificar su ejecución mediante la CLI de AWS.

---

## Estructura del repositorio

```
iac-lab02-lambda/
├── function/
│   └── lambda_function.py       # Código fuente de la función Lambda (Python 3.12)
├── build/
│   └── lambda_function.zip      # Artefacto generado por Terraform (no commitear)
├── main.tf                      # Recursos principales: Lambda, IAM Role, ZIP
├── variables.tf                 # Declaración de variables de entrada
├── outputs.tf                   # Outputs: nombre, ARN y comando de invocación
├── providers.tf                 # Configuración del provider AWS
├── versions.tf                  # Versiones requeridas de Terraform y providers
├── terraform.tfvars             # Valores de las variables (región, nombre, iniciales)
└── AGENTS.md                    # Este archivo
```

---

## Recursos desplegados

| Recurso | Tipo | Descripción |
|---|---|---|
| `aws_lambda_function.hola` | Lambda Function | Función Python 3.12, timeout 5s |
| `aws_iam_role.lambda_role` | IAM Role | Rol de ejecución para la función |
| `aws_iam_role_policy_attachment.lambda_basic_logs` | IAM Policy Attachment | Permisos básicos de ejecución y escritura en CloudWatch Logs |
| `archive_file.lambda_zip` | Data Source | Empaqueta `lambda_function.py` en un ZIP |

---

## Variables

| Variable | Descripción | Valor por defecto (`terraform.tfvars`) |
|---|---|---|
| `aws_region` | Región de AWS donde se despliegan los recursos | `us-east-1` |
| `lambda_name` | Nombre de la función Lambda | `lambda-hola-jb` |
| `student_initials` | Iniciales del alumno o grupo | `jb` |

---

## Providers y versiones

- **Terraform** `>= 1.6.0`
- **hashicorp/aws** `~> 5.0`
- **hashicorp/archive** `~> 2.4`

---

## Uso

### 1. Inicializar

```bash
terraform init
```

### 2. Revisar el plan

```bash
terraform plan
```

### 3. Aplicar

```bash
terraform apply
```

### 4. Invocar la función Lambda

Una vez desplegada, Terraform muestra el comando listo para usar en el output `invoke_command`:

```bash
aws lambda invoke \
  --function-name lambda-hola-jb \
  --payload '{}' \
  --cli-binary-format raw-in-base64-out \
  response.json
```

La respuesta se guarda en `response.json` con el cuerpo:

```json
{"statusCode": 200, "body": "hola desde lambda actualizado"}
```

### 5. Destruir los recursos

```bash
terraform destroy
```

---

## Outputs

| Output | Descripción |
|---|---|
| `lambda_function_name` | Nombre de la función Lambda creada |
| `lambda_function_arn` | ARN de la función Lambda |
| `invoke_command` | Comando AWS CLI listo para invocar la función |

---

## Notas

- El archivo `build/lambda_function.zip` es generado automáticamente por Terraform y está ignorado por Git.
- La variable de entorno `STUDENT_INITIALS` queda disponible dentro de la función Lambda como `os.environ["STUDENT_INITIALS"]` si se necesita en el código.
- Los logs de ejecución se publican en **Amazon CloudWatch Logs** gracias a la policy `AWSLambdaBasicExecutionRole`.
