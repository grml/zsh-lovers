all:
	# html:
	asciidoc zsh-lovers.1.txt
	mv zsh-lovers.1.html zsh-lovers.html

	# manpage:
	a2x -vv --no-xmllint -f manpage zsh-lovers.1.txt

	# pdf:
	a2x -vv --no-xmllint -f pdf zsh-lovers.1.txt
	mv zsh-lovers.1.pdf zsh-lovers.pdf

clean:
	rm -f zsh-lovers.1 zsh-lovers.html zsh-lovers.pdf

