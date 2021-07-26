# bun

Simple YAML Based Puppet ENC

[Documentation](https://omussell.github.io/bun.nim/bun.html)

## Install

- [Install the nim compiler](https://nim-lang.org/install.html). On Ubuntu you can use `apt`.
- Clone the repo to the Puppet dir: `git clone https://github.com/$name/bun.nim.git /etc/puppetlabs/puppet/bun.nim`
- `cd /etc/puppetlabs/puppet/bun.nim`
- `nimble build`

## Setup
- Fork this repo
- Follow the install steps
- Create your files in the nodes directory
- You might want to move the `bun` binary into some other directory like `/usr/bin`, `/usr/local/bin` or `/opt`.
- [Follow the Puppet instructions](https://puppet.com/docs/puppet/7/nodes_external.html#connect_a_new_enc) for using a binary as the ENC.

## Tests

In the `tests` directory. Run with `nimble test`.

## Documentation

In the `docs` directory. Generate with `nim doc`
