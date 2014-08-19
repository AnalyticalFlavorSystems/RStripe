# --------------------------------------------------
# Discounts
# --------------------------------------------------
stripe_delete_customer_discount <- function(api_key, customer_id) {
    link <- paste0("https://api.stripe.com/v1/customers/", customer_id, "/discount")
    .delete(api_key, link)
}

stripe_delete_subscription_discount <- function(api_key, customer_id, subscription_id) {
    link <- paste0("https://api.stripe.com/v1/customers/", customer_id,
                   "/subscriptions/", subscription_id, "/discount")
    .delete(api_key, link)
}
