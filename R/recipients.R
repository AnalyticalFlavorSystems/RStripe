# --------------------------------------------------
# Recipients
# --------------------------------------------------

#' Add a recipient to Stripe.
#'
#' Add a new recipient to your account to schedule transfers and more.
#'
#' @param api_key Your Stripe API Key
#'
#' @param args A required list that must contain 
#' \describe{ 
#'    \item{name}{\strong{required} The legal name of recipient.}
#'    \item{type}{\strong{required} put 'individual' or 'corporation'.}
#'    \item{tax_id}{\emph{optional} The tax ID either 'SSN' for individual or 'EIN' for corporation}
#'    \item{bank_account}{\emph{optional} token or dictionary of details.}
#'    \item{card}{\emph{optional} A US Visa/Mastercard debit card to put transfer on.}
#'    \item{email}{\emph{optional} Recipients email address.}
#'    \item{description}{\emph{optional} Arbitrary string to describe.}
#'    \item{metadata}{\emph{optional} key/value for storing information.}
#' }
#'
#' @return A data frame with new recipient information
#'
#' @export
#'
stripe_create_recipient <- function(api_key, args) {
    link <- paste0("https://api.stripe.com/v1/recipients")
    .post(api_key, link, args)
}

#' Retrieve information on a recipient.
#'
#' Retrieve all the information on a recipient.
#'
#' @param api_key Your Stripe API Key
#'
#' @param recipient_id The id for the recipient you want to retrieve.
#'
#' @return A data frame with recipient information
#'
#' @export
#'
stripe_retrieve_recipient <- function(api_key, recipient_id) {
    link <- paste0("https://api.stripe.com/v1/recipients/", recipient_id)
    .get(api_key, link)
}

#' Update a recipient on Stripe.
#'
#' Update or add information about a recipient on stripe.
#'
#' @param api_key Your Stripe API Key
#'
#' @param recipient_id The id for the recipient you want to update.
#'
#' @param args A list that can contain 
#' \describe{
#'    \item{name}{\emph{optional} The legal name of recipient.}
#'    \item{tax_id}{\emph{optional} The tax ID either 'SSN' for individual or 'EIN' for corporation}
#'    \item{bank_account}{\emph{optional} token or dictionary of details.}
#'    \item{card}{\emph{optional} A US Visa/Mastercard debit card to put transfer on.}
#'    \item{email}{\emph{optional} Recipients email address.}
#'    \item{description}{\emph{optional} Arbitrary string to describe.}
#'    \item{metadata}{\emph{optional} key/value for storing information.}
#'    \item{default_card}{\emph{optional} The default card to sue.} 
#' }
#'
#' @return A data frame with recipient information
#'
#' @export
#'
stripe_update_recipient <- function(api_key, recipient_id, args) {
    args <- .metadata(args)
    link <- paste0("https://api.stripe.com/v1/recipients/", recipient_id)
    .post(api_key, link, args)
}

#' Delete a recipient on Stripe.
#'
#' Remove a recipient from your stripe account.
#'
#' @param api_key Your Stripe API Key
#'
#' @param recipient_id The id for the recipient you want to delete
#'
#' @return A data frame with recipient information
#'
#' @export
#'
stripe_delete_recipient <- function(api_key, recipient_id) {
    link <- paste0("https://api.stripe.com/v1/recipients/", recipient_id)
    .delete(api_key, link)
}

#' List all current recipients.
#'
#' List all the current recipients in your account.
#'
#' @param api_key Your Stripe API Key
#'
#' @param args an optional list that can contain: 
#' \describe{
#'    \strong{verified}{\emph{optional:} Show only verified recipients.}
#'    \item{ending_before}{\emph{optional:} An object id which will show objects before}
#'    \item{limit}{\emph{optional:} A number 1 to 100 to limit the items.  Default is 10}
#'    \item{starting_after}{\emph{optional:} An object id which will show objects starting here}
#' }
#'
#' @return A data frame with recipient's information
#'
#' @export
#'
stripe_list_recipients <- function(api_key, args=NULL) {
    args <- .convert_to_url(args)
    link <- paste0("https://api.stripe.com/v1/recipients", args)
    .get(api_key, link)
}
