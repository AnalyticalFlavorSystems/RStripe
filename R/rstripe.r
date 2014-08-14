require(RCurl)
require(httr)
require(jsonlite)


# --------------------------------------------------
# Charges
# --------------------------------------------------
stripe_create_charge <- function(api_key,args) {
    link <- "https://api.stripe.com/v1/charges"
    response <- POST(url = link, config=add_headers(Authorization=paste0("Bearer  ", api_key)),
                     body=args)
    content(response)
}

stripe_retrieve_charge <- function(api_key, charge_id) {
    response <- getURL(paste0("https://api.stripe.com/v1/charges/",charge_id), 
                       userpwd=paste0(api_key, ":"))
    df <- fromJSON(response)
}

stripe_update_charge <- function(api_key, charge_id, description = NULL, metadata=NULL) {
    if(!is.null(description) | !is.null(metadata)) {
        body <- list(description=description, metadata=metadata)
        link <- paste0("https://api.stripe.com/v1/customers", customer_id)
        response <- POST(url = link, config=add_headers(Authorization=paste0("Bearer  ", api_key)),
                         body=body)
        content(response)
    } else {
        print("There is nothing to update!")
    }
}

stripe_capture_charge <- function(api_key, charge_id, args) {
    link <- paste0("https://api.stripe.com/v1/charges",charge_id, "/capture")
    response <- POST(url = link, config=add_headers(Authorization=paste0("Bearer  ", api_key)),
                     body=args)
    content(response)
}

stripe_list_charges <- function(api_key, args=NULL) {
    args <- .convert_to_url(args)
    response <- getURL(paste0("https://api.stripe.com/v1/charges",args), 
                       userpwd=paste0(api_key, ":"))
    df <- fromJSON(response)
}


# --------------------------------------------------
# Refunds
# --------------------------------------------------
stripe_create_refund <- function(api_key, charge_id, args=NULL) {
    link <- paste0("https://api.stripe.com/v1/charges",charge_id, "/refunds")
    response <- POST(url = link, config=add_headers(Authorization=paste0("Bearer  ", api_key)),
                     body=args)
    content(response)
}

stripe_retrieve_refund <- function(api_key, charge_id, refund_id) {
    response <- getURL(paste0("https://api.stripe.com/v1/charges/",
                              charge_id, "/refunds/", refund_id), 
                       userpwd=paste0(api_key, ":"))
    df <- fromJSON(response)
}

stripe_update_refund <- function(api_key, charge_id, refund_id, args) {
    link <- paste0("https://api.stripe.com/v1/charges",
                   charge_id, "/refunds/", refund_id)
    response <- POST(url = link, config=add_headers(Authorization=paste0("Bearer  ", api_key)),
                     body=args)
    content(response)
}

stripe_list_refunds <- function(api_key, charge_id, args) {
    args <- .convert_to_url(args)
    response <- getURL(paste0("https://api.stripe.com/v1/charges/", charge_id, "/refunds", args), 
                       userpwd=paste0(api_key, ":"))
    df <- fromJSON(response)
}


# --------------------------------------------------
# Customers
# --------------------------------------------------
stripe_create_customer <- function(api_key, args) {
    link <- "https://api.stripe.com/v1/customers"
    response <- POST(url = link, config=add_headers(Authorization=paste0("Bearer  ", api_key)),
                     body=args)
    content(response)
}

stripe_retrieve_customer <- function(api_key, customer_id) {
    response <- getURL(paste0("https://api.stripe.com/v1/customers/",customer_id), 
                       userpwd=paste0(api_key, ":"))
    df <- fromJSON(response)
}

stripe_update_customer <- function(api_key, customer_id, args) {
    link <- paste0("https://api.stripe.com/v1/customers", customer_id)
    response <- POST(url = link, config=add_headers(Authorization=paste0("Bearer  ", api_key)),
                     body=args)
    content(response)
}

stripe_delete_customer <- function(api_key, customer_id) {
    link <- paste0("https://api.stripe.com/v1/customers/",customer_id)
    response <- DELETE(url=link,config=add_headers(Authorization=paste0("Bearer ", api_key)))
    content(response)
}

stripe_list_customers <- function(api_key, args) {
    args <- .convert_to_url(args)
    response <- getURL(paste0("https://api.stripe.com/v1/customers", args), 
                       userpwd=paste0(api_key, ":"))
    df <- fromJSON(response)
}


