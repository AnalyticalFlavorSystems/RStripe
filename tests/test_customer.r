require(testthat)
context("customers")
source("../R/rstripe.r")
load("Stripe.RData")

api_key <- stripe[["api_key"]]


customer_no_card <- "cus_4ac4e16WSuoPaB"
customer_with_card <- "cus_4HCCy5KDhy18Oz"
charge <- "ch_4agjamrKIXQf1a"
now <- as.numeric(Sys.time())

test_delete <- function(api_key) {
    res <- stripe_create_customer(api_key)
    cust_id <- res$id 
    stripe_delete_customer(api_key, cust_id)
}

test_that("create customer works", {
          expect_that(stripe_create_customer(api_key)$object,
                      matches("customer"))
          expect_that(stripe_create_customer(api_key, list(description=paste(now)))$description,
                      matches(paste(now)))
          expect_that(stripe_create_customer(api_key,
                                             list(metadata=list(order_id=paste(now))))$metadata$order_id,
                      matches(paste(now)))

})
test_that("retrieve customer works", {
          expect_that(stripe_retrieve_customer(api_key, customer_with_card)$object,
                      matches("customer"))
})
test_that("update_customer_works", {
          expect_that(stripe_update_customer(api_key, customer_with_card,
                                             list(description=paste(now)))$description,
                      matches(paste(now)))
})
test_that("delete customer_works", {
          expect_that(test_delete(api_key),
                      equals(NULL))
})
test_that('list customers', {
          expect_that(stripe_list_customers(api_key)$data$object,
                      matches('customer'))
          expect_that(nrow(stripe_list_customers(api_key, list(limit=3))$data),
                      equals(3))
})
