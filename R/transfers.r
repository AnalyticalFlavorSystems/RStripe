# --------------------------------------------------
# Transfers
# --------------------------------------------------

#' Create a transfer to Stripe.
#'
#' @param api_key Your Stripe API Key
#' @param args A list which must contain \strong{amount},
#' \strong{currency}, and \strong{recipient}. 
#' It can also contain \strong{description}, \strong{metadata},
#' \strong{bank_account}, \strong{card},
#' and \strong{statement_description}
#' @export
#' @return A data frame with transfer information
stripe_create_transfer <- function(api_key, args) {
    args <- .metadata(args)
    link <- paste0("https://api.stripe.com/v1/transfers")
    response <- POST(url = link, config=add_headers(Authorization=paste0("Bearer  ", api_key)),
                     body=args, encode="form")
    content(response)
}

#' Retrieve a transfer
#'
#' @param api_key Your Stripe API Key
#' @param transfer_id The id of the transfer you want to retrieve
#' @export
#' @return A data frame with the transfer info if successful.
stripe_retrieve_transfer <- function(api_key, transfer_id) {
    response <- getURL(paste0("https://api.stripe.com/v1/transfers/", transfer_id),
                       userpwd=paste0(api_key, ":"))
    df <- fromJSON(response)
    return(df)
}

#' Update a Transfer
#'
#' @param api_key Your Stripe API Key
#' @param transfer_id The id of the transfer you want to update
#' @param args A list can contain 
#' \strong{metadata}, and \strong{description}
#' @export
#' @return A data frame with the updated transfer info if successful.
stripe_update_transfer <- function(api_key, transfer_id, args) {
    args <- .metadata(args)
    link <- paste0("https://api.stripe.com/v1/transfers/", transfer_id)
    response <- POST(url = link, config=add_headers(Authorization=paste0("Bearer  ", api_key)),
                     body=args, encode="form")
    content(response)
}

#' Cancel a tranfer on Stripe.
#'
#' @param api_key Your Stripe API Key
#' @param tranfer_id The id for the tranfer you want to cancel
#' @export
#' @return A data frame with nothing if successful.
stripe_cancel_transfer <- function(api_key, transfer_id) {
    link <- paste0("https://api.stripe.com/v1/transfers/", transfer_id, "/cancel")
    response <- POST(url = link, config=add_headers(Authorization=paste0("Bearer  ", api_key)))
    content(response)
}

#' List Transfers.
#'
#' @param api_key Your Stripe API Key
#' @param args an optional list that can contain \strong{date}
#' \strong{ending_before}, \strong{limit}, \strong{starting_after},
#' \strong{recipient}, and \strong{status}
#' @export
#' @return A data frame with transfers information
stripe_list_transfers <- function(api_key, args=NULL) {
    args <- .convert_to_url(args)
    response <- getURL(paste0("https://api.stripe.com/v1/transfers", args),
                       userpwd=paste0(api_key, ":"))
    df <- fromJSON(response)
    return(df)
}
