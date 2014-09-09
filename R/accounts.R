# --------------------------------------------------
# Account
# --------------------------------------------------

#' Your Stripe Account.
#'
#' Retrieve your account.
#'
#' @param api_key Your Stripe API key
#'
#' @examples
#' \dontrun{stripe_retrieve_account("sk_test_2337VDxzNLS332zsso")}
#'
#' @return Your account information in a data frame.
#'
#' @export
#'
stripe_retrieve_account <- function(api_key) {
    link <- paste0("https://api.stripe.com/v1/account")
    .get(api_key, link)
}
