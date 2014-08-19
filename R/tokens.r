# --------------------------------------------------
# Tokens
# --------------------------------------------------
stripe_create_card_token <- function(api_key, args) {
    args <- .card(args)

    link <- paste0("https://api.stripe.com/v1/tokens")
    response <- POST(url = link, config=add_headers(Authorization=paste0("Bearer  ", api_key)),
                     body=args, encode="form")
    content(response)
}

stripe_create_account_token <- function(api_key, args) {
    body <- .convert_to_subarray(args, "bank_account")
    link <- paste0("https://api.stripe.com/v1/tokens")
    response <- POST(url = link, config=add_headers(Authorization=paste0("Bearer  ", api_key)),
                     body=body)
    content(response)
}
