# --------------------------------------------------
# Charges
# --------------------------------------------------

#' Create a charge.
#'
#' Create a new charge for a customer or standalone on card.
#'
#' @param api_key Your Stripe API Key
#'
#' @param args A list of arguments
#' \describe{
#'    \item{amount}{\strong{required} Amount for transfer.}
#'    \item{currency}{\strong{required} The 3-letter currency.}
#'    \item{customer}{\emph{optional} Either customer or card required.}
#'    \item{card}{\emph{optional} Either customer or card required.}
#'    \item{description}{\emph{optional} The description of the transfer.}
#'    \item{capture}{\emph{optional} True/false to capture charge later.}
#'    \item{recipient_email}{\emph{optional} The email to send receipt to.}
#'    \item{metadata}{\emph{optional} A list which can contain anything to further describe.}
#'    \item{statement_description}{\emph{optional} 15 character description to appear on
#'                                 statement.}
#'    \item{application_fee}{\emph{optional} A fee in cents applied to charge.}
#' }
#'
#' @examples \dontrun{stripe_create_charge("sk_test_BQokikJOvBiI2HlWgH4olfQ2",
#' list(card="tok_14SsjM2eZvKYlo2CCtdx2AvO", amount=3000, currency="usd",
#' metadata=list(order_id="12545")))}
#'
#' @return A data frame with the new charge info if successful.
#'
#' @export
#'
stripe_create_charge <- function(api_key,args) {
    args <- .downcase(args, FALSE)
    args <- .downcase(args, TRUE)
    args <- .card(args)
    link <- "https://api.stripe.com/v1/charges"
    .post(api_key, link, args)
}

#' Retrieve a charge.
#'
#' Retrieve all the information about a specific charge. 
#'
#' @param api_key Your Stripe API Key
#'
#' @param charge_id The identifier of the charge to be retrieved
#'
#' @examples \dontrun{stripe_retrieve_charge("sk_test_BQokikJOvBiI2HlWgH4olfQ2", 
#' "ch_14TLyd2eZvKYlo2CdryxwrF8")}
#'
#' @return Returns a charge data frame if valid.
#'
#' @export
#'
stripe_retrieve_charge <- function(api_key, charge_id) {
    link <- paste0("https://api.stripe.com/v1/charges/", charge_id)
    .get(api_key, link)
}

#' Update a charge.
#'
#' Update the information about a charge.
#'
#' @param api_key Your Stripe API Key
#'
#' @param charge_id The identifier of the charge to be updated
#'
#' @param args A list that can include:
#' \describe{
#'    \item{metadata}{\emph{optional} A list of metadata to include}
#'    \item{description}{\emph{optional} A string to describe it}
#' }
#'
#' @examples \dontrun{stripe_update_charge("sk_test_BQokikJOvBiI2HlWgH4olfQ2", 
#' "ch_14TLyd2eZvKYlo2CdryxwrF8", list(description="for the item",
#' metadata=list(order_id="3453")))}
#'
#' @return Returns a charge data frame if succeeded.
#'
#' @export
#'
stripe_update_charge <- function(api_key, charge_id, args) {
    if(!is.null(args["description"]) | !is.null(args["metadata"])) {
        args <- .metadata(args)
        link <- paste0("https://api.stripe.com/v1/charges/", charge_id)
        .post(api_key, link, args)
    } else {
        print("There is nothing to update!")
    }
}

#' Capture a charge.
#'
#' As part of the two step charge workflow, capture a charge.  Read more about the workflow
#' on the stripe website.
#'
#' @param api_key Your Stripe API Key
#'
#' @param charge_id The identifier of the charge to be captured
#'
#' @param args an optional list that can include \strong{amount},
#' \describe{
#'    \item{application_fee}{\emph{optional} A fee to add on to a charge. Only Stripe Connect}
#'    \item{receipt_email}{\emph{optional} The email to send receipt to.}
#' }
#'
#' @return Returns a charge data frame if the capture succeeded.
#'
#' @export
#'
stripe_capture_charge <- function(api_key, charge_id, args=NULL) {
    link <- paste0("https://api.stripe.com/v1/charges/",charge_id, "/capture")
    .post(api_key, link, args)
}

#' List all charges.
#'
#' List all charges conducted in a time frame or on customer.  Limits to 10 originally.
#'
#' @param api_key Your Stripe API Key
#'
#' @param args an optional list that can include \strong{customer},
#' \describe{
#'    \item{customer}{\emph{optional} A customer id to show only their charges. }
#'    \item{ending_before}{\emph{optional} An id to show the ones before this item.}
#'    \item{limit}{\emph{optional} The limit to show.  Can be 1 to 100.  Default is 10.}
#'    \item{starting_after}{\emph{optional} An id to show the ones starting after this item.}
#' }
#'
#' @return Returns a data frame with all customer charges.  10 if no limit specified.
#'
#' @export
#'
stripe_list_charges <- function(api_key, args=NULL) {
    args <- .convert_to_url(args)
    link <- paste0("https://api.stripe.com/v1/charges",args)
    .get(api_key, link)
}
