require(testthat)
context("charges")
source("../R/rstripe.r")
load("Stripe.RData")

api_key <- stripe[["api_key"]]
customer_no_card <- "cus_4ac4e16WSuoPaB"
customer_with_card <- "cus_4HCCy5KDhy18Oz"
charge <- "ch_4agjamrKIXQf1a"
now <- as.numeric(Sys.time())

test_create_refund <- function(api_key, args) {
    res <- stripe_create_charge(api_key, args[[1]])
    charge_id <- res$id
    stripe_create_refund(api_key, charge_id, args[[2]])
}
test_retrieve_refund <- function(api_key, args) {
    res <- stripe_create_charge(api_key, args[[1]])
    charge_id <- res$id
    res2 <- stripe_create_refund(api_key, charge_id, args[[2]])
    refund_id <- res2$id
    stripe_retrieve_refund(api_key, charge_id, refund_id)
}
test_update_refund <- function(api_key, args) {
    res <- stripe_create_charge(api_key, args[[1]])
    charge_id <- res$id
    res2 <- stripe_create_refund(api_key, charge_id, args[[2]])
    refund_id <- res2$id
    stripe_update_refund(api_key, charge_id, refund_id, args[[3]])
}
test_list_refund <- function(api_key, args) {
    res <- stripe_create_charge(api_key, args[[1]])
    charge_id <- res$id
    res2 <- stripe_create_refund(api_key, charge_id, args[[2]])
    print(stripe_list_refunds(api_key, charge_id))
}



test_that("can create refund", {
          expect_that(test_create_refund(api_key, list(list(amount=100, 
                                                            currency="usd", customer=customer_with_card),
                                                       list()))$object,
                      matches("refund"))
          expect_that(test_create_refund(api_key, list(list(amount=100, 
                                                            currency="usd", customer=customer_with_card),
                                                       list(amount=20)))$amount,
                      equals(20))
          expect_that(test_create_refund(api_key, list(list(amount=100, 
                                                            currency="usd", customer=customer_with_card),
                                                       list(amount=20, metadata=list(order_id="1234"))))$metadata$order_id,
                      matches("1234"))
})

test_that("can retrieve refund", {
          expect_that(test_retrieve_refund(api_key, list(list(amount=100, 
                                                            currency="usd", customer=customer_with_card),
                                                       list()))$object,
                      matches("refund"))
})
test_that("can update refund", {
          expect_that(test_update_refund(api_key, list(list(amount=100,
                                                            currency="usd", customer=customer_with_card),
                                                       list(),
                                                       list(metadata=list(order_id="1234"))))$metadata$order_id,
                                         matches("1234"))
})

test_that("can list refunds", {
          expect_that(test_list_refund(api_key, list(list(amount=100,
                                                            currency="usd", customer=customer_with_card),
                                                       list()))$object,
                                         matches("list"))
})