# --------------------------------------------------
# Cards
# --------------------------------------------------
stripe_create_card <- function(api_key, token, customer_id) {
    link <- paste0("https://api.stripe.com/v1/customers/",
                   customer_id, "/cards")
    response <- POST(url = link, config=add_headers(Authorization=paste0("Bearer  ", api_key)),
                     body=paste0("token=", token))
    content(response)
}

stripe_retrieve_card <- function(api_key, card_id, customer_id) {
    response <- getURL(paste0("https://api.stripe.com/v1/customers/",
                              customer_id, "/cards/", card_id), 
                       userpwd=paste0(api_key, ":"))
    df <- fromJSON(response)
}


stripe_update_card <- function(api_key, customer_id, card_id, args) {
    link <- paste0("https://api.stripe.com/v1/customers",
                   customer_id, "/cards/", card_id)
    response <- POST(url = link, config=add_headers(Authorization=paste0("Bearer  ", api_key)),
                     body=args)
    content(response)
}

stripe_delete_card <- function(api_key, customer_id, card_id) {
    link <- paste0("https://api.stripe.com/v1/customers/",
                   customer_id, "/cards/", card_id)
    response <- DELETE(url=link,config=add_headers(Authorization=paste0("Bearer ", api_key)))
    content(response)
}

stripe_list_cards <- function(api_key, customer_id, args) {
    args <- .convert_to_url(args)
    response <- getURL(paste0("https://api.stripe.com/v1/customer/",
                              customer_id, "/cards", args), 
                       userpwd=paste0(api_key, ":"))
    df <- fromJSON(response)
}


# --------------------------------------------------
# Subscriptions
# --------------------------------------------------
stripe_create_subscription <- function(api_key, customer_id, args) {
    link <- paste0("https://api.stripe.com/v1/customers/",customer_id, "/subscriptions")
    response <- POST(url = link, config=add_headers(Authorization=paste0("Bearer  ", api_key)),
                     body=args)
    content(response)
}

stripe_retrieve_subscription <- function(api_key, customer_id, subscription_id) {
    response <- getURL(paste0("https://api.stripe.com/v1/customers/", customer_id,
                              "/subscriptions/", subscription_id),
                       userpwd=paste0(api_key, ":"))
    df <- fromJSON(response)
    return(df$data)
}

stripe_update_subscription <- function(api_key, customer_id, subscription_id, args) {
    link <- paste0("https://api.stripe.com/v1/customers/",customer_id, "/subscriptions/",
                   subscription_id)
    response <- POST(url = link, config=add_headers(Authorization=paste0("Bearer  ", api_key)),
                     body=args)
    content(response)
}

stripe_delete_subscription <- function(api_key, customer_id, subscription_id) {
    link <- paste0("https://api.stripe.com/v1/customers/",customer_id, "/subscriptions/",
                   subscription_id)
    response <- DELETE(url=link,config=add_headers(Authorization=paste0("Bearer ", api_key)))
    content(response)
}

stripe_list_subscriptions <- function(api_key, customer_id, args) {
    args <- .convert_to_url(args)
    response <- getURL(paste0("https://api.stripe.com/v1/customers/",customer_id,
                              "/subscriptions", args), userpwd=paste0(api_key, ":"))
    df <- fromJSON(response)
    return(df$data)
}


# --------------------------------------------------
# Plans
# --------------------------------------------------
stripe_create_plan <- function(api_key, args) {
    link <- paste0("https://api.stripe.com/v1/plans")
    response <- POST(url = link, config=add_headers(Authorization=paste0("Bearer  ", api_key)),
                     body=args)
    content(response)
}

stripe_retrieve_plan <- function(api_key, plan_id) {
    response <- getURL(paste0("https://api.stripe.com/v1/plans/", plan_id),
                       userpwd=paste0(api_key, ":"))
    df <- fromJSON(response)
    return(df$data)
}

stripe_update_plan <- function(api_key, plan_id, args) {
    link <- paste0("https://api.stripe.com/v1/plans/", plan_id)
    response <- POST(url = link, config=add_headers(Authorization=paste0("Bearer  ", api_key)),
                     body=args)
    content(response)
}

stripe_delete_plan <- function(api_key, plan_id) {
    link <- paste0("https://api.stripe.com/v1/plans/",plan_id)
    response <- DELETE(url=link,config=add_headers(Authorization=paste0("Bearer ", api_key)))
    content(response)
}

stripe_list_plans <- function(api_key, args) {
    args <- .convert_to_url(args)
    response <- getURL(paste0("https://api.stripe.com/v1/plans", args),
                       userpwd=paste0(api_key, ":"))
    df <- fromJSON(response)
    return(df$data)
}

