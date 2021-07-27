## This module takes a FQDN as input and returns the contents of the matching YAML file.
##
## This is intended to be used as an External Node Classifier with Puppet. It is invoked
## with the FQDN of the node as the first positional parameter given to the binary. 
## Bun then returns the contents of the YAML file which matches that given FQDN. 
##
## It finds the file by splitting the FQDN on `.` and `-`, joining the tokens with `-`, 
## and then removing each token from right to left until it finds a matching file name.
##
## So for example, given the node name of `test-server.example.com`, bun is invoked with
## `bun test-server.example.com`. Bun will split the FQDN to become 
## `@["test", "server", "example", "com"]`. This is then joined together with hyphens `-` 
## and the following file paths tested.
##
## ```
## - /etc/puppetlabs/puppet/bun.nim/nodes/test-server-example-com.yaml
## - /etc/puppetlabs/puppet/bun.nim/nodes/test-server-example.yaml
## - /etc/puppetlabs/puppet/bun.nim/nodes/test-server.yaml
## - /etc/puppetlabs/puppet/bun.nim/nodes/test.yaml
## ```
##
## Each of those file paths are tested in turn until bun finds an existing file and returns 
## its contents. Otherwise, the contents of the default.yaml file is returned.
import parseopt, strutils, os

proc writeHelp() = echo """
  bun fqdn

  bun testserver.example.com

  returns:

  ---
  environment: production
  """

proc writeVersion() = echo "1.0.0"

var args: OptParser = initOptParser()
var fqdn: string
var config_path: string = "/etc/puppetlabs/bun.nim/"

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
  ## Splits the FQDN into tokens. Splits on `.` and `-`.
  ## Most server names use both periods and hyphens, for 
  ## example, test-server.example.com. This would be split into
  ## `@["test", "server", "example", "com"]`
  var split_domains = fqdn.split(".")
  var split_tokens: seq[string]
  for token in split_domains:
    split_tokens.add(token.split("-"))
  result = split_tokens
  return result

proc findMatch*(tokens: seq[string]): string =
  ## Iterates over the tokens to find the first matching
  ## file. Works from right to left, so `@["test", "server", "example", "com"]`
  ## looks for the following files in order:
  ##
  ## ```
  ## - test-server-example-com.yaml
  ## - test-server-example.yaml
  ## - test-server.yaml
  ## - test.yaml
  ## ```
  ##
  ## If a file isnt found, it instead returns `default.yaml`
  var check_tokens = tokens
  while check_tokens.len > 0:
    var check_file: string = config_path & "nodes/" & join(check_tokens, "-") & ".yaml"
    if fileExists(check_file):
      return check_file
    else:
      var check_tokens = check_tokens.pop
  var default_file: string = config_path & "nodes/default.yaml"
  return default_file

proc main(fqdn: string) =
  var tokens = getTokens(fqdn)
  var matched = findMatch(tokens)
  let nodeFile = readFile(matched)
  echo nodeFile

main(fqdn)
