# --------------------------------------------------
# Tokens
# --------------------------------------------------

#' Create a Card Token
#'
#' Create a card token to be used by other functions.  You can use this to create a charge,
#' or to attach to a customer.
#'
#' @param api_key Your Stripe API Key
#'
#' @param args A list which must contain card information including
#' \strong{number}, \strong{exp_month}, and \strong{exp_year}
#' It can also contain \strong{customer}.
#'
#' @examples stripe_create_card_token("sk_test_BQokikJOvBiI2HlWgH4olfQ2",
#' list(card=list(number="4242424242424242", exp_month="03", exp_year="2018")))
#'
#' @return A data frame with the new card token info if successful.
#' @export
#'
stripe_create_card_token <- function(api_key, args) {
    args <- .card(args)

    link <- paste0("https://api.stripe.com/v1/tokens")
    response <- POST(url = link, config=add_headers(Authorization=paste0("Bearer  ", api_key)),
                     body=args, encode="form")
    content(response)
}

#' Create a Bank Account Token
#'
#' Create a bank account token to schedule a transfer to a recipient.
#'
#' @param api_key Your Stripe API Key
#'
#' @param args A list which must contain bank account information including
#' \strong{country}, \strong{routing_number}, and \strong{account_number}
#'
#' @examples stripe_create_account_token("sk_test_BQokikJOvBiI2HlWgH4olfQ2",
#' list(card=list(country="US", routing_number="110000000", account_number="0000000014343")))
#'
#' @return A data frame with the new bank account token info if successful.
#' @export
#'
stripe_create_account_token <- function(api_key, args) {
    body <- .convert_to_subarray(args, "bank_account")
    link <- paste0("https://api.stripe.com/v1/tokens")
    response <- POST(url = link, config=add_headers(Authorization=paste0("Bearer  ", api_key)),
                     body=body)
    content(response)
}
