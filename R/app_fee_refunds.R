# --------------------------------------------------
# Application Fee Refunds
# --------------------------------------------------

#' Create a refund for an Application Fee.
#'
#' @param api_key Your Stripe API Key
#' @param app_fee_id The id for the Application Fee
#' you want to refund
#' @param args An optional list which can contain an amount to refund
#' \emph{default is entire fee} and metadata
#' @export
#' @examples stripe_create_app_fee_refund("sk_test_BQokikJOvBiI2HlWgH4olfQ2", "fee_4cbC9iLv8PdUnk")
#' @examples stripe_create_app_fee_refund("sk_test_BQokikJOvBiI2HlWgH4olfQ2", "fee_4cbC9iLv8PdUnk",
#' list(amount=100))
#' @examples stripe_create_app_fee_refund("sk_test_BQokikJOvBiI2HlWgH4olfQ2", "fee_4cbC9iLv8PdUnk",
#' list(metadata=list(reason="Accidental charge")))
#' @return A data frame with refund information
stripe_create_app_fee_refund <- function(api_key, app_fee_id, args=NULL) {
    link <- paste0("https://api.stripe.com/v1/application_fees/", app_fee_id, "/refunds")
    .post(api_key, link, args)
}

#' Retrieve an existing refund for an Application Fee.
#'
#' @param api_key Your Stripe API Key
#' @param app_fee_id The id for the Application Fee
#' you want to refund
#' @param refund_id The id for the Refund 
#' you want to retrieve
#' @export
#' @return A data frame with refund information
stripe_retrieve_app_fee_refund <- function(api_key, app_fee_id, refund_id) {
    link <- paste0("https://api.stripe.com/v1/application_fees/",
                              app_fee_id, "/refunds/", refund_id)
    .get(api_key, link)
}

#' Update a refund for an Application Fee.
#'
#' @param api_key Your Stripe API Key
#' @param app_fee_id The id for the Application Fee
#' you want to refund
#' @param refund_id The id for the Refund 
#' you want to update
#' @param args An optional list which can contain an amount to refund
#' \emph{default is entire fee} and metadata
#' @export
#' @examples stripe_create_app_fee_refund("sk_test_BQokikJOvBiI2HlWgH4olfQ2", "fee_4cbC9iLv8PdUnk",
#' list(metadata=list(reason="Accidental charge")))
#' @return A data frame with application fee refund object if succeeded
stripe_update_app_fee_refund <- function(api_key, app_fee_id, refund_id, args) {
    args <- .metadata(args)
    link <- paste0("https://api.stripe.com/v1/application_fees/",
                   app_fee_id, "/refunds/", refund_id)
    .post(api_key, link, args)
}

#' List all refunds for an Application Fee.
#'
#' @param api_key Your Stripe API Key
#' @param app_fee_id The id for the Application Fee
#' you want to refund
#' @param args An optional list which can contain
#' \strong{ending_before}, \strong{limit}, or \strong{starting_after}
#' @export
#' @examples stripe_list_application_fee_refunds("sk_test_BQokikJOvBiI2HlWgH4olfQ2", "fee_4cbC9iLv8PdUnk",
#' list(limit=3)) #returns 3 refunds
#' @return A data frame with application fee refund object if succeeded
stripe_list_application_fee_refunds <- function(api_key, app_fee_id, args=NULL) {
    args <- .convert_to_url(args)
    link <- paste0("https://api.stripe.com/v1/application-fees/",app_fee_id, "/refunds", args)
    .get(api_key, link)
}
