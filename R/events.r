# --------------------------------------------------
# Events
# --------------------------------------------------
stripe_retrieve_event <- function(api_key, event_id) {
    link <- paste0("https://api.stripe.com/v1/events/", event_id)
    .get(api_key, link)
}


stripe_list_events <- function(api_key, args=NULL) {
    args <- .convert_to_url(args)
    link <- paste0("https://api.stripe.com/v1/events", args)
    .get(api_key, link)
}