# --------------------------------------------------
# Coupons
# --------------------------------------------------
stripe_create_coupon <- function(api_key, args) {
    link <- paste0("https://api.stripe.com/v1/coupons")
    response <- POST(url = link, config=add_headers(Authorization=paste0("Bearer  ", api_key)),
                     body=args)
    content(response)
}

stripe_retrieve_coupon <- function(api_key, coupon_id) {
    response <- getURL(paste0("https://api.stripe.com/v1/coupons/", coupon_id),
                       userpwd=paste0(api_key, ":"))
    df <- fromJSON(response)
    return(df$data)
}

stripe_update_coupon <- function(api_key, coupon_id, args) {
    link <- paste0("https://api.stripe.com/v1/coupons/", coupon_id)
    response <- POST(url = link, config=add_headers(Authorization=paste0("Bearer  ", api_key)),
                     body=args)
    content(response)
}

stripe_delete_coupon <- function(api_key, coupon_id) {
    link <- paste0("https://api.stripe.com/v1/coupons/", coupon_id)
    response <- DELETE(url=link,config=add_headers(Authorization=paste0("Bearer ", api_key)))
    content(response)
}

stripe_list_coupons <- function(api_key, args) {
    args <- .convert_to_url(args)
    response <- getURL(paste0("https://api.stripe.com/v1/coupons", args),
                       userpwd=paste0(api_key, ":"))
    df <- fromJSON(response)
    return(df$data)
}


# --------------------------------------------------
# Discounts
# --------------------------------------------------
stripe_delete_customer_discount(api_key, customer_id) {
    link <- paste0("https://api.stripe.com/v1/customers/", customer_id, "/discount")
    response <- DELETE(url=link,config=add_headers(Authorization=paste0("Bearer ", api_key)))
    content(response)
}

stripe_delete_subscription_discount(api_key, customer_id, subscription_id) {
    link <- paste0("https://api.stripe.com/v1/customers/", customer_id,
                   "/subscriptions/", subscription_id, "/discount")
    response <- DELETE(url=link,config=add_headers(Authorization=paste0("Bearer ", api_key)))
    content(response)
}


# --------------------------------------------------
# Invoices
# --------------------------------------------------
stripe_create_invoice <- function(api_key, args) {
    link <- paste0("https://api.stripe.com/v1/invoices")
    response <- POST(url = link, config=add_headers(Authorization=paste0("Bearer  ", api_key)),
                     body=args)
    content(response)
}

stripe_retrieve_invoice <- function(api_key, invoice_id) {
    response <- getURL(paste0("https://api.stripe.com/v1/invoices/", invoice_id),
                       userpwd=paste0(api_key, ":"))
    df <- fromJSON(response)
    return(df$data)
}

stripe_retrieve_invoice_line_items <- function(api_key, invoice_id, args) {
    args <- .convert_to_url(args)
    response <- getURL(paste0("https://api.stripe.com/v1/invoices/",
                              invoice_id, "/lines", args),
                       userpwd=paste0(api_key, ":"))
    df <- fromJSON(response)
    return(df$data)
}

stripe_update_invoice <- function(api_key, invoice_id, args) {
    link <- paste0("https://api.stripe.com/v1/invoices/", invoice_id)
    response <- POST(url = link, config=add_headers(Authorization=paste0("Bearer  ", api_key)),
                     body=args)
    content(response)
}

stripe_pay_invoice <- function(api_key, invoice_id) {
    link <- paste0("https://api.stripe.com/v1/invoices/", invoice_id, "/pay")
    response <- POST(url = link, config=add_headers(Authorization=paste0("Bearer  ", api_key)))
    content(response)
}

stripe_list_invoices <- function(api_key, args) {
    args <- .convert_to_url(args)
    response <- getURL(paste0("https://api.stripe.com/v1/invoices", args),
                       userpwd=paste0(api_key, ":"))
    df <- fromJSON(response)
    return(df$data)
}

stripe_upcoming_customer_invoice <- function(api_key, customer_id) {
    args <- .convert_to_url(args)
    response <- getURL(paste0("https://api.stripe.com/v1/invoices/upcoming?customer=", customer_id),
                       userpwd=paste0(api_key, ":"))
    df <- fromJSON(response)
    return(df$data)
}

# --------------------------------------------------
# Helper Functions
# --------------------------------------------------
.convert_to_url <- function(args) {
    arg_list <- lapply(seq_along(args), function(i) {
          paste0("?",names(args)[[i]],"=",args[[i]])
        })
    paste(arg_list,collapse='')
}
