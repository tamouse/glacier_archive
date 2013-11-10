# GlacierArchive

Archive a directory and upload to glacier

## Installation

    $ gem install glacier_archive

## Usage

- `--fogrc FOGRCFILENAME` - file name with fog credentials. Defaults
  to $HOME/.fog

- `--vault VAULTNAME` - AWS Glacier vault to upload to

- `--format TGZ` - format for archive. Choices are `TGZ` (gzip
  compressed tar archive), `ZIP` (zip archive)

- `--[no]-verbose` - give information about what is happening. Normally,
  glacier_achive produces no output unless errors occur

- `--[no]-debug` - output a lot of info for debugging purposes

Default configurations can be saved in `$HOME/.glacier_archive` as
either a string of options as on the command line, or a YAML file.

### Example configuration file

   vault: my-precious-vault
   format: TGZ
   verbose: true

Save archives to the vault `my-precious-vault`, using the
gzip-compressed tar archive, and always be chatty. (The latter can be
over-ridden on the command line with `--no-verbose`)

## Contributing

"ForkitBranchitCommititPushit" (apologies to Daft Punk)

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
