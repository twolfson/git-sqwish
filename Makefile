PREFIX ?= /usr/local
MANPREFIX ?= "$(PREFIX)/share/man/man1"
BINS = $(wildcard bin/git-*)
MANS = $(wildcard man/git-*.md)
MAN_HTML = $(MANS:.md=.html)
MAN_PAGES = $(MANS:.md=.1)
DOTGIT_DIRS := $(wildcard test/test_files/*/dotgit)
GIT_DIRS := $(wildcard test/test_files/*/.git)

docs: $(MAN_HTML) $(MAN_PAGES)

install:
	@mkdir -p $(DESTDIR)$(MANPREFIX)
	@mkdir -p $(DESTDIR)$(PREFIX)/bin
	@echo "... installing bins to $(DESTDIR)$(PREFIX)/bin"
	@echo "... installing man pages to $(DESTDIR)$(MANPREFIX)"
	@$(foreach BIN, $(BINS), \
		echo "... installing `basename $(BIN)`"; \
		cp -f $(BIN) $(DESTDIR)$(PREFIX)/$(BIN); \
	)
	cp -f man/git-*.1 $(DESTDIR)$(MANPREFIX)
	@mkdir -p $(DESTDIR)/etc/bash_completion.d
	cp -f etc/bash_completion.sh $(DESTDIR)/etc/bash_completion.d/git-sqwish

man/%.html: man/%.md
	ronn \
		--manual "Git Sqwish" \
		--html \
		--pipe \
		$< > $@

man/%.1: man/%.md
	ronn -r \
		--manual "Git Sqwish" \
		--pipe \
		$< > $@

uninstall:
	@$(foreach BIN, $(BINS), \
		echo "... uninstalling $(DESTDIR)$(PREFIX)/$(BIN)"; \
		rm -f $(DESTDIR)$(PREFIX)/$(BIN); \
	)
	@$(foreach MAN, $(MAN_PAGES), \
		echo "... uninstalling $(DESTDIR)$(MANPREFIX)/$(MAN)"; \
		rm -f $(DESTDIR)$(MANPREFIX)/$(MAN); \
	)
	rm -f $(DESTDIR)/etc/bash_completion.d/git-sqwish

clean: docclean

docclean:
	rm -f man/*.1
	rm -f man/*.html

test-clean:
	@echo "# Cleaning up test files"
	-rm test.stderr

test: test-clean
	# Running prompt test
	./test/run.sh

move-dotgit-to-git:
	# Moving over the dotgit directories to git directories
	@$(foreach ORIG_DIR, $(DOTGIT_DIRS), \
		echo "Moving $(ORIG_DIR) to $(ORIG_DIR)/../.git"; \
		mv $(ORIG_DIR) $(ORIG_DIR)/../.git; \
	)

move-git-to-dotgit:
	# Moving over the git directories to dotgit directories
	@$(foreach ORIG_DIR, $(GIT_DIRS), \
		echo "Moving $(ORIG_DIR) to $(ORIG_DIR)/../dotgit"; \
		mv $(ORIG_DIR) $(ORIG_DIR)/../dotgit; \
	)

demo:
	# Output demo commands
	@echo "Run the following commands:"
	@echo '"""'
	@echo '##################'
	@echo '### DEMO SETUP ###'
	@echo '##################'
	@echo 'bash -l -c "script -q -c bash docs/git-sqwish-demo.txt"'
	@echo 'cd "$$(mktemp -d)"'
	@echo 'PS1="$$ "'
	@echo 'git init'
	@echo 'echo "<?xml>" > sitemap.xml; git add sitemap.xml'
	@echo 'git commit -m "Initial commit"'
	@echo 'git checkout -b dev/add.support.page'
	@echo 'git checkout master'
	@echo 'echo "<xml>index.html</xml>" >> sitemap.xml; git add sitemap.xml'
	@echo 'git commit -m "Added home page"'
	@echo 'git checkout -'
	@echo '# Make normal changes'
	@echo 'echo "<p>Email us</p>" > support.html; git add support.html'
	@echo 'git commit -m "Created support page"'
	@echo '# Introduce conflictable code'
	@echo 'echo "<xml>support.html</xml>" >> sitemap.xml; git add sitemap.xml'
	@echo 'git commit -m "Indexed support page to sitemap"'
	@echo '##################'
	@echo '### DEMO START ###'
	@echo '##################'
	@echo '# On a development branch with normal and conflicting changes'
	@echo 'git log --all --graph --decorate --oneline'
	@echo '# Sync with master (as opposed to `git rebase`)'
	@echo 'git merge master # Interchangable with `git pull`'
	@echo 'echo "DELETE ME"; git checkout master -- .; git add -A; git commit -m "Merge branch '"'master'"' into dev/add.support.page"'
	@echo 'git mergetool -y; git commit # Deal with *one* set of merge conflicts'
	@echo '# Squash changes'
	@echo 'git sqwish master --message "Added support page"'
	@echo '# History is preserved on original branch, changes are sqwished to one commit'
	@echo 'git log --all --graph --decorate --oneline --simplify-by-decoration -n 3'
	@echo 'exit'
	@echo '"""'

.PHONY: docs clean docclean install uninstall
