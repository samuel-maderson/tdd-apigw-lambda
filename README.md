# TDD API Gateway Lambda

This repository demonstrates a **Test-Driven Development (TDD)** approach to building a serverless REST API using **AWS Lambda** and **API Gateway**, with infrastructure managed through **Terraform**.

---

## 🧰 Project Structure

```text
tdd-apigw-lambda/
├── modules/               # Terraform modules for reusable infrastructure components
├── src/                   # Source code for AWS Lambda functions
├── tests/                 # Unit and integration tests
├── main.tf                # Main Terraform configuration file
├── variables.tf           # Terraform variables definition
├── output.tf              # Terraform outputs
├── terraform.tfvars       # Terraform variable values
└── .gitignore             # Specifies intentionally untracked files to ignore
```

---

## 🚀 Getting Started

### Prerequisites

* [Terraform](https://www.terraform.io/downloads.html)
* [AWS CLI](https://aws.amazon.com/cli/) (configured with appropriate credentials)
* [Python 3.8+](https://www.python.org/downloads/)
* [pip](https://pip.pypa.io/en/stable/)

### Installation

1. **Clone the repository**

   ```bash
   git clone https://github.com/samuel-maderson/tdd-apigw-lambda.git
   cd tdd-apigw-lambda
   ```

2. **Set up a virtual environment and install dependencies**

   ```bash
   python3 -m venv venv
   source venv/bin/activate
   pip install -r requirements.txt
   ```

3. **Initialize and apply Terraform configurations**

   ```bash
   terraform init
   terraform plan
   terraform apply
   ```

> **Note:** Ensure your AWS credentials are properly configured before applying Terraform.

---

## 🧪 Running Tests

Tests are written using Python's built-in `unittest` framework. To run tests:

```bash
python -m unittest discover tests
```

This command will discover and run all tests in the `tests/` directory.

---

## 🛠️ Deployment

To deploy the infrastructure and Lambda functions, simply run:

```bash
terraform apply
```

Terraform provisions the necessary AWS resources as defined in the configuration files.

---

## 📄 API Endpoints

Once deployed, the API Gateway URL will be displayed in Terraform outputs. Test it using:

```bash
curl https://<api_gateway_url>/your-endpoint
```

> Replace `<api_gateway_url>` with the actual URL provided by Terraform.

---

## 📚 Resources

* [AWS Lambda Developer Guide](https://docs.aws.amazon.com/lambda/latest/dg/welcome.html)
* [AWS API Gateway Documentation](https://docs.aws.amazon.com/apigateway/latest/developerguide/welcome.html)
* [Terraform AWS Provider](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)

---

## 🤝 Contributing

Contributions are welcome! To contribute:

1. Fork the repository
2. Create a feature branch
3. Commit your changes
4. Open a pull request

---

## 📝 License

This project is licensed under the [MIT License](LICENSE).

---

> *This README is auto-generated and can be enhanced further as the project evolves.*