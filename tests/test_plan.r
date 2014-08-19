require(testthat)
context("plans")
source("../R/rstripe.r")
load("Stripe.RData")

api_key <- stripe[["api_key"]]


customer_no_card <- "cus_4ac4e16WSuoPaB"
customer_with_card <- "cus_4HCCy5KDhy18Oz"
charge <- "ch_4agjamrKIXQf1a"
card_id <- "card_4HCC7cgdKeNUEM"
plan_id <- "test-entry-level"
subscription_id <- "sub_4caNZqnNC0jO4n"
now <- as.numeric(Sys.time())

test_delete <- function(api_key) {
    res <-stripe_create_plan(api_key, args=list(id=paste(now), name=paste(now),
                                               amount=200, currency="usd", interval="year"))
    plan_id <- res$id
    stripe_delete_plan(api_key, plan_id)
}

test_that("create plan works", {
          expect_that(stripe_create_plan(api_key, args=list(id=paste(now), name=paste(now), amount=200, currency="usd",
                                                           interval="year"))$object,
                      matches("plan"))
})

test_that("retrieve plan works", {
          expect_that(stripe_retrieve_plan(api_key, plan_id)$object,
                      matches("plan"))
})
test_that("update plan works", {
          expect_that(stripe_update_subscription(api_key, customer_with_card, subscription_id,
                                                 list(metadata=list(order_id=paste(now))))$metadata$order_id,
                      matches(paste(now)))
})
test_that("delete plan works", {
          expect_that(test_delete(api_key)$object,
                      equals(NULL))
})

test_that("list plan works", {
          expect_that(stripe_list_plans(api_key)$data$object,
                      matches("plan"))
})
