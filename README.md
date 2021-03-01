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

## Traditional Rails vs ErrorsSavior

<details><summary>Example error handle without ErrorsSavior</summary>
<p>

```
# Modificated files

# app/controllers/application_controller.rb
# app/controllers/concerns/errors_helper.rb

# (Custom errors)
# app/errors/invalid_schema_error.rb
# app/errors/my_custom_error.rb
# ....
```

```rb
# app/controllers/application_controller.rb

class ApplicationController < ActionController::Base
  include ErrorsHelper
end
```

```rb
# app/controllers/concerns/errors_helper.rb

module ErrorsHelper
  extend ActiveSupport::Concern

  included do
    rescue_from ActionController::ParameterMissing, with: :unprocessable_entity
    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
    rescue_from ArgumentError, with: :unprocessable_entity
    rescue_from MyCustomError, with: :render_my_custom_error
    rescue_from Pundit::NotAuthorizedError, with: :unauthorized
    # ...

    rescue_from InvalidSchemaError do |e|
      render json: { message: e.message }, status: :bad_request
    end
  end

  private

  def render_error(error, status)
    render json: { errors: [error] }, status: status
  end

  def unprocessable_entity(error)
    render_error(error, :unprocessable_entity)
  end

  def record_not_found(error)
    render_error(error, :not_found)
  end

  def unauthorized
    head(:unauthorized)
  end

  def render_my_custom_error
    render_error(MyCustomError.new.message, :not_acceptable)
  end
end

```

```rb
# app/errors/invalid_schema_error.rb

class InvalidSchemaError < StandardError
  def message
    "Provided parameters doesn't validate with the expected schema"
  end
end
```

```rb
# app/errors/my_custom_error.rb

class MyCustomError < StandardError
  def message
    "Custom error, error message"
  end
end
```

</p>
</details>


<details><summary>Error handle using Errors Savior</summary>
<p>

```
# Modificated files

# Gemfile
# config/initializers/errors_savior.rb (automatically generated by gem generator)
# config/locales/gems/errors_savior/en.yml (dictionary with errors)
```

```rb
# Gemfile

# ...
gem 'errors_savior'
# ...
```

```rb
# config/initializers/errors_savior.rb

ErrorsSavior.configure do |config|
  # ErrorsSavior needs your api_origin metadata if you like to show this information on responses
  # config.api_origin = nil

  # Merge your own dicionary with ErrorsSavior dictionary
  config.external_dictionary_errors_path = 'config/locales/gems/errors_savior'
  config.locale = :en
end
```

```rb
# config/locales/gems/errors_savior/en.yml

en:
  ArgumentError:
    error_code: 1010
    http_status_sym: unprocessable_entity
    http_status_code: 422
    message: 'One or more fields are invalid'

  MyCustomError:
    error_code: 2010
    http_status_sym: not_acceptable
    http_status_code: 404
    message: 'Custom error, error message'

  Pundit::NotAuthorizedError:
    error_code: 2020
    http_status_sym: unauthorized
    http_status_code: 401
    message: "User not allowed to perform that action"

  InvalidSchemaError:
    error_code: 2030
    http_status_sym: not_acceptable
    http_status_code: 404
    message: "Provided parameters doesn't validate with the expected schema"

```
</p>
</details>


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


### Rspec helpers

You only need to add this line in your `rails_helper.rb`

```ruby
# spec/rails_helper.rb

require 'errors_savior/rspec'
```

#### `be_rescuted_by_savior` Rspec matcher
You can use the `be_rescuted_by_savior` matcher to test your endpoints.

```rb
# spec/errors/custom_error_spec.rb
describe DummiesController do
  it { expect(response).to be_rescuted_by_savior }
end
```

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
