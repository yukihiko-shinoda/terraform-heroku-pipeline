provider "heroku" {
  version = "= 1.7.1"
  email   = "${var.heroku_email}"
  api_key = "${var.heroku_api_key}"
}

data "heroku_app" "staging" {
  name   = "futureys-django2-staging"
}

data "heroku_app" "production" {
  name   = "futureys-django2-production"
}

resource "heroku_pipeline" "django2" {
  name = "django2"
}

# Couple apps to different pipeline stages
resource "heroku_pipeline_coupling" "staging" {
  app      = "${data.heroku_app.staging.name}"
  pipeline = "${heroku_pipeline.django2.id}"
  stage    = "staging"
}

resource "heroku_pipeline_coupling" "production" {
  app      = "${data.heroku_app.production.name}"
  pipeline = "${heroku_pipeline.django2.id}"
  stage    = "production"
}
