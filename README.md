Guard::Knife
============

Knife guard allows to update cookbooks, data bags, environments, and roles
automatically when files are modified.

Install
-------

Please be sure to have [Guard](https://github.com/guard/guard) installed before
continueing.

Install the gem:

    $ gem install guard-knife

Add it to your Gemfile

``` ruby
gem 'guard-knife'
```

Add guard definition to your Guardfile by running this command:

    $ guard init knife

Guardfile
---------

``` ruby
guard 'knife' do
  watch(%r{^cookbooks/.+$})
  watch(%r{^data_bags/.+$})
  watch(%r{^environments/.+$})
  watch(%r{^roles/.+$})
end
```

Options
-------

By default Guard::Knife uses your `~/.chef/knife.rb`. To use a different
configuration file, use the `:config` option:

``` ruby
guard 'knife', :config => '~/.chef/other_knife_config.rb' do
  # ...
end
```

Development
-----------

* Source hosted at [GitHub](https://github.com/nistude/guard-knife)
* Report Issues/Questions/Feature requests on [GitHub Issues](https://github.com/nistude/guard-knife/issues)

Pull requests are very welcome! Make sure your patches are well tested. Please
create a topic branch for every separate change you make.

Author
------

[Nikolay Sturm](http://blog.nistu.de/)
