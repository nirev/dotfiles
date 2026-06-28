all:
	homemaker -verbose base.tml .

homemaker.update:
	git subtree pull --prefix=vendor/homemaker homemaker master --squash

homemaker.build:
	cd vendor/homemaker && make all
	mv vendor/homemaker/build homemaker-build

BREWFILE := $(CURDIR)/.Brewfile

# Show outdated packages and verify the Brewfile matches what's installed.
brew.check:
	@echo "==> Outdated formulae & casks"
	brew outdated
	@echo "==> Brewfile check (errors that matter: 'needs to be tapped' / missing)"
	HOMEBREW_NO_AUTO_UPDATE=1 brew bundle check --file=$(BREWFILE) --verbose || true

# Update Homebrew, install anything new from the Brewfile, upgrade everything,
# then clean up old versions.
brew.update:
	brew update
	brew bundle install --file=$(BREWFILE)
	brew upgrade
	-mas upgrade
	brew cleanup