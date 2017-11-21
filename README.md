# vidyo-ruby

Create authentication tokens for [vidyo][1] sessions in Ruby. I found token generation code in javascript, C#, and Python, but could not find anything for Ruby.

Learn more about the Vidyo API here: [Vidyo API Docs][2].

## Install

```bash
$ bundle
```

## Usage

```ruby
token = Vidyo::Token.new(
  key: 'your_vidyo_developer_key',
  application_id: 'vidyo_application_id',
  user_name: 'the user joining the session',
  expires_in: 3600
)
token.serialize
```

## Tests

```bash
$ rspec
```

## Based On

* https://github.com/Vidyo/generateToken-c-sharp
* https://static.vidyo.io/4.1.17.5/utils/generateToken.py


[1]: http://vidyo.io "Vidyo Homepage"
[2]: https://developer.vidyo.io/documentation/4-1-17-5/getting-started "Vidyo API Docs"
