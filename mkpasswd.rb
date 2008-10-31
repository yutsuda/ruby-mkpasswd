#/usr/bin/env ruby

require 'optparse'

def main(argv)
  options = {}

  option_parser = OptionParser.new {|opt|
    opt.on('-l LENGTH', '--len LENGTH', 'Set password length'){|v| options[:l] = v}
    opt.on('-a [OPTIONAL_CHARS]', '--add [OPTIONAL_CHARS]', 'Add optional characters'){|v| options[:a] = v}
    opt.parse!(argv)
  }

  if options[:l]
    puts mkpasswd(options[:l].to_i, (options[:a] || "").split(//))
  else
    puts option_parser
  end
end

def mkpasswd(n, optional_chars)
  passwd = ""

  lower_chars = ("a".."z").to_a
  upper_chars = ("A".."Z").to_a
  numbers = ("0".."9").to_a    

  passwd_chars = (lower_chars + upper_chars + numbers + optional_chars).uniq
  passwd_chars_size = passwd_chars.size

  passwd = Array.new(n){ passwd_chars[rand(passwd_chars_size)] }.join

  return passwd
end

main(ARGV)
