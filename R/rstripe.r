require(RCurl)
require(httr)
require(jsonlite)


# --------------------------------------------------
# Charges
# --------------------------------------------------
stripe_create_charge <- function(api_key,args) {
    body <- .convert_to_body(args)
    link <- "https://api.stripe.com/v1/charges"
    response <- POST(url = link, config=add_headers(Authorization=paste0("Bearer  ", api_key)),
                     body=body)
    content(response)
}

stripe_retrieve_charge <- function(api_key, charge_id) {
    response <- getURL(paste0("https://api.stripe.com/v1/charges/",charge_id), 
                       userpwd=paste0(api_key, ":"))
    df <- fromJSON(response)
}

stripe_update_charge <- function(api_key, description = NULL, metadata=NULL) {
    body <- .convert_to_body(args)
    link <- paste0("https://api.stripe.com/v1/customers", customer_id)
    response <- POST(url = link, config=add_headers(Authorization=paste0("Bearer  ", api_key)),
                     body=body)
    content(response)
}

# --------------------------------------------------
# Customers
# --------------------------------------------------
stripe_create_customer <- function(api_key, args) {
    body <- .convert_to_body(args)
    link <- "https://api.stripe.com/v1/customers"
    response <- POST(url = link, config=add_headers(Authorization=paste0("Bearer  ", api_key)),
                     body=body)
    content(response)
}

stripe_retrieve_customer <- function(api_key, customer_id) {
    response <- getURL(paste0("https://api.stripe.com/v1/customers/",customer_id), 
                       userpwd=paste0(api_key, ":"))
    df <- fromJSON(response)
}

stripe_update_customer <- function(api_key, customer_id, args) {
    body <- .convert_to_body(args)
    link <- paste0("https://api.stripe.com/v1/customers", customer_id)
    response <- POST(url = link, config=add_headers(Authorization=paste0("Bearer  ", api_key)),
                     body=body)
    content(response)
}

stripe_delete_customer <- function(api_key, customer_id) {
    link <- paste0("https://api.stripe.com/v1/customers/",customer_id)
    response <- DELETE(url=link,config=add_headers(Authorization=paste0("Bearer ", api_key)))
    content(response)
}

stripe_list_customers <- function(api_key) {
    response <- getURL(paste0("https://api.stripe.com/v1/customers/"), 
                       userpwd=paste0(api_key, ":"))
    df <- fromJSON(response)
}


# --------------------------------------------------
# Subscriptions
# --------------------------------------------------
stripe_create_subscription <- function(api_key, customer_id, plan_id) {
    link <- paste0("https://api.stripe.com/v1/customers/",customer_id, "/subscriptions")
    response <- POST(url = link, config=add_headers(Authorization=paste0("Bearer  ", api_key)),
                     body=paste0("plan=",plan_id))
    content(response)
}

stripe_retrieve_subscription <- function(api_key, customer_id, subscription_id) {
    response <- getURL(paste0("https://api.stripe.com/v1/customers/", customer_id,
                              "/subscriptions/", subscription_id),
                       userpwd=paste0(api_key, ":"))
    df <- fromJSON(response)
    return(df$data)
}

stripe_update_subscription <- function(api_key, customer_id, subscription_id, plan_id) {
    link <- paste0("https://api.stripe.com/v1/customers/",customer_id, "/subscriptions/",
                   subscription_id)
    response <- POST(url = link, config=add_headers(Authorization=paste0("Bearer  ", api_key)),
                     body=paste0("plan=",plan_id))
    content(response)
}

stripe_delete_subscription <- function(api_key, customer_id, subscription_id) {
    link <- paste0("https://api.stripe.com/v1/customers/",customer_id, "/subscriptions/",
                   subscription_id)
    response <- DELETE(url=link,config=add_headers(Authorization=paste0("Bearer ", api_key)))
    content(response)
}

stripe_list_subscriptions <- function(api_key, customer_id) {
    response <- getURL(paste0("https://api.stripe.com/v1/customers/",customer_id,
                              "/subscriptions"), userpwd=paste0(api_key, ":"))
    df <- fromJSON(response)
    return(df$data)
}


# --------------------------------------------------
# Helper Functions
# --------------------------------------------------
.convert_to_body <- function(args) {
    arg_list <- lapply(seq_along(args), function(i) {
          paste0(names(args)[[i]],"=",args[[i]])
        })
    paste(arg_list,collapse=', ')
}
