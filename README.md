# ErrorsSavior

Rails middleware to catches exceptions and renders them as JSON with a specific response body protocol.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'errors_savior'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install errors_savior

## Generator

To create the initializer for configuration details, you can run:

    $ rails generate errors_savior:install


## Conventions

| Range | Description |
| ----- | ----------- |
| 1xxx  | Model errors |
| 2xxx  | Controller errors |
| 3xxx  | Server errors |

## Usage

When an error occurs in your application, you will see a json response body with  ErrorsSavior [specific protocol](lib/errors_savior/presenter/protocol.rb), similar to the following:

```json
{
  "error_code": 2020,
  "message": "External request error",
  "timestamp": "2019-12-25 00:00:00 UTC",
  "errors": {
    "101": "Error with CustomExternalApi"
  }
}
```


If your application is running in development mode, you will see more information related to the error like `error_class` and `backtrace`:

```json
{
  "error_code": 1000,
  "message": "The record is invalid",
  "timestamp": "2019-12-25 00:00:00 UTC",
  "errors": {
    "email": {
      "102": "cant be empty",
      "104": "must be a string",
      "106": "must be an email"
    },
    "age": {
      "101": "must be an int"
    }
  },
  "metadata": {
    "stack_trace": [
      "... Line 1 ...",
      "... Line 2 ..."
    ],
    "error_class": "ActiveRecord::RecordInvalid",
    "api_origin": "internal_api_origin"
  }
}
```

### Use your own dicionary

It's possible to create your custom dictionary, if you need to modify any default Savior.

For example, you can change this default savior:
```yml
ActiveModel::ValidationError:
  error_code: 1001
  http_status_sym: unprocessable_entity
  http_status_code: 422
  message: One or more fields are invalid
```

With another values:
```yml
# config/locales/gems/errors_savior/en.yml

en:
  ActiveModel::ValidationError:
    error_code: 1234
    http_status_sym: bad_request
    http_status_code: 400
    message: Modified message
```

Remember to set in ErrorsSavior initializers the following variables:
* `external_dictionary_errors_path`
* `locale`

In the example above, we have used:
> config.external_dictionary_errors_path = 'config/locales/gems/errors_savior'

> config.locale = :en

**Note**
ErrorsSavior use `:en` locale as default.
If you need to use another locale, you should override all default Saviors with your custom locale


## Contributing

We hope that you will consider contributing to ErrorsSavior.
Please read [this overview](CONTRIBUTING.md#create-pull-request) for some information about how to get started.


## Releases
📢 [See what's changed in a recent version](https://github.com/Wolox/errors_savior/releases)


## Code of Conduct

Everyone interacting in the ErrorsSavior project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](CODE_OF_CONDUCT.md).


## License

**Errors Savior** is available under the [MIT license](LICENSE.txt).


## About

The current maintainers of this gem are :
* [Manuel Tejedor](https://github.com/mtejedorwolox)
* [Lucas Voboril](https://github.com/lucasVoboril)

This project was developed by:
* [Manuel Tejedor](https://github.com/mtejedorwolox)
* [Lucas Voboril](https://github.com/lucasVoboril)

At [Wolox](https://www.wolox.com.ar)

[![Wolox](https://raw.githubusercontent.com/Wolox/press-kit/master/logos/logo_banner.png)](https://www.wolox.com.ar)
