# --------------------------------------------------
# Application Fee Refunds
# --------------------------------------------------

#' Create a refund for an Application Fee.
#'
#' Create a refund for an application fee.
#'
#' @param api_key Your Stripe API Key
#'
#' @param application_fee_id The id for the Application Fee
#' you want to refund
#'
#' @param args An optional list which can contain an amount to refund
#' \describe{
#'    \item{amount}{\emph{optional} default is entire fee} 
#'    \item{metadata}{\emph{optional} A list which can contain anything to further describe.}
#' }
#'
#' @examples stripe_create_application_fee_refund("sk_test_BQokikJOvBiI2HlWgH4olfQ2", "fee_4cbC9iLv8PdUnk")
#'
#' @examples stripe_create_application_fee_refund("sk_test_BQokikJOvBiI2HlWgH4olfQ2", "fee_4cbC9iLv8PdUnk",
#' list(amount=100))
#'
#' @examples stripe_create_application_fee_refund("sk_test_BQokikJOvBiI2HlWgH4olfQ2", "fee_4cbC9iLv8PdUnk",
#' list(metadata=list(reason="Accidental charge")))
#'
#' @return A data frame with refund information
#'
#' @export
#'
stripe_create_application_fee_refund <- function(api_key, application_fee_id, args=NULL) {
    link <- paste0("https://api.stripe.com/v1/application_fees/", application_fee_id, "/refunds")
    .post(api_key, link, args)
}

#' Retrieve an existing refund for an Application Fee.
#'
#' Retrieve the information of a refund.
#'
#' @param api_key Your Stripe API Key
#'
#' @param application_fee_id The id for the Application Fee
#' you want to refund
#'
#' @param refund_id The id for the Refund 
#' you want to retrieve
#'
#' @return A data frame with refund information
#'
#' @export
#'
stripe_retrieve_application_fee_refund <- function(api_key, application_fee_id, refund_id) {
    link <- paste0("https://api.stripe.com/v1/application_fees/",
                              application_fee_id, "/refunds/", refund_id)
    .get(api_key, link)
}

#' Update a refund for an Application Fee.
#'
#' Update all the information of a refund of an application fee.
#'
#' @param api_key Your Stripe API Key
#'
#' @param application_fee_id The id for the Application Fee
#' you want to refund
#'
#' @param refund_id The id for the Refund 
#' you want to update
#'
#' @param args An optional list which can contain:
#' \describe{
#'    \item{metadata}{\emph{optional} A list which can contain anything to further describe.}
#' }
#'
#' @examples stripe_create_application_fee_refund("sk_test_BQokikJOvBiI2HlWgH4olfQ2", "fee_4cbC9iLv8PdUnk",
#' list(metadata=list(reason="Accidental charge")))
#'
#' @return A data frame with application fee refund object if succeeded
#'
#' @export
#'
stripe_update_application_fee_refund <- function(api_key, application_fee_id, refund_id, args) {
    args <- .metadata(args)
    link <- paste0("https://api.stripe.com/v1/application_fees/",
                   application_fee_id, "/refunds/", refund_id)
    .post(api_key, link, args)
}

#' List all refunds for an Application Fee.
#'
#' List all refunds associated with a specific application fee.
#'
#' @param api_key Your Stripe API Key
#'
#' @param application_fee_id The id for the Application Fee
#' you want to refund
#'
#' @param args An optional list which can contain
#' \describe{
#'    \item{ending_before}{\emph{optional:} An object id which will show objects before}
#'    \item{limit}{\emph{optional:} A number 1 to 100 to limit the items.  Default is 10}
#'    \item{starting_after}{\emph{optional:} An object id which will show objects starting here}
#' }
#'
#' @examples stripe_list_application_fee_refunds("sk_test_BQokikJOvBiI2HlWgH4olfQ2", "fee_4cbC9iLv8PdUnk",
#' list(limit=3)) #returns 3 refunds
#'
#' @return A data frame with application fee refund object if succeeded
#'
#' @export
#'
stripe_list_application_fee_refunds <- function(api_key, application_fee_id, args=NULL) {
    args <- .convert_to_url(args)
    link <- paste0("https://api.stripe.com/v1/application-fees/",application_fee_id, "/refunds", args)
    .get(api_key, link)
}
