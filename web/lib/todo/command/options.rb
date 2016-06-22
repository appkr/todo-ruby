# coding: utf-8

require 'optparse'

module Todo

  class Command

    module Options

      GREEN = "\033[32m";
      YELLOW = "\033[33m";
      RESET = "\033[0m";

      def self.parse!(argv)
        options = {}

        # OptionParser only parses string starting with '-' or '--'
        # So we have to implement our own sub command parser.
        sub_command_parsers = create_sub_command_parsers(options)
        command_parser = create_command_parser

        begin
          # Execute command_parser
          command_parser.order! argv

          # argv is an Array. e.g. ['create', '--name=foo']
          # 'create' is gone by shift().
          options[:command] = argv.shift

          # Execute sub_command_parser['create']
          sub_command_parsers[options[:command]].parse! argv

          if %w(update delete).include?(options[:command])
            # Get record id off of arguments
            raise ArgumentError, "#{options[:command]} id not found." if argv.empty?
            options[:id] = Integer(argv.first)
          end
        rescue OptionParser::MissingArgument, OptionParser::InvalidOption, ArgumentError => e
          abort e.message
        end

        options
      end

      def self.create_sub_command_parsers(options)
        sub_command_parsers = Hash.new do |_k, v|
          # Raise exception when undefined sub-command is passed.
          # e.g. _k = 'create', v = '--name=foo'
          raise ArgumentError, "'#{v}' is not a valid sub-command."
        end

        sub_command_parsers['create'] = OptionParser.new do |opt|
          # Not immediately invoking, like callback function
          opt.banner = "#{YELLOW}Usage:#{RESET}\n  #{opt.program_name} create <args>"
          opt.on('-n VAL', '--name=VAL', 'task name') { |v| options[:name] = v }
          opt.on('-c VAL', '--content=VAL', 'task content') { |v| options[:content] = v }
          opt.on_tail('-h', '--help', 'Show this message') { |_v| help_sub_command(opt) }
        end

        sub_command_parsers['list'] = OptionParser.new do |opt|
          opt.banner = "#{YELLOW}Usage:#{RESET}\n  #{opt.program_name} list <args>"
          opt.on('-s VAL', '--status=VAL', 'search status') { |v| options[:status] = v }
          opt.on_tail('-h', '--help', 'Show this message') { |_v| help_sub_command(opt) }
        end

        sub_command_parsers['update'] = OptionParser.new do |opt|
          opt.banner = "#{YELLOW}Usage:#{RESET}\n  #{opt.program_name} update id <args>"
          opt.on('-n VAL', '--name=VAL', 'update name') { |v| options[:name] = v }
          opt.on('-c VAL', '--content=VAL', 'update content') { |v| options[:content] = v }
          opt.on('-s VAL', '--status=VAL', 'update status') { |v| options[:status] = v }
          opt.on_tail('-h', '--help', 'Show this message') { |_v| help_sub_command(opt) }
        end

        sub_command_parsers['delete'] = OptionParser.new do |opt|
          opt.banner = "#{YELLOW}Usage:#{RESET}\n  #{opt.program_name} delete id"
          opt.on_tail('-h', '--help', 'Show this message') { |_v| help_sub_command(opt) }
        end

        sub_command_parsers['server'] = OptionParser.new do |opt|
          opt.banner = "#{YELLOW}Usage:#{RESET}\n  #{opt.program_name} server <args>"
          opt.on('-p VAL', '--port=VAL', 'Port(default:9292)') { |v| options[:port] = v }
          opt.on_tail('-h', '--help', 'Show this message') { |_v| help_sub_command(opt) }
        end

        sub_command_parsers
      end

      def self.create_command_parser
        OptionParser.new do |opt|
          sub_command_help = [
              {name: "#{GREEN}list#{RESET}", summary: 'List Tasks'},
              {name: "#{GREEN}create#{RESET}", summary: 'Create a Task'},
              {name: "#{GREEN}update#{RESET}", summary: 'Update the specified Task'},
              {name: "#{GREEN}delete#{RESET}", summary: 'Delete the specified Task'},
              {name: "#{GREEN}server#{RESET}", summary: 'Start http server process'},
          ]

          opt.banner = "#{YELLOW}Usage:#{RESET}\n  #{opt.program_name} [-h|--help [-v|--version] <command> [<args>]"
          opt.separator ''
          opt.separator "#{YELLOW}Available Commands:#{RESET}"
          sub_command_help.each do |command|
            opt.separator [opt.summary_indent, command[:name].ljust(40), command[:summary]].join(' ')
          end

          opt.on_head('-h', '--help', 'Show this message') do |v|
            puts opt.help
            exit
          end

          # Not immediately executing, like callback funtion
          opt.on_head('-v', '--version', 'Show program version') do |v|
            opt.version = Todo::VERSION
            puts opt.ver
            exit
          end
        end
      end

      def self.help_sub_command(parser)
        puts parser.help
        exit
      end

    end

  end

end