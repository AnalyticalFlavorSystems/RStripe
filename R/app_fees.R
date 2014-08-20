# --------------------------------------------------
# Application Fees
# --------------------------------------------------

#' Retrieve an App Fee.
#'
#' @param api_key Your Stripe API Key
#' @param app_fee_id The id for the Application Fee
#' you want to retrieve
#' @export
#' @return A data frame with refund app fee information
stripe_retrieve_app_fee <- function(api_key, app_fee_id) {
    link <- paste0("https://api.stripe.com/v1/application_fees/", app_fee_id)
    .get(api_key, link)
}


#' List all App Fees.
#'
#' @param api_key Your Stripe API Key
#' @param args optional list that can include
#' \strong{charge}, \strong{created}, \strong{ending_before},
#' \strong{limit}, \strong{starting_after}
#' @export
#' @return A data frame with the application fees you
#' have created that allow you to refund them.
stripe_list_app_fees <- function(api_key, args=NULL) {
    args <- .convert_to_url(args)
    link <- paste0("https://api.stripe.com/v1/application_fees", args)
    .get(api_key, link)
}
