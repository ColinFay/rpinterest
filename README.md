
<!-- README.md is generated from README.Rmd. Please edit that file -->

# rpinterest

The goal of rpinterest is to provide access to the Pinterest API from R.

## Installation

You can install the released version of rpinterest from
[CRAN](https://CRAN.R-project.org) with:

``` r
install.packages("rpinterest")
```

Or for the dev version:

``` r
remotes::install_github("ColinFay/rpinterest")
```

## Getting an Access Token

Go to `https://developers.pinterest.com/apps/` and register a new app.
In this new app, use `https://colinfay.me/rpinterestcallback/` as a
callback URL. You can also use a custom callback if you build your own.
Read the Vignette “rpinterest-oauth” for more info about the why and the
how.

Once your app is set, use pinterest\_token to create a token:

``` r
token <- pinterest_token(
  app = "yourapp", 
  app_id = "yourappid", 
  app_secret = "yourappsecret"
)
```

You’ll be taken to a Pinterest login page and R will be waiting for a
connection code. After login, `https://colinfay.me/rpinterestcallback/`
will contain a code that you’ll need to paste back to R.

## About rate limit

If your pinterest app is unauthorised, you’ll be granted 10 requests per
hour per token.

## Call the API

### Boards

#### Pins

Get all the pins from a board:

  - by id

<!-- end list -->

``` r
get_board_pins_by_id(id = "42080646457333782", token = token)
```

  - by
name

<!-- end list -->

``` r
get_board_pins_by_name(user = "colinfay", board = "blanc-mon-amour", token = token)
```

#### Spec

  - by id

<!-- end list -->

``` r
get_board_spec_by_id(id = "42080646457333782", token = token)
```

  - by
name

<!-- end list -->

``` r
get_board_spec_by_name(user = "colinfay", board = "blanc-mon-amour", token = token)
```

### Pins

#### Spec

``` r
get_pin_spec_by_id(id = "42080577745042298", token = "your_token")
```

### User

#### Spec

  - by id

<!-- end list -->

``` r
get_user_spec_by_id(id = "42080715176677612", token = token)
```

  - by name

<!-- end list -->

``` r
get_user_spec_by_name(user = "colinfay", token = token)
```

## Code of Conduct

Please note that the ‘rpinterest’ project is released with a
[Contributor Code of Conduct](CODE_OF_CONDUCT.md). By contributing to
this project, you agree to abide by its terms.
