# --------------------------------------------------
# Customers
# --------------------------------------------------
stripe_create_customer <- function(api_key, args=NULL) {
    args <- .card(args)
    args <- .metadata(args)
    link <- "https://api.stripe.com/v1/customers"
    .post(api_key, link, args)
}

stripe_retrieve_customer <- function(api_key, customer_id) {
    link <- paste0("https://api.stripe.com/v1/customers/",customer_id)
    .get(api_key, link)
}

stripe_update_customer <- function(api_key, customer_id, args) {
    args <- .card(args)
    args <- .metadata(args)
    link <- paste0("https://api.stripe.com/v1/customers/", customer_id)
    .post(api_key, link, args)
}

stripe_delete_customer <- function(api_key, customer_id) {
    link <- paste0("https://api.stripe.com/v1/customers/",customer_id)
    .delete(api_key, link)
}

stripe_list_customers <- function(api_key, args=NULL) {
    args <- .convert_to_url(args)
    link <- paste0("https://api.stripe.com/v1/customers", args)
    .get(api_key, link)
}
