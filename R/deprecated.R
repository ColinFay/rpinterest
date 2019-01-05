#' @export
#' @noRd
#' 
BoardPinsByID <- function(boardID, token) {
  .Deprecated("get_board_pins_by_id", msg = 'BoardPinsByID is now deprecated, please use get_board_pins_by_id()')
  get_board_pins_by_id(boardID, token)
}

#' @export
#' @noRd
#' 
BoardPinsByName <- function(user, board, token) {
  .Deprecated("get_board_pins_by_name", msg = 'BoardPinsByName is now deprecated, please use get_board_pins_by_name()')
  get_board_pins_by_name(user, board, token)
}


#' @export
#' @noRd
#' 
BoardSpecByID <- function(boardID, token) {
  .Deprecated("get_board_spec_by_id", msg = 'BoardSpecByID is now deprecated, please use get_board_spec_by_id()')
  get_board_spec_by_id(boardID, token)
}

#' @export
#' @noRd
#' 
BoardSpecByName <- function(user, board, token){
  .Deprecated("get_board_spec_by_name", msg = 'BoardSpecByName is now deprecated, please use get_board_spec_by_id()')
  get_board_spec_by_name(user, board, token)
}

#' @export
#' @noRd
#' 
PinSpecByID <- function(pinID, token){
  .Deprecated("get_pin_spec_by_id", msg = 'PinSpecByID is now deprecated, please use get_pin_spec_by_id()')
  get_pin_spec_by_id(pinID, token)
}

#' @export
#' @noRd
#' 
UserSpecByID <- function(userID, token){
  .Deprecated("get_user_spec_by_id", msg = 'UserSpecByID is now deprecated, please use get_user_spec_by_id()')
  get_user_spec_by_id(userID, token)
}

#' @export
#' @noRd
#' 
UserSpecByName <- function(user, token){
  .Deprecated("get_user_spec_by_name", msg = 'UserSpecByName is now deprecated, please use get_user_spec_by_name()')
  get_user_spec_by_name(user, token)
}
