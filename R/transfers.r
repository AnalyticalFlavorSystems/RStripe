# --------------------------------------------------
# Transfers
# --------------------------------------------------
stripe_create_transfer <- function(api_key, args) {
    args <- .metadata(args)
    link <- paste0("https://api.stripe.com/v1/transfers")
    response <- POST(url = link, config=add_headers(Authorization=paste0("Bearer  ", api_key)),
                     body=args, encode="form")
    content(response)
}

stripe_retrieve_transfer <- function(api_key, transfer_id) {
    response <- getURL(paste0("https://api.stripe.com/v1/transfers/", transfer_id),
                       userpwd=paste0(api_key, ":"))
    df <- fromJSON(response)
    return(df)
}

stripe_update_transfer <- function(api_key, transfer_id, args) {
    args <- .metadata(args)
    link <- paste0("https://api.stripe.com/v1/transfers/", transfer_id)
    response <- POST(url = link, config=add_headers(Authorization=paste0("Bearer  ", api_key)),
                     body=args, encode="form")
    content(response)
}

stripe_cancel_transfer <- function(api_key, transfer_id) {
    link <- paste0("https://api.stripe.com/v1/transfers/", transfer_id, "/cancel")
    response <- POST(url = link, config=add_headers(Authorization=paste0("Bearer  ", api_key)))
    content(response)
}

stripe_list_transfers <- function(api_key, args=NULL) {
    args <- .convert_to_url(args)
    response <- getURL(paste0("https://api.stripe.com/v1/transfers", args),
                       userpwd=paste0(api_key, ":"))
    df <- fromJSON(response)
    return(df)
}
