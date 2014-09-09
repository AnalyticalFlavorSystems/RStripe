# --------------------------------------------------
# Displutes
# --------------------------------------------------

#' Update a dispute.
#'
#' Update a dispute and add evidence to it.
#'
#' @param api_key Your Stripe API Key
#'
#' @param charge_id The identifier of the charge with the dispute.
#'
#' @param args An optional list that can contain 
#' \describe{
#'    \item{evidence}{\emph{optional} Evidence towards resolving dispute.}
#'    \item{metadata}{\emph{optional} key/value for storing dispute information.}
#' }
#'
#' @examples \dontrun{stripe_update_dispute("sk_test_BQokikJOvBiI2HlWgH4olfQ2", 
#' "ch_14TLyd2eZvKYlo2CdryxwrF8", list(evidence="Here's evidence showing
#' this charge is legitimate.",metadata=list(exhibitA="This happened")))}
#'
#' @return Returns a dispute data frame if valid.
#'
#' @export
#'
stripe_update_dispute <- function(api_key, charge_id, args) {
    args <- .metadata(args)
    link <- paste0("https://api.stripe.com/v1/charges/", charge_id, "/dispute")
    .post(api_key, link, args)
}

#' Close a dispute.
#'
#' Close a dispute which you don't have evidence to.
#'
#' @param api_key Your Stripe API Key
#'
#' @param charge_id The identifier of the charge with the dispute.
#'
#' @return Returns a dispute data frame if closed.
#'
#' @export
#'
stripe_close_dispute <- function(api_key, charge_id) {
    link <- paste0("https://api.stripe.com/v1/charges/",
                   charge_id, "/dispute/close")
    .post(api_key, link)
}
