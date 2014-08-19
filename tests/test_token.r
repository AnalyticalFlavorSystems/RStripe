require(testthat)
context("tokens")
source("../R/rstripe.r")
load("Stripe.RData")

api_key <- stripe[["api_key"]]


customer_no_card <- "cus_4ac4e16WSuoPaB"
customer_with_card <- "cus_4HCCy5KDhy18Oz"
charge <- "ch_4agjamrKIXQf1a"
now <- as.numeric(Sys.time())

test_that('create_token_works', {
          expect_that(stripe_create_card_token(api_key, list(card=list(number=4242424242424242,
                                                             exp_month=08, exp_year=2018)))$object,
                      matches('token'))
})
