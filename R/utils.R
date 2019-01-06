`%||%` <- function(a,b) if(is.null(a)) b else a

#' @importFrom attempt stop_if_not
#' @importFrom curl has_internet
check_internet <- function(){
  stop_if_not(.x = has_internet(), msg = "Please check your internet connexion")
}

#' @importFrom httr status_code
#' @importFrom attempt message_if_not

check_status <- function(res){
  
  if (status_code(res) != 200){
    print(json_raw_to_char(res$content))
    stop("The API returned an error")
  }

}

#' @importFrom jsonlite fromJSON
json_raw_to_char <- function(content){
  fromJSON(rawToChar(content), flatten = TRUE)
}

df_tbl <- function(...){
  x <- data.frame(..., stringsAsFactors = FALSE)
  structure(clean_names(x), class = c("tbl_df", "tbl", "data.frame"))
}

as_tbl <- function(x){
  x <- as.data.frame(x, stringsAsFactors = FALSE)
  structure(clean_names(x), class = c("tbl_df", "tbl", "data.frame"))
}

clean_names <- function(x){
  old_names <- tolower(names(x))
  old_names <- gsub("\\.", "_", old_names)
  setNames(x, old_names)
}