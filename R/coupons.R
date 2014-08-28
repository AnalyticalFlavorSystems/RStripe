# --------------------------------------------------
# Coupons
# --------------------------------------------------

#' Create a coupon.
#'
#' Create a new coupon in your account.
#'
#' @param api_key Your Stripe API Key
#'
#' @param args An list  
#' \describe{
#'    \item{duration}{\strong{required} Can be \emph{forever}, \emph{once}, \emph{repeating}}
#'    \item{id}{\strong{optional} An id to identify. e.g. \emph{FALL25OFF}}
#'    \item{amount_off}{\strong{optional} required if \emph{percent_off} is not passed.  Integer.}
#'    \item{currency}{\strong{optional} required if amount_off is passed.}
#'    \item{duration_in_months}{\strong{optional} required if duration is repeating.}
#'    \item{max_redemptions}{\strong{optional} total amount of times to be used.}
#'    \item{metadata}{\emph{optional} A list which can contain anything to further describe.}
#'    \item{percent_off}{\strong{optional} required if amount_off not passed.}
#'    \item{redeem_by}{\strong{optional} unix timestamp that it ends.}
#' }
#'
#' @examples stripe_create_coupon("sk_test_BQokikJOvBiI2HlWgH4olfQ2", 
#' list(amount_off=200, duration='forever'))
#'
#' @examples stripe_create_coupon("sk_test_BQokikJOvBiI2HlWgH4olfQ2", 
#' list(percent_off=25, duration='once'))
#'
#' @examples stripe_create_coupon("sk_test_BQokikJOvBiI2HlWgH4olfQ2", 
#' list(percent_off=25, duration='repeating', duration_in_months=3))
#'
#' @return A data frame with the coupon information
#'
#' @export
#'
stripe_create_coupon <- function(api_key, args) {
    args <- .metadata(args)
    link <- paste0("https://api.stripe.com/v1/coupons")
    .post(api_key, link, args)
}

#' Retrieve a coupon.
#'
#' Retrieve the information about a coupon.
#'
#' @param api_key Your Stripe API Key
#'
#' @param coupon_id The coupon you want to retrieve.
#'
#' @return A data frame with the coupon information
#'
#' @export
#'
stripe_retrieve_coupon <- function(api_key, coupon_id) {
    link <- paste0("https://api.stripe.com/v1/coupons/", coupon_id)
    .get(api_key, link)
}

#' Update a coupon.
#'
#' Update the information about a coupon.
#'
#' @param api_key Your Stripe API Key
#'
#' @param coupon_id The coupon you want to update.
#'
#' @param args An list which can contain:
#' \describe{
#'    \item{description}{\emph{optional} The description of the transfer.}
#'    \item{metadata}{\emph{optional} A list which can contain anything to further describe.}
#' }
#'
#' @return A data frame with the new coupon information if succeeded.
#'
#' @export
#'
stripe_update_coupon <- function(api_key, coupon_id, args) {
    args <- .metadata(args)
    link <- paste0("https://api.stripe.com/v1/coupons/", coupon_id)
    .post(api_key, link, args)
}

#' Delete a coupon.
#'
#' Delete a specific coupon from your account.
#'
#' @param api_key Your Stripe API Key
#'
#' @param coupon_id The coupon you want to delete
#'
#' @return A null dataframe if succeeded.
#'
#' @export
#'
stripe_delete_coupon <- function(api_key, coupon_id) {
    link <- paste0("https://api.stripe.com/v1/coupons/", coupon_id)
    .delete(api_key, link)
}

#' List all coupons.
#'
#' List all the coupons currently in your account.
#'
#' @param api_key Your Stripe API Key
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
#' @return A data frame with all the coupons.
#'
#' @export
#'
stripe_list_coupons <- function(api_key, args=NULL) {
    args <- .convert_to_url(args)
    link <- paste0("https://api.stripe.com/v1/coupons", args)
    .get(api_key, link)
}
