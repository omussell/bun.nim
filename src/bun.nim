## This module takes a FQDN as input and returns the contents of the matching YAML file.
##
## Dont actually need the yaml library because we are just dumping the whole file contents without reading them. we only care about matching the fqdn tokens to the matching file name.

import parseopt, strutils, sequtils, os

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

proc getTokens*(fqdn: string): seq[string] =
  var split_domains = fqdn.split(".")
  var split_tokens: seq[string]
  for token in split_domains:
    split_tokens.add(token.split("-"))
  result = split_tokens
  return result

proc findMatch*(tokens: seq[string]): string =
  var check_tokens = tokens
  while check_tokens.len > 0:
    var check_file: string = "/home/oem/bun.nim/nodes/" & join(check_tokens, "-") & ".yaml"
    if fileExists(check_file):
      return check_file
    else:
      var check_tokens = check_tokens.pop
  return "/home/oem/bun.nim/nodes/default.yaml"

proc hello*(num: int): int =
  result = num + 4

proc main*(fqdn: string) =
  #result = "---\nenvironment: production"
  var tokens = getTokens(fqdn)
  var matched = findMatch(tokens)
  let nodeFile = readFile("/home/oem/bun.nim/nodes/default.yaml")
  echo nodeFile

main(fqdn)
