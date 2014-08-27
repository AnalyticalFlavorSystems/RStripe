# --------------------------------------------------
# Balance
# --------------------------------------------------

#' Retrieve Stripe Account Balance.
#'
#' Retrieve the balance of your stripe account.
#'
#' @param api_key Your Stripe API Key
#'
#' @return A data frame with your account balance
#' @export
#'
stripe_retrieve_balance <- function(api_key) {
    link <- paste0("https://api.stripe.com/v1/balance")
    .get(api_key, link)
}

#' Retrieve a Stripe Account Balance transaction.
#'
#' Retrieve information about a transaction on your account.
#'
#' @param api_key Your Stripe API Key
#'
#' @param transaction_id A stripe you want to get information about.
#'
#' @return A data frame with balance transaction information if succeeded.
#' @export
#'
stripe_retrieve_balance_transaction <- function(api_key, transaction_id) {
    link <- paste0("https://api.stripe.com/v1/balance/history/", transaction_id)
    .get(api_key, link)
}

#' Retrieve a Stripe Account Balance History.
#'
#' Retrieve the history of your account balance.
#'
#' @param api_key Your Stripe API Key
#'
#' @param args optional list which can include
#' \url{https://stripe.com/docs/api#balance_history}.
#'
#' @return A data frame with balance history information if succeeded.
#' @export
#'
stripe_balance_history <- function(api_key, args=NULL) {
    args <- .convert_to_url(args)
    link <- paste0("https://api.stripe.com/v1/balance/history", args)
    .get(api_key, link)
}
