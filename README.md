# rpinterest
This package requests informations from the Pinterest API.

##Access the API 

In order to get informations from the API, you first need to get an access token from the [Pinterest token generator](https://developers.pinterest.com/tools/access_token/).

##Install rpinterest

Install this package directly in R : 

```{r}
devtools::install_github("ColinFay/rpinterest")
```

##How rpinterest works

The version 0.1.0 works with seven functions. Which are :  

* `BoardPinsByID` Get informations about all the pins on a pinterest board using the board ID.

* `BoardPinsByName` Get informations about all the pins on a pinterest board using the board name.

* `BoardSpecByID` Get informations about a pinterest board using its ID.

* `BoardSpecByName` Get informations about a pinterest board using its name.

* `PinSpecByID` Get informations about a pinterest pin using its ID.

* `UserSpecByID` Get informations about a pinterest user using its ID.

* `UserSpecNyName` Get informations about a pinterest user using its name.

###Contact

Questions and feedbacks [welcome](mailto:contact@colinfay.me) !
