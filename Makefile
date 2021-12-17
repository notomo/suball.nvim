test:
	vusted --shuffle -v
.PHONY: test

doc:
	rm -f ./doc/suball.nvim.txt ./README.md
	nvim --headless -i NONE -n +"lua dofile('./spec/lua/suball/doc.lua')" +"quitall!"
	cat ./doc/suball.nvim.txt ./README.md
.PHONY: doc
