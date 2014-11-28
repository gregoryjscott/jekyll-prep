# Jekyll::Prep

Prepare Jekyll page data using Ruby.

## Installation

See [Jekyll's documentation for installing Jekyll plugins](http://jekyllrb.com/docs/plugins/#installing-a-plugin).

## Usage

1. Create a `_prep` directory in your Jekyll project.
2. Inside the `_prep` directory, create `.rb` files that correspond to your `.md` Jekyll pages. For example, if you have a `/people/jill.md` Jekyll page then create a `_prep/people/jill.rb` file.
3. Inside the `.rb` files, define subclasses of `Jekyll::Prep::Script` that define a `prepare` method that will receive an instance of Jekyll::Page. The subclass namespaces must align with the `.rb` file paths minus the leading underscore. For example, the file `_prep/people/jill.rb` should contain `Prep::People::Jill`.
4. Inside the prepare methods, do whatever you want to `page.data`.

```ruby
module Prep

  module People

    class Jill < Jekyll::Prep::Script

      def prepare(page)
        page.data['something new'] = 'was added during prep'
      end
    end
  end
end
```

## Contributing

1. Fork it (https://github.com/gregoryjscott/jekyll-prep/fork)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
