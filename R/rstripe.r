# --------------------------------------------------
# Helper Functions
# --------------------------------------------------
.post <- function(api_key, link, args=NULL) {
    res <- POST(url = link, config=add_headers(Authorization=paste0("Bearer  ", api_key)),
                     body=args, encode="form")
    content(res)
}

.get <- function(api_key, link) {
    res <- getURL(link, userpwd=paste0(api_key, ":"))
    fromJSON(res)
}

.delete <- function(api_key, link) {
    res <- DELETE(url=link,config=add_headers(Authorization=paste0("Bearer ", api_key)))
    content(res)
}

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
    if('metadata' %in% names(args)) {
        metadata <- .convert_to_subarray(args[["metadata"]], "metadata")
        args[["metadata"]] <- NULL
        args <- c(args, metadata)
    }
    return(args)
}
.card <- function(args) {
    if('card' %in% names(args)) {
        card <- .convert_to_subarray(args[["card"]], "card")
        args[["card"]] <- NULL
        args <- c(args, card)
    }
    return(args)
}
.downcase <- function(args, word) {
    if(word %in% args) {
        temp <- which(args==word)
        false <- lapply(temp, function(x) {
               args[[x]] <- tolower(args[[x]])
                })
        args[args == word] <- NULL
        args <- c(args, false)
    }
    args
}


