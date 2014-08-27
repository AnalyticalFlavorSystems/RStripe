# --------------------------------------------------
# Transfers
# --------------------------------------------------

#' Create a transfer to Stripe.
#'
#' Create a new transfer that will be first marked as pending.
#'
#' @param api_key Your Stripe API Key
#'
#' @param args A list which must contain \strong{amount},
#' \strong{currency}, and \strong{recipient}. 
#' It can also contain \strong{description}, \strong{metadata},
#' \strong{bank_account}, \strong{card},
#' and \strong{statement_description}
#'
#' @return A data frame with transfer information
#' @export
#'
stripe_create_transfer <- function(api_key, args) {
    args <- .metadata(args)
    link <- paste0("https://api.stripe.com/v1/transfers")
    response <- POST(url = link, config=add_headers(Authorization=paste0("Bearer  ", api_key)),
                     body=args, encode="form")
    content(response)
}

#' Retrieve a transfer
#'
#' You can get all the information about a pending transfer or an accepted transfer.
#'
#' @param api_key Your Stripe API Key
#'
#' @param transfer_id The id of the transfer you want to retrieve
#'
#' @return A data frame with the transfer info if successful.
#' @export
#'
stripe_retrieve_transfer <- function(api_key, transfer_id) {
    response <- getURL(paste0("https://api.stripe.com/v1/transfers/", transfer_id),
                       userpwd=paste0(api_key, ":"))
    df <- fromJSON(response)
    return(df)
}

#' Update a Transfer
#'
#' You can update a transfer that is scheduled or has been accepted by changing description.
#'
#' @param api_key Your Stripe API Key
#'
#' @param transfer_id The id of the transfer you want to update
#'
#' @param args A list can contain 
#' \strong{metadata}, and \strong{description}
#'
#' @return A data frame with the updated transfer info if successful.
#' @export
#'
stripe_update_transfer <- function(api_key, transfer_id, args) {
    args <- .metadata(args)
    link <- paste0("https://api.stripe.com/v1/transfers/", transfer_id)
    response <- POST(url = link, config=add_headers(Authorization=paste0("Bearer  ", api_key)),
                     body=args, encode="form")
    content(response)
}

#' Cancel a transfer on Stripe.
#'
#' This will cancel a transfer that is scheduled.  
#'
#' @param api_key Your Stripe API Key
#'
#' @param transfer_id The id for the tranfer you want to cancel
#'
#' @return A data frame with nothing if successful.
#' @export
#'
stripe_cancel_transfer <- function(api_key, transfer_id) {
    link <- paste0("https://api.stripe.com/v1/transfers/", transfer_id, "/cancel")
    response <- POST(url = link, config=add_headers(Authorization=paste0("Bearer  ", api_key)))
    content(response)
}

#' List Transfers.
#'
#' List all the Bank Accoun transfers for the account.
#'
#' @param api_key Your Stripe API Key
#'
#' @param args an optional list that can contain \strong{date}
#' \strong{ending_before}, \strong{limit}, \strong{starting_after},
#' \strong{recipient}, and \strong{status}
#'
#' @return A data frame with transfers information
#' @export
#'
stripe_list_transfers <- function(api_key, args=NULL) {
    args <- .convert_to_url(args)
    response <- getURL(paste0("https://api.stripe.com/v1/transfers", args),
                       userpwd=paste0(api_key, ":"))
    df <- fromJSON(response)
    return(df)
}
