all:
	@homemaker -verbose base.tml .

elixir:
	homemaker -verbose elixir.tml .

bootstrap:
	homemaker -verbose -task bootstrap base.tml .
