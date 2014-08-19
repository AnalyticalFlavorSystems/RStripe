# --------------------------------------------------
# Balance
# --------------------------------------------------
stripe_retrieve_balance <- function(api_key) {
    link <- paste0("https://api.stripe.com/v1/balance")
    .get(api_key, link)
}

stripe_retrieve_balance_transaction <- function(api_key, transaction_id) {
    link <- paste0("https://api.stripe.com/v1/balance/history/", transaction_id)
    .get(api_key, link)
}

stripe_balance_history <- function(api_key, args=NULL) {
    args <- .convert_to_url(args)
    link <- paste0("https://api.stripe.com/v1/balance/history", args)
    .get(api_key, link)
}
