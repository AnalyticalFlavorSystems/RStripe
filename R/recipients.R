# --------------------------------------------------
# Recipients
# --------------------------------------------------

#' Add a recipient to Stripe.
#'
#' Add a new recipient to your account to schedule transfers and more.
#'
#' @param api_key Your Stripe API Key
#'
#' @param args A required list that must contain \strong{name}
#' and \strong{type}. It can also contain \strong{tax_id},
#' \strong{bank_account}, \strong{card}, \strong{email},
#' \strong{description}, and/or \strong{metadata}.
#'
#' @return A data frame with new recipient information
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
#' @param args A list that can contain \strong{name}, \strong{tax_id},
#' \strong{bank_account}, \strong{card}, \strong{default_card}, \strong{email},
#' \strong{description}, and/or \strong{metadata}.
#'
#' @return A data frame with recipient information
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
#' @param args an optional list that can contain \strong{verified}
#' /strong{ending_before}, \strong{limit}, \strong{starting_after}
#'
#' @return A data frame with recipient's information
#' @export
#'
stripe_list_recipients <- function(api_key, args=NULL) {
    args <- .convert_to_url(args)
    link <- paste0("https://api.stripe.com/v1/recipients", args)
    .get(api_key, link)
}
