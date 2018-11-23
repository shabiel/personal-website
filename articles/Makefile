HTML := $(patsubst %.rst,%.html,$(wildcard *.rst))

%.html:	%.rst
	pandoc --toc $< -f rst -t html5 --template template.html5 -o $@
all: $(HTML)
clean:
	rm *.html
