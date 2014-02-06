# ssg - simple slide generator
# nibble <nibble@develsec.org> - MIT License - 2010

include config.mk

all:
	@echo sudo make install PREFIX=/usr

clean:
	@rm -f t/test.* t/test_black.* t/test_darkorange.*

dist: clean
	@echo creating dist tarball
	@mkdir -p ssg-${VERSION}
	@cp -R Makefile config.mk README TODO \
		ssg.1 ssg t doc ssg-${VERSION}
	@tar -cf ssg-${VERSION}.tar ssg-${VERSION}
	@gzip ssg-${VERSION}.tar
	@rm -rf ssg-${VERSION}

install:
	@echo installing executable file to ${DESTDIR}${PREFIX}/bin
	@mkdir -p ${DESTDIR}${PREFIX}/bin
	@cp -f ssg ${DESTDIR}${PREFIX}/bin
	@chmod 755 ${DESTDIR}${PREFIX}/bin/ssg
	@echo installing manual page to ${DESTDIR}${MANPREFIX}/man1
	@mkdir -p ${DESTDIR}${MANPREFIX}/man1
	@sed "s/VERSION/${VERSION}/g" < ssg.1 > ${DESTDIR}${MANPREFIX}/man1/ssg.1
	@chmod 644 ${DESTDIR}${MANPREFIX}/man1/ssg.1

deinstall uninstall:
	@echo removing executable file from ${DESTDIR}${PREFIX}/bin
	@rm -f ${DESTDIR}${PREFIX}/bin/ssg
	@echo removing manual page from ${DESTDIR}${MANPREFIX}/man1
	@rm -f ${DESTDIR}${MANPREFIX}/man1/ssg.1

test:
	cd t && cat test | ../ssg > test.ps
	cd t && cat test | ../ssg -c ../doc/config_black > test_black.ps
	cd t && cat test | ../ssg -c ../doc/config_darkorange > test_darkorange.ps

test-pdf: test
	cd t && ps2pdf test.ps
	cd t && ps2pdf test_black.ps
	cd t && ps2pdf test_darkorange.ps

.PHONY: all clean dist install uninstall test test-pdf
