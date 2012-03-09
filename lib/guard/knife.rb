require 'guard'
require 'guard/guard'

module Guard
  class Knife < Guard
    VERSION = '0.0.1'

    # Initialize a Guard.
    # @param [Array<Guard::Watcher>] watchers the Guard file watchers
    # @param [Hash] options the custom Guard options
    def initialize(watchers = [], options = {})
      super
      @options = {
        :config => '~/.chef/knife.rb'
      }.update(options)
    end

    # Call once when Guard starts. Please override initialize method to init stuff.
    # @raise [:task_has_failed] when start has failed
    def start
    end

    # Called when `stop|quit|exit|s|q|e + enter` is pressed (when Guard quits).
    # @raise [:task_has_failed] when stop has failed
    def stop
    end

    # Called when `reload|r|z + enter` is pressed.
    # This method should be mainly used for "reload" (really!) actions like reloading passenger/spork/bundler/...
    # @raise [:task_has_failed] when reload has failed
    def reload
    end

    # Called when just `enter` is pressed
    # This method should be principally used for long action like running all specs/tests/...
    # @raise [:task_has_failed] when run_all has failed
    def run_all
    end

    # Called on file(s) modifications that the Guard watches.
    # @param [Array<String>] paths the changes files or paths
    # @raise [:task_has_failed] when run_on_change has failed
    def run_on_change(paths)
      paths.each do |path|
        next if path.match(/\.swp$/)  # vim swap file

        upload(path)
      end
    end

    # Called on file(s) deletions that the Guard watches.
    # @param [Array<String>] paths the deleted files or paths
    # @raise [:task_has_failed] when run_on_change has failed
    def run_on_deletion(paths)
    end

    def upload(path)
      if path.match(/^cookbooks\/([^\/]*)\//)
        upload_cookbook($1)
      elsif path.match(/^data_bags\/(.*)\/(.*)$/)
        data_bag = $1
        item = $2
        upload_databag(data_bag, item)
      elsif path.match(/^(environments\/.*\.rb)$/)
        upload_environment($1)
      elsif path.match(/^(roles\/.*.rb)$/)
        upload_role($1)
      end
    end

    def knife_options
      options = ''
      @options.each do |key, value|
        case key
        when :config
          options += "-c #{value} "
        end
      end

      options
    end

    def upload_cookbook(cookbook)
      system("knife cookbook upload #{cookbook} #{knife_options}")
    end

    def upload_databag(data_bag, item)
      system("knife data bag from file #{data_bag} #{item} #{knife_options}")
    end

    def upload_environment(environment)
      system("knife environment from file #{environment} #{knife_options}")
    end

    def upload_role(role)
      system("knife role from file #{role} #{knife_options}")
    end
  end
end