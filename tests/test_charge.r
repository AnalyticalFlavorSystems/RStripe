require(testthat)
context("charges")
source("../R/rstripe.r")
load("Stripe.RData")

api_key <- stripe[["api_key"]]


customer_no_card <- "cus_4ac4e16WSuoPaB"
customer_with_card <- "cus_4HCCy5KDhy18Oz"
charge <- "ch_4agjamrKIXQf1a"
now <- as.numeric(Sys.time())
test_that("create_charge works", {
          expect_that(stripe_create_charge(api_key,
                                           list(amount=200, currency="usd",
                                                customer=customer_with_card))$amount,
                      equals(200))
          expect_that(stripe_create_charge(api_key,
                                           list(amount=200, currency="usd",
                                                customer=customer_no_card))$error$type,
                      matches("card_error"))
          expect_that(stripe_create_charge(api_key,
                                           list(currency="usd",
                                                customer=customer_with_card))$error$type,
                      matches("invalid_request_error"))
          expect_that(stripe_create_charge("", list(currency="usd", amount=200,
                                                customer=customer_with_card))$error$type,
                      matches("invalid_request_error"))

})

test_that("can retrieve charge", {
          expect_that(stripe_retrieve_charge(api_key, charge)$amount, equals(200))
})
test_that("can update charge", {
          expect_that(stripe_update_charge(api_key, charge,
                                           list(description=paste("time is", now)))$description, matches(paste("time is", now)))
          expect_that(stripe_update_charge(api_key, charge,
                                           list(metadata=list(order_number=paste("time:", now))))$metadata$order_number,
                      matches(paste("time:", now)))
})
### capture
test_capture <- function(api_key, args) {
     res <- stripe_create_charge(api_key, args)
    charge_id <- res$id
    stripe_capture_charge(api_key, charge_id)
}

test_that('can caputure charge', {
          expect_that(test_capture(api_key, list(capture="false", amount=100,
                                                 currency="usd", customer=customer_with_card))$object, matches("charge"))
          expect_that(test_capture(api_key, list(capture=FALSE, amount=100,
                                                 currency="usd", customer=customer_with_card))$object, matches("charge"))
})
test_that('can list charges', {
          expect_that(stripe_list_charges(api_key)$data$object, matches("charge"))
          expect_that(nrow(stripe_list_charges(api_key, list(limit=3))$data), equals(3))
})


