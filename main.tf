module "apigw_lambda" {
  source = "./modules/apigw_lambda"

  apigw = {
    region = var.apigw.region
  }
}

module "step_functions" {
  source = "./modules/step_functions"

}