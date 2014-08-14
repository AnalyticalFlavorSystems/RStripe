require(RCurl)
require(httr)
require(jsonlite)


# --------------------------------------------------
# Charges
# --------------------------------------------------
stripe_create_charge <- function(api_key,args) {
    args <- .convert_to_subarray(args, "card")
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

stripe_update_charge <- function(api_key, charge_id, args) {
    if(!is.null(description) | !is.null(metadata)) {
        args <- .metadata(args)
        link <- paste0("https://api.stripe.com/v1/customers", customer_id)
        response <- POST(url = link, config=add_headers(Authorization=paste0("Bearer  ", api_key)),
                         body=args)
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
    args <- .metadata(args)
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
    args <- .card(args)
    args <- .metadata(args)
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
    args <- .card(args)
    args <- .metadata(args)
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
    return(df)
}

stripe_update_subscription <- function(api_key, customer_id, subscription_id, args) {
    args <- .metadata(args)
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
    return(df)
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
    return(df)
}

stripe_update_plan <- function(api_key, plan_id, args) {
    args <- .metadata(args)
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
    return(df)
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
    return(df)
}

stripe_update_coupon <- function(api_key, coupon_id, args) {
    args <- .metadata(args)
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
    return(df)
}


# --------------------------------------------------
# Discounts
# --------------------------------------------------
stripe_delete_customer_discount <- function(api_key, customer_id) {
    link <- paste0("https://api.stripe.com/v1/customers/", customer_id, "/discount")
    response <- DELETE(url=link,config=add_headers(Authorization=paste0("Bearer ", api_key)))
    content(response)
}

stripe_delete_subscription_discount <- function(api_key, customer_id, subscription_id) {
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
    return(df)
}

stripe_retrieve_invoice_line_items <- function(api_key, invoice_id, args) {
    args <- .convert_to_url(args)
    response <- getURL(paste0("https://api.stripe.com/v1/invoices/",
                              invoice_id, "/lines", args),
                       userpwd=paste0(api_key, ":"))
    df <- fromJSON(response)
    return(df)
}

stripe_update_invoice <- function(api_key, invoice_id, args) {
    args <- .metadata(args)
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
    return(df)
}

stripe_upcoming_customer_invoice <- function(api_key, customer_id) {
    args <- .convert_to_url(args)
    response <- getURL(paste0("https://api.stripe.com/v1/invoices/upcoming?customer=", customer_id),
                       userpwd=paste0(api_key, ":"))
    df <- fromJSON(response)
    return(df)
}


# --------------------------------------------------
# Invoice Items
# --------------------------------------------------
stripe_create_invoice_item <- function(api_key, args) {
    link <- paste0("https://api.stripe.com/v1/invoiceitems")
    response <- POST(url = link, config=add_headers(Authorization=paste0("Bearer  ", api_key)),
                     body=args)
    content(response)
}

stripe_retrieve_invoice_item <- function(api_key, item_id) {
    response <- getURL(paste0("https://api.stripe.com/v1/invoiceitems/", item_id),
                       userpwd=paste0(api_key, ":"))
    df <- fromJSON(response)
    return(df)
}

stripe_update_invoice_item <- function(api_key, item_id, args) {
    args <- .metadata(args)
    link <- paste0("https://api.stripe.com/v1/invoiceitems/", item_id)
    response <- POST(url = link, config=add_headers(Authorization=paste0("Bearer  ", api_key)),
                     body=args)
    content(response)
}

stripe_delete_invoice_item <- function(api_key, item_id) {
    link <- paste0("https://api.stripe.com/v1/invoiceitems/", item_id)
    response <- DELETE(url=link,config=add_headers(Authorization=paste0("Bearer ", api_key)))
    content(response)
}

stripe_list_invoice_items <- function(api_key, args) {
    args <- .convert_to_url(args)
    response <- getURL(paste0("https://api.stripe.com/v1/invoiceitems", args),
                       userpwd=paste0(api_key, ":"))
    df <- fromJSON(response)
    return(df)
}

# --------------------------------------------------
# Displutes
# --------------------------------------------------
stripe_update_dispute <- function(api_key, charge_id, args) {
    args <- .metadata(args)
    link <- paste0("https://api.stripe.com/v1/charges/", charge_id, "/dispute")
    response <- POST(url = link, config=add_headers(Authorization=paste0("Bearer  ", api_key)),
                     body=args)
    content(response)
}

stripe_close_dispute <- function(api_key, charge_id) {
    link <- paste0("https://api.stripe.com/v1/charges/",
                   charge_id, "/dispute/close")
    response <- POST(url = link, config=add_headers(Authorization=paste0("Bearer  ", api_key)))
    content(response)
}


# --------------------------------------------------
# Transfers
# --------------------------------------------------
stripe_create_transfer <- function(api_key, args) {
    link <- paste0("https://api.stripe.com/v1/transfers")
    response <- POST(url = link, config=add_headers(Authorization=paste0("Bearer  ", api_key)),
                     body=args)
    content(response)
}

stripe_retrieve_transfer <- function(api_key, transfer_id) {
    response <- getURL(paste0("https://api.stripe.com/v1/transfers/", transfer_id),
                       userpwd=paste0(api_key, ":"))
    df <- fromJSON(response)
    return(df)
}

stripe_update_transfer <- function(api_key, transfer_id, args) {
    args <- .metadata(args)
    link <- paste0("https://api.stripe.com/v1/transfers/", transfer_id)
    response <- POST(url = link, config=add_headers(Authorization=paste0("Bearer  ", api_key)),
                     body=args)
    content(response)
}

stripe_cancel_transfer <- function(api_key, transfer_id) {
    link <- paste0("https://api.stripe.com/v1/transfers/", transfer_id, "/cancel")
    response <- POST(url = link, config=add_headers(Authorization=paste0("Bearer  ", api_key)))
    content(response)
}

stripe_list_transfers <- function(api_key, args) {
    args <- .convert_to_url(args)
    response <- getURL(paste0("https://api.stripe.com/v1/transfers", args),
                       userpwd=paste0(api_key, ":"))
    df <- fromJSON(response)
    return(df)
}


# --------------------------------------------------
# Recipients
# --------------------------------------------------
stripe_create_recipient <- function(api_key, args) {
    link <- paste0("https://api.stripe.com/v1/recipients")
    response <- POST(url = link, config=add_headers(Authorization=paste0("Bearer  ", api_key)),
                     body=args)
    content(response)
}

stripe_retrieve_recipient <- function(api_key, recipient_id) {
    response <- getURL(paste0("https://api.stripe.com/v1/recipients/", recipient_id),
                       userpwd=paste0(api_key, ":"))
    df <- fromJSON(response)
    return(df)
}

stripe_update_recipient <- function(api_key, recipient_id, args) {
    args <- .metadata(args)
    link <- paste0("https://api.stripe.com/v1/recipients/", recipient_id)
    response <- POST(url = link, config=add_headers(Authorization=paste0("Bearer  ", api_key)),
                     body=args)
    content(response)
}

stripe_delete_recipient <- function(api_key, recipient_id) {
    link <- paste0("https://api.stripe.com/v1/recipients/", recipient_id)
    response <- DELETE(url=link,config=add_headers(Authorization=paste0("Bearer ", api_key)))
    content(response)
}

stripe_list_recipients <- function(api_key, args) {
    args <- .convert_to_url(args)
    response <- getURL(paste0("https://api.stripe.com/v1/recipients", args),
                       userpwd=paste0(api_key, ":"))
    df <- fromJSON(response)
    return(df)
}


# --------------------------------------------------
# Application Fees
# --------------------------------------------------
stripe_retrieve_app_fee <- function(api_key, app_fee_id) {
    response <- getURL(paste0("https://api.stripe.com/v1/application_fees/", app_fee_id),
                       userpwd=paste0(api_key, ":"))
    df <- fromJSON(response)
    return(df)
}

stripe_list_app_fees <- function(api_key, args) {
    args <- .convert_to_url(args)
    response <- getURL(paste0("https://api.stripe.com/v1/application_fees", args),
                       userpwd=paste0(api_key, ":"))
    df <- fromJSON(response)
    return(df)
}


# --------------------------------------------------
# Application Fee Refunds
# --------------------------------------------------
stripe_create_app_fee_refund <- function(api_key, app_fee_id, args) {
    link <- paste0("https://api.stripe.com/v1/application_fees/", app_fee_id, "/refunds")
    response <- POST(url = link, config=add_headers(Authorization=paste0("Bearer  ", api_key)),
                     body=args)
    content(response)
}

stripe_retrieve_app_fee_refund <- function(api_key, app_fee_id, refund_id) {
    response <- getURL(paste0("https://api.stripe.com/v1/application_fees/",
                              app_fee_id, "/refunds/", refund_id),
                       userpwd=paste0(api_key, ":"))
    df <- fromJSON(response)
    return(df)
}

stripe_update_app_fee_refund <- function(api_key, app_fee_id, refund_id, args) {
    args <- .metadata(args)
    link <- paste0("https://api.stripe.com/v1/application_fees/",
                   app_fee_id, "/refunds/", refund_id)
    response <- POST(url = link, config=add_headers(Authorization=paste0("Bearer  ", api_key)),
                     body=args)
    content(response)
}

stripe_list_application_fee_refunds <- function(api_key, app_fee_id, args) {
    args <- .convert_to_url(args)
    response <- getURL(paste0("https://api.stripe.com/v1/application-fees/",app_fee_id, "/refunds", args),
                       userpwd=paste0(api_key, ":"))
    df <- fromJSON(response)
    return(df)
}


# --------------------------------------------------
# Account
# --------------------------------------------------
stripe_retrieve_account <- function(api_key) {
    response <- getURL(paste0("https://api.stripe.com/v1/account"),
                       userpwd=paste0(api_key, ":"))
    df <- fromJSON(response)
    return(df)
}


# --------------------------------------------------
# Balance
# --------------------------------------------------
stripe_retrieve_balance <- function(api_key) {
    response <- getURL(paste0("https://api.stripe.com/v1/balance"),
                       userpwd=paste0(api_key, ":"))
    df <- fromJSON(response)
    return(df)
}

stripe_retrieve_balance_transaction <- function(api_key, transaction_id) {
    response <- getURL(paste0("https://api.stripe.com/v1/balance/history/", transaction_id),
                       userpwd=paste0(api_key, ":"))
    df <- fromJSON(response)
    return(df)
}

stripe_balance_history <- function(api_key, args) {
    args <- .convert_to_url(args)
    response <- getURL(paste0("https://api.stripe.com/v1/balance/history", args),
                       userpwd=paste0(api_key, ":"))
    df <- fromJSON(response)
    return(df)
}


# --------------------------------------------------
# Events
# --------------------------------------------------
stripe_retrieve_event <- function(api_key, event_id) {
    response <- getURL(paste0("https://api.stripe.com/v1/events/", event_id),
                       userpwd=paste0(api_key, ":"))
    df <- fromJSON(response)
    return(df)
}


stripe_list_application_fee_refunds <- function(api_key, args) {
    args <- .convert_to_url(args)
    response <- getURL(paste0("https://api.stripe.com/v1/events", args),
                       userpwd=paste0(api_key, ":"))
    df <- fromJSON(response)
    return(df)
}

# --------------------------------------------------
# Tokens
# --------------------------------------------------
stripe_create_card_token <- function(api_key, args) {
    if("customer" %in% names(args)) {
        customer <- args[["customer"]]
        args[["customer"]] <- NULL
    }
    body <- .convert_to_subarray(args, "card")
    body <- c(body, customer=customer)

    link <- paste0("https://api.stripe.com/v1/tokens")
    response <- POST(url = link, config=add_headers(Authorization=paste0("Bearer  ", api_key)),
                     body=body)
    content(response)
}

stripe_create_account_token <- function(api_key, args) {
    body <- .convert_to_subarray(args, "bank_account")
    link <- paste0("https://api.stripe.com/v1/tokens")
    response <- POST(url = link, config=add_headers(Authorization=paste0("Bearer  ", api_key)),
                     body=body)
    content(response)
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

# can't think of good name
.convert_to_subarray <- function(args, ar_name) {
    arg_list <- lapply(seq_along(args), function(i) {
                       names(args)[i] <- paste0(ar_name,"[",names(args)[i], "]")
        })
    names(args) <- arg_list
    return(args)
}
# uses the subdomain function to convert
# `metadata` to `metadata[key]`
.metadata <- function(args) {
    if('metadata' %in% args) {
        metadata <- .convert_to_subarray(args, "metadata")
        args[["metadata"]] <- NULL
        args <- c(args, metadata)
    }
    return(args)
}
