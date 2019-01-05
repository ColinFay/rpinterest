#' Deprecated functions from \pkg{rpinterest}.
#' 
#' @name rpinterest-deprecated
#' @keywords internal
NULL
  
#' @rdname rpinterest-deprecated
#' @export

BoardPinsByID <- function(boardID, token) {
  .Deprecated("get_board_pins_by_id", msg = 'BoardPinsByID is now deprecated, please use get_board_pins_by_id()')
  get_board_pins_by_id(boardID, token)
}

#' @rdname rpinterest-deprecated
#' @export
#' 
BoardPinsByName <- function(user, board, token) {
  .Deprecated("get_board_pins_by_name", msg = 'BoardPinsByName is now deprecated, please use get_board_pins_by_name()')
  get_board_pins_by_name(user, board, token)
}


#' @rdname rpinterest-deprecated
#' @export
#' 
BoardSpecByID <- function(boardID, token) {
  .Deprecated("get_board_spec_by_id", msg = 'BoardSpecByID is now deprecated, please use get_board_spec_by_id()')
  get_board_spec_by_id(boardID, token)
}

#' @rdname rpinterest-deprecated
#' @export
#'  
BoardSpecByName <- function(user, board, token){
  .Deprecated("get_board_spec_by_name", msg = 'BoardSpecByName is now deprecated, please use get_board_spec_by_id()')
  get_board_spec_by_name(user, board, token)
}

#' @rdname rpinterest-deprecated
#' @export
#' 
PinSpecByID <- function(pinID, token){
  .Deprecated("get_pin_spec_by_id", msg = 'PinSpecByID is now deprecated, please use get_pin_spec_by_id()')
  get_pin_spec_by_id(pinID, token)
}

#' @rdname rpinterest-deprecated
#' @export
#' 
UserSpecByID <- function(userID, token){
  .Deprecated("get_user_spec_by_id", msg = 'UserSpecByID is now deprecated, please use get_user_spec_by_id()')
  get_user_spec_by_id(userID, token)
}

#' @rdname rpinterest-deprecated
#' @export
#'  
UserSpecByName <- function(user, token){
  .Deprecated("get_user_spec_by_name", msg = 'UserSpecByName is now deprecated, please use get_user_spec_by_name()')
  get_user_spec_by_name(user, token)
}
