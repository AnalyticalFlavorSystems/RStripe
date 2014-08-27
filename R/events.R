# --------------------------------------------------
# Events
# --------------------------------------------------

#' Retrieve an event.
#'
#' Retrieve the information about a specific event.
#'
#' @param api_key Your Stripe API Key
#'
#' @param event_id The identifier of the event to be retrieved
#'
#' @return Returns an event data frame if valid.
#' @export
#'
stripe_retrieve_event <- function(api_key, event_id) {
    link <- paste0("https://api.stripe.com/v1/events/", event_id)
    .get(api_key, link)
}


#' List all events.
#'
#' list all the events that have happened.
#'
#' @param api_key Your Stripe API Key
#'
#' @param args an optional list that can include \strong{type},
#' \strong{created}, \strong{ending_before},
#' \strong{limit}, \strong{starting_after}
#'
#' @return Returns an event data frame containing
#' all the eventsif valid.
#' @export
#'
stripe_list_events <- function(api_key, args=NULL) {
    args <- .convert_to_url(args)
    link <- paste0("https://api.stripe.com/v1/events", args)
    .get(api_key, link)
}
