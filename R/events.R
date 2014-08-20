# --------------------------------------------------
# Events
# --------------------------------------------------

#' Retrieve an event.
#'
#' @param api_key Your Stripe API Key
#' @param event_id The identifier of the event to be retrieved
#' @export
#' @return Returns an event data frame if valid.
stripe_retrieve_event <- function(api_key, event_id) {
    link <- paste0("https://api.stripe.com/v1/events/", event_id)
    .get(api_key, link)
}


#' Retrieve an event.
#'
#' @param api_key Your Stripe API Key
#' @param args an optional list that can include \strong{type},
#' \strong{created}, \strong{ending_before},
#' \strong{limit}, \strong{starting_after}
#' @export
#' @return Returns an event data frame containing
#' all the eventsif valid.
stripe_list_events <- function(api_key, args=NULL) {
    args <- .convert_to_url(args)
    link <- paste0("https://api.stripe.com/v1/events", args)
    .get(api_key, link)
}
