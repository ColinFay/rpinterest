# rpinterest
This package requests information from the Pinterest API.

##Access the API 

In order to get information from the API, you first need to get an access token from the [Pinterest token generator](https://developers.pinterest.com/tools/access_token/).

##Install rpinterest

Install this package directly in R : 

```{r}
devtools::install_github("ColinFay/rpinterest")
```

##How rpinterest works

The version 0.1.0 works with seven functions. Which are :  

* `BoardPinsByID` Get information about all the pins on a pinterest board using the board ID.

* `BoardPinsByName` Get information about all the pins on a pinterest board using the board name.

* `BoardSpecByID` Get information about a pinterest board using the board ID.

* `BoardSpecByName` Get information about a pinterest board using the board name.

* `PinSpecByID` Get information about a pinterest pin using the pin ID.

* `UserSpecByID` Get information about a pinterest user using the user ID.

* `UserSpecNyName` Get information about a pinterest user using the user name.

###Contact

Questions and feedbacks [welcome](mailto:contact@colinfay.me) !
