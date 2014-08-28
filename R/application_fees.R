# --------------------------------------------------
# Application Fees
# --------------------------------------------------

#' Retrieve an Application Fee.
#'
#' Retrieve the data behind a specific applicaiton fee.
#'
#' @param api_key Your Stripe API Key
#'
#' @param app_fee_id The id for the Application Fee
#' you want to retrieve
#'
#' @return A data frame with refund app fee information
#'
#' @export
#'
stripe_retrieve_application_fee <- function(api_key, application_fee_id) {
    link <- paste0("https://api.stripe.com/v1/application_fees/", application_fee_id)
    .get(api_key, link)
}


#' List all Application Fees.
#'
#' List all the application fees.  Can filter by charge, date, etc.
#'
#' @param api_key Your Stripe API Key
#'
#' @param args optional list that can include:
#' \describe{
#'    \strong{charge}{\emph{optional} Only return feew associated with this charge.}
#'    \item{ending_before}{\emph{optional:} An object id which will show objects before}
#'    \item{limit}{\emph{optional:} A number 1 to 100 to limit the items.  Default is 10}
#'    \item{starting_after}{\emph{optional:} An object id which will show objects starting here}
#' }
#'
#' @return A data frame with the application fees you
#' have created that allow you to refund them.
#'
#' @export
#'
stripe_list_application_fees <- function(api_key, args=NULL) {
    args <- .convert_to_url(args)
    link <- paste0("https://api.stripe.com/v1/application_fees", args)
    .get(api_key, link)
}
