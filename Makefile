#
# ae-drive-inspector Makefile
#

# make us OS-independent ... at least for MacOS and Linux
OS := $(shell uname -s)
ifeq (Linux, ${OS})
	DATE := $(shell date --iso-8601)
else
	DATE := $(shell date "+%Y-%m-%d")
endif

# Python version
PYTHON := python

REPO := ae-drive-inspector

FILES = \
	Makefile \
	.gitattributes \
	.gitignore \
	README.md \
	LICENSE

.PHONY: help
help:
	cat Makefile
	echo "OS:" ${OS}
	echo "DATE:" ${DATE}

# GIT operations

diff: .gitattributes
	git diff

status:
	git status

# this brings the remote copy into sync with the local one
commit: .gitattributes
	git commit ${FILES}
	git push -u ${REPO} master 
	git push --tags
	git describe --dirty --always --tags > version.txt

# This brings the local copy into sync with the remote (master)
pull: .gitattributes
	git pull origin master

version.txt:
	git describe --dirty --always --tags > version.txt

log: .gitattributes version.txt
	git log --pretty=oneline
