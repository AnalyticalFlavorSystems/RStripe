require(testthat)
context("cards")
source("../R/rstripe.r")
load("Stripe.RData")

api_key <- stripe[["api_key"]]


customer_no_card <- "cus_4ac4e16WSuoPaB"
customer_with_card <- "cus_4HCCy5KDhy18Oz"
charge <- "ch_4agjamrKIXQf1a"
card_id <- "card_4HCC7cgdKeNUEM"
now <- as.numeric(Sys.time())

test_retrieve <- function(api_key, customer_id) {
    res <-stripe_create_card(api_key, customer_with_card,
                             args=list(card=list(number="4242424242424242",
                                                 exp_month="03",
                                                 exp_year="2016")))
    card_id <- res$id
    stripe_retrieve_card(api_key, card_id, customer_id)
}
test_delete <- function(api_key, customer_id) {
    res <-stripe_create_card(api_key, customer_with_card,
                             args=list(card=list(number="4242424242424242",
                                                 exp_month="03",
                                                 exp_year="2016")))
    card_id <- res$id
    stripe_delete_card(api_key, customer_id, card_id)
}

test_that("create card works", {
          expect_that(stripe_create_card(api_key,
                                         customer_with_card,
                                         args=list(card=list(number="4242424242424242", exp_month="03", exp_year="2016")))$object,
                      matches("card"))
})

test_that("retrieve card works", {
          expect_that(test_retrieve(api_key, customer_with_card)$object,
                      matches("card"))
})
test_that("update card works", {
          expect_that(stripe_update_card(api_key, customer_with_card, card_id, list(name=paste(now)))$name,
                      matches(paste(now)))
})
test_that("delete card works", {
          expect_that(test_delete(api_key, customer_with_card)$object,
                      equals(NULL))
})

test_that("list cards works", {
          expect_that(stripe_list_cards(api_key, customer_with_card)$data$object,
                      matches("card"))
})
