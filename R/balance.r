# --------------------------------------------------
# Balance
# --------------------------------------------------

#' Retrieve Stripe Account Balance.
#'
#' @param api_key Your Stripe API Key
#' @export
#' @return A data frame with your account balance
stripe_retrieve_balance <- function(api_key) {
    link <- paste0("https://api.stripe.com/v1/balance")
    .get(api_key, link)
}

#' Retrieve a Stripe Account Balance transaction.
#'
#' @param api_key Your Stripe API Key
#' @param transaction_id A stripe you want to get information about.
#' @export
#' @return A data frame with balance transaction information if succeeded.
stripe_retrieve_balance_transaction <- function(api_key, transaction_id) {
    link <- paste0("https://api.stripe.com/v1/balance/history/", transaction_id)
    .get(api_key, link)
}

#' Retrieve a Stripe Account Balance History.
#'
#' @param api_key Your Stripe API Key
#' @param args optional list which can include
#' \href{https://stripe.com/docs/api#balance_history}{everything here}
#' @export
#' @return A data frame with balance history information if succeeded.
stripe_balance_history <- function(api_key, args=NULL) {
    args <- .convert_to_url(args)
    link <- paste0("https://api.stripe.com/v1/balance/history", args)
    .get(api_key, link)
}
