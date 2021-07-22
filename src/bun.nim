## This module takes a FQDN as input and returns the contents of the matching YAML file.

import parseopt

proc writeHelp() = echo "get help"

proc writeVersion() = echo "1.0.0"

var args: OptParser = initOptParser()
var fqdn: string

for kind, key, val in args.getopt():
    case kind
    of cmdArgument:
      fqdn = key
    of cmdLongOption, cmdShortOption:
      case key
      of "help", "h": writeHelp()
      of "version", "v": writeVersion()
    of cmdEnd: break

echo fqdn


#proc bun*(question: string): Answer =

proc hello*(num: int): int =
  result = num + 4
