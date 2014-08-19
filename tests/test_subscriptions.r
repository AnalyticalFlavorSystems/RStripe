require(testthat)
context("subscriptions")
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

test_retrieve <- function(api_key, customer_id) {
    res <-stripe_create_subscription(api_key, customer_with_card,
                             args=list(plan=plan_id))
    subscription_id <- res$id
    stripe_retrieve_subscription(api_key, customer_id, subscription_id)
}
test_delete <- function(api_key, customer_id) {
    res <-stripe_create_subscription(api_key, customer_with_card,
                             args=list(plan=plan_id))
    subscription_id <- res$id
    stripe_delete_subscription(api_key, customer_id, subscription_id)
}

test_that("create subscription works", {
          expect_that(stripe_create_subscription(api_key,
                                         customer_with_card,
                                         args=list(plan=plan_id))$object,
                      matches("subscription"))
})

test_that("retrieve subscription works", {
          expect_that(test_retrieve(api_key, customer_with_card)$object,
                      matches("subscription"))
})
test_that("update subscription works", {
          expect_that(stripe_update_subscription(api_key, customer_with_card, subscription_id,
                                                 list(trial_end=as.integer(now + 20)))$trial_end,
                      matches(paste(as.integer(now + 20))))
})
test_that("delete subscription works", {
          expect_that(test_delete(api_key, customer_with_card)$object,
                      equals(NULL))
})

test_that("list subscriptions works", {
          expect_that(stripe_list_subscriptions(api_key, customer_with_card)$data$object,
                      matches("subscription"))
})
