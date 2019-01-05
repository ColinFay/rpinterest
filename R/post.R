post_image <- function(file, board, note, link = NULL, image = NULL, 
                       image_url = NULL, token){
  url <- paste0("https://api.pinterest.com/v1/pins/?access_token=",token,"&fields=id%2Clink%2Cnote%2Curl%2Cattribution%2Cboard%2Ccolor%2Ccounts%2Ccreated_at%2Ccreator%2Cimage%2Cmedia%2Cmetadata%2Coriginal_link")
  res <- httr::POST(
    url = url, 
    body = list(
      board = board, 
      note = note, 
      link = link, 
      image = image, 
      image_url = image_url, 
      image_base64 = base64enc::base64encode(file)
    )
  )
  res <- json_raw_to_char(res$content)$data
  res
}