# --------------------------------------------------
# Subscriptions
# --------------------------------------------------
stripe_create_subscription <- function(api_key, customer_id, args) {
    link <- paste0("https://api.stripe.com/v1/customers/",customer_id, "/subscriptions")
    .post(api_key, link, args)
}

stripe_retrieve_subscription <- function(api_key, customer_id, subscription_id) {
    link <- paste0("https://api.stripe.com/v1/customers/", customer_id, "/subscriptions/", subscription_id)
    .get(api_key, link)
}

stripe_update_subscription <- function(api_key, customer_id, subscription_id, args) {
    args <- .metadata(args)
    link <- paste0("https://api.stripe.com/v1/customers/",customer_id, "/subscriptions/",
                   subscription_id)
    .post(api_key, link, args)
}

stripe_delete_subscription <- function(api_key, customer_id, subscription_id) {
    link <- paste0("https://api.stripe.com/v1/customers/",customer_id, "/subscriptions/",
                   subscription_id)
    .delete(api_key, link)
}

stripe_list_subscriptions <- function(api_key, customer_id, args=NULL) {
    args <- .convert_to_url(args)
    link <- paste0("https://api.stripe.com/v1/customers/",customer_id, "/subscriptions", args)
    .get(api_key, link)
}
