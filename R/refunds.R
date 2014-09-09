# --------------------------------------------------
# Refunds
# --------------------------------------------------

#' Create a Refund
#'
#' Create a new refund on a charge.
#'
#' @param api_key Your Stripe API Key
#'
#' @param charge_id The id of the charge to refund.
#'
#' @param args A list can contain \strong{amount}, 
#' \describe{
#'    \item{amount}{\emph{required} An amount in cents to refund up to remaining charge.}
#'    \item{refund_application_fee}{\emph{required} true/false if fee should be refunded.
#'                                  If true, proportional amount of refund is refunded.}
#'    \item{metadata}{\emph{required} Any metadata to include on the refund.}
#' }
#'
#' @return A data frame with the new refund info if successful.
#' 
#' @export
#'
stripe_create_refund <- function(api_key, charge_id, args=NULL) {
    args <- .metadata(args)
    link <- paste0("https://api.stripe.com/v1/charges/",charge_id, "/refunds")
    .post(api_key, link, args)
}

#' Retrieve a refund.
#'
#' Retrieve all the information about a particular refund on a charge.
#'
#' @param api_key Your Stripe API Key
#'
#' @param charge_id The id of the charge with the refund.
#'
#' @param refund_id The id of the refund you want to retrieve
#'
#' @return A data frame with the refund info if successful.
#'
#' @export
#'
stripe_retrieve_refund <- function(api_key, charge_id, refund_id) {
    link <- paste0("https://api.stripe.com/v1/charges/",
                              charge_id, "/refunds/", refund_id)
    .get(api_key, link)
}

#' Update a Refund
#'
#' Update a refund with any metadata you want to include about the refund.
#'
#' @param api_key Your Stripe API Key
#'
#' @param charge_id The id of the charge with the refund.
#'
#' @param refund_id The id of the refund you want to update
#'
#' @param args A list can contain:
#' \describe{
#'    \item{metadata}{\emph{optional} Any metadata in a list to change for refund.}
#' }
#'
#' @return A data frame with the updated refund info if successful.
#'
#' @export
#'
stripe_update_refund <- function(api_key, charge_id, refund_id, args) {
    args <- .metadata(args)
    link <- paste0("https://api.stripe.com/v1/charges/",
                   charge_id, "/refunds/", refund_id)
    .post(api_key, link, args)
}

#' List Refunds
#'
#' List all the refunds that a charge has.  You can have multiple refunds per charge until the 
#' full amount is reached.
#'
#' @param api_key Your Stripe API Key
#'
#' @param charge_id The id of the charge with the refund.
#'
#' @param args an optional list that can contain:
#' \describe{
#'    \item{ending_before}{\emph{optional:} An object id which will show objects before}
#'    \item{limit}{\emph{optional:} A number 1 to 100 to limit the items.  Default is 10}
#'    \item{starting_after}{\emph{optional:} An object id which will show objects starting here}
#' }
#'
#' @return A data frame with refunds information
#'
#' @export
#'
stripe_list_refunds <- function(api_key, charge_id, args = NULL) {
    args <- .convert_to_url(args)
    link <-paste0("https://api.stripe.com/v1/charges/", charge_id, "/refunds", args)
    .get(api_key, link)
}

