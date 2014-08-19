# --------------------------------------------------
# Charges
# --------------------------------------------------
stripe_create_charge <- function(api_key,args) {
    args <- .downcase(args, FALSE)
    args <- .downcase(args, TRUE)
    args <- .card(args)
    link <- "https://api.stripe.com/v1/charges"
    .post(api_key, link, args)
}

stripe_retrieve_charge <- function(api_key, charge_id) {
    link <- paste0("https://api.stripe.com/v1/charges/", charge_id)
    .get(api_key, link)
}

stripe_update_charge <- function(api_key, charge_id, args) {
    if(!is.null(args["description"]) | !is.null(args["metadata"])) {
        args <- .metadata(args)
        link <- paste0("https://api.stripe.com/v1/charges/", charge_id)
        .post(api_key, link, args)
    } else {
        print("There is nothing to update!")
    }
}

stripe_capture_charge <- function(api_key, charge_id, args=NULL) {
    link <- paste0("https://api.stripe.com/v1/charges/",charge_id, "/capture")
    .post(api_key, link, args)
}

stripe_list_charges <- function(api_key, args=NULL) {
    args <- .convert_to_url(args)
    link <- paste0("https://api.stripe.com/v1/charges",args)
    .get(api_key, link)
}
