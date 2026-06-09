all:
	homemaker -verbose base.tml .

homemaker.update:
	git subtree pull --prefix=vendor/homemaker homemaker master --squash

homemaker.build:
	cd vendor/homemaker && make all
	mv vendor/homemaker/build homemaker-build