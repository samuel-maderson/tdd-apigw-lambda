TDD API Gateway LambdaA sample project demonstrating Test-Driven Development (TDD) principles applied to building serverless applications using AWS API Gateway and AWS Lambda, managed with Terraform.DescriptionThis repository provides a practical example of how to implement a serverless backend using AWS Lambda functions triggered by AWS API Gateway, with a strong emphasis on Test-Driven Development and infrastructure management using Terraform. The project structure and accompanying tests are designed to showcase how writing tests before writing the application code can lead to a more robust, maintainable, and well-designed serverless application, with infrastructure defined as code.The focus is on unit and integration testing of the Lambda function logic and its interaction with the API Gateway event structure, alongside defining and deploying these resources using Terraform.FeaturesTest-Driven Development (TDD): Demonstrates the TDD workflow for serverless development.Terraform: Uses Terraform for defining and deploying the serverless infrastructure (API Gateway, Lambda).AWS Lambda: Example Node.js (or Python, depending on the actual repo content - assuming Node.js for this example) Lambda function.AWS API Gateway: Integration with Lambda for building a RESTful API.Automated Testing: Includes unit and integration tests for the Lambda function code.PrerequisitesBefore you begin, ensure you have the following installed and configured:AWS AccountAWS CLI configured with credentials and a default region.TerraformNode.js (LTS version recommended) and npm (or yarn/pnpm) - Adjust based on the Lambda runtime used in the repo.InstallationClone the repository:git clone https://github.com/samuel-maderson/tdd-apigw-lambda.git
cd tdd-apigw-lambda

Install Lambda function dependencies:Navigate into the Lambda function's source directory (e.g., src) and install its dependencies.# Example for a Node.js Lambda in a 'src' directory
cd src
npm install
# Or using yarn: yarn install
# Or using pnpm: pnpm install

Note: Adjust the directory and package manager command based on the actual project structure and language.Initialize Terraform:From the root of the repository, initialize the Terraform backend and modules.terraform init

Project StructureThe project structure typically includes Terraform configuration files, Lambda function source code, and test directories. A common structure might look like this (adjust based on the actual repository content):.
├── src/                 # Lambda function source code directory
│   ├── index.js         # Lambda handler code (or index.py for Python)
│   ├── package.json     # Node.js dependencies (or requirements.txt for Python)
│   └── tests/           # Unit and integration tests for the Lambda function
│       ├── unit/
│       └── integration/
├── terraform/           # Terraform configuration files
│   ├── main.tf          # Main Terraform configuration
│   ├── variables.tf     # Variable definitions
│   ├── outputs.tf       # Output definitions
│   └── versions.tf      # Terraform version constraints
└── README.md            # This file

Running TestsThe project includes automated tests for the Lambda function code. These tests are typically run using a language-specific test runner.Run unit tests:Navigate to the Lambda function's test directory and run the unit tests.# Example for Node.js using npm test in the source directory
cd src
npm test

Run integration tests:Integration tests might require the infrastructure to be deployed or mocked. Refer to the project's specific integration testing setup for details.# Example (assuming integration tests are run from the src directory)
cd src
npm run integration-test # or similar command defined in package.json

Note: The exact commands depend on the testing framework used (e.g., Jest, Mocha, Pytest) and how the tests are configured in the project's package.json or equivalent.DeploymentTo deploy the application infrastructure and code to your AWS account using Terraform:Review the execution plan:terraform plan

This command shows you what Terraform will do before it makes any changes.Apply the changes:terraform apply

Terraform will prompt you to confirm the actions before proceeding. Type yes to deploy the infrastructure.ContributingContributions are welcome! Please follow these steps:Fork the repository.Create a new branch (git checkout -b feature/your-feature).Make your code and infrastructure changes, writing tests (both code and potentially infrastructure tests) following the TDD approach where applicable.Ensure all tests pass (run code tests locally).Validate Terraform configuration (terraform validate) and review the plan (terraform plan).Commit your changes (git commit -m 'feat: Add your feature').Push to the branch (git push origin feature/your-feature).Create a Pull Request.LicenseThis project is licensed under the MIT License - see the LICENSE file for details.