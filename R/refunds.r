# --------------------------------------------------
# Refunds
# --------------------------------------------------

#' Create a Refund
#'
#' @param api_key Your Stripe API Key
#' @param charge_id The id of the charge to refund.
#' @param args A list can contain \strong{amount}, 
#' \strong{refund_application_fee}, and \strong{metadata}
#' @export
#' @return A data frame with the new refund info if successful.
stripe_create_refund <- function(api_key, charge_id, args=NULL) {
    args <- .metadata(args)
    link <- paste0("https://api.stripe.com/v1/charges/",charge_id, "/refunds")
    .post(api_key, link, args)
}

#' Retrieve a refund.
#'
#' @param api_key Your Stripe API Key
#' @param charge_id The id of the charge with the refund.
#' @param refund_id The id of the refund you want to retrieve
#' @export
#' @return A data frame with the refund info if successful.
stripe_retrieve_refund <- function(api_key, charge_id, refund_id) {
    link <- paste0("https://api.stripe.com/v1/charges/",
                              charge_id, "/refunds/", refund_id)
    .get(api_key, link)
}

#' Update a Refund
#'
#' @param api_key Your Stripe API Key
#' @param charge_id The id of the charge with the refund.
#' @param refund_id The id of the refund you want to update
#' @param args A list can contain \strong{metadata}.
#' @export
#' @return A data frame with the updated refund info if successful.
stripe_update_refund <- function(api_key, charge_id, refund_id, args) {
    args <- .metadata(args)
    link <- paste0("https://api.stripe.com/v1/charges/",
                   charge_id, "/refunds/", refund_id)
    .post(api_key, link, args)
}

#' List Refunds
#'
#' @param api_key Your Stripe API Key
#' @param charge_id The id of the charge with the refund.
#' @param args an optional list that can contain
#' /strong{ending_before}, \strong{limit}, \strong{starting_after}
#' @export
#' @return A data frame with refunds information
stripe_list_refunds <- function(api_key, charge_id, args = NULL) {
    args <- .convert_to_url(args)
    link <-paste0("https://api.stripe.com/v1/charges/", charge_id, "/refunds", args)
    .get(api_key, link)
}

