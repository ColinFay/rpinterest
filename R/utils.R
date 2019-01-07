`%||%` <- function(a,b) if(is.null(a)) b else a

#' @importFrom attempt stop_if_not
#' @importFrom curl has_internet
check_internet <- function(){
  stop_if_not(.x = has_internet(), msg = "Please check your internet connexion")
}

#' @importFrom jsonlite fromJSON
json_raw_to_char <- function(content){
  fromJSON(rawToChar(content), flatten = TRUE)
}

`%not_in%` <- Negate(`%in%`)
#' @importFrom httr status_code
#' @importFrom attempt message_if_not

check_status <- function(res){
  if (status_code(res) %not_in%  200:201){
    print(json_raw_to_char(res$content))
    stop("The API returned an error")
  }
  
}

#' @importFrom stats setNames
clean_names <- function(x){
  old_names <- tolower(names(x))
  old_names <- gsub("\\.", "_", old_names)
  setNames(x, old_names)
}


df_tbl <- function(...){
  x <- data.frame(..., stringsAsFactors = FALSE)
  structure(clean_names(x), class = c("tbl_df", "tbl", "data.frame"))
}

as_tbl <- function(x){
  x <- as.data.frame(x, stringsAsFactors = FALSE)
  structure(clean_names(x), class = c("tbl_df", "tbl", "data.frame"))
}

pin_spec_to_df <- function(content){
  
  df_tbl(pin_id = content$id %||% NA, 
         creator_url = content$creator$url %||% NA, 
         creator_first_name = content$creator$first_name %||% NA, 
         creator_last_name = content$creator$last_name %||% NA, 
         creator_id = content$creator$id %||% NA, 
         url = content$creator$url %||% NA, 
         media_type = content$media$type %||% NA, 
         created_at = content$created_at %||% NA, 
         original_link = content$original_link %||% NA, 
         note = content$note %||% NA, 
         color = content$color %||% NA, 
         link = content$link %||% NA, 
         board_url = content$board$url %||% NA, 
         board_id = content$board$id %||% NA, 
         board_name = content$board$name %||% NA, 
         image_original_url = content$image$original$url %||% NA, 
         image_original_width = content$image$original$width %||% NA, 
         image_original_height = content$image$original$height %||% NA, 
         counts_saves = content$counts$saves %||% NA, 
         counts_comments = content$counts$comments %||% NA, 
         metadata_link_locale = content$metadata$metadata$link$locale %||% NA, 
         metadata_link_title = content$metadata$metadata$link$title %||% NA, 
         metadata_link_site_name= content$metadata$metadata$link$site_name %||% NA, 
         metadata_link_description = content$metadata$metadata$link$description %||% NA, 
         metadata_link_favicon = content$metadata$metadata$link$favicon %||% NA)
}

board_spec_to_df <- function(content){
  as_tbl(
    data.frame(name = content$name %||% NA,
               creator_url = content$creator$url %||% NA,
               creator_first_name = content$creator$first_name %||% NA,
               creator_last_name = content$creator$last_name %||% NA,
               creator_id = content$creator$id %||% NA,
               url = content$url  %||% NA,
               created_at = content$created_at %||% NA,
               privacy = content$privacy %||% NA,
               reason = content$reason %||% NA,
               image_60x60_url = content$image$`60x60`$url %||% NA,
               image_60x60_width = content$image$`60x60`$width %||% NA,
               image_60x60_height = content$image$`60x60`$height %||% NA,
               count_pins = content$counts$pins %||% NA,
               count_collaborators = content$counts$collaborators %||% NA,
               count_followers = content$counts$followers %||% NA,
               id = content$id %||% NA,
               description = content$description %||% NA,
               stringsAsFactors = FALSE) 
  )
}
