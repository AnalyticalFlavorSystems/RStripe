# --------------------------------------------------
# Transfers
# --------------------------------------------------

#' Create a transfer to Stripe.
#'
#' Create a new transfer that will be first marked as pending.
#'
#' @param api_key Your Stripe API Key
#'
#' @param args A list of arguments
#' \describe{
#'    \item{amount}{\strong{required} Amount for transfer.}
#'    \item{currency}{\strong{required} The 3-letter currency.}
#'    \item{recipient}{\strong{required} The recipient id of the transfer.}
#'    \item{description}{\emph{optional} The description of the transfer.}
#'    \item{metadata}{\emph{optional} A list which can contain anything to further describe.}
#'    \item{bank_account}{\emph{optional} The bank to transfer money to.  Include this, card,
#'                        or neither.}
#'    \item{card}{\emph{optional} The card to transfer the money to. Include either Bank Account
#'                Card, or neither.}
#'    \item{statement_description}{\emph{optional} 15 character description to appear on
#'                                 statement.}
#' }
#'
#' @return A data frame with transfer information
#'
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
#'
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
#' \describe{
#'    \item{metadata}{\emph{optional} A list of metadata to include}
#'    \item{description}{\emph{optional} A string to describe the transfer}
#' }
#'
#' @return A data frame with the updated transfer info if successful.
#'
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
#'
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
#' @param args an optional list that can contain: 
#' \describe{
#'    \item{ending_before}{\emph{optional:} An object id which will show objects before}
#'    \item{limit}{\emph{optional:} A number 1 to 100 to limit the items.  Default is 10}
#'    \item{recipient}{\emph{optional:} The id of a recipient to limit to.}
#'    \item{starting_after}{\emph{optional:} An object id which will show objects starting here}
#'    \item{status}{\emph{optional:} transfers with: \strong{pending},
#'                  \strong{paid}, \strong{failed}}
#' }
#'
#' @return A data frame with transfers information
#'
#' @export
#'
stripe_list_transfers <- function(api_key, args=NULL) {
    args <- .convert_to_url(args)
    response <- getURL(paste0("https://api.stripe.com/v1/transfers", args),
                       userpwd=paste0(api_key, ":"))
    df <- fromJSON(response)
    return(df)
}
