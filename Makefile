# Makefile
# LuoXiaoqiu <qilvilu@gmail.com>

all: htcnetup

CC=gcc

INSTDIR = /usr/local/bin

htcnetup : htcnetup.c
	$(CC) $(CFLAGS) -o $@ $^ $(LDFLAGS)

clean :
	rm -rf htcnetup

install:htcnetup
	
	@if [ -d $(INSTDIR) ]; \
	then \
	echo “If your {idProduct} is not "0fb4", Please change it in 49-htcnet.rules first.”; \
	echo “If your phone_usb_device is not "usb0", Please change it in htcnet.sh first.”; \
	cp htcnetup $(INSTDIR)/usr/bin/;\
	cp htcnet $(INSTDIR)/etc/init.d/;\
	cp conf/htcnet /etc/default/;\
	cp 49-htcnet.rules /etc/udev/rules.d;\
	chmod a+x $(INSTDIR)/htcnetup;\
	chmod a+x $(INSTDIR)/etc/init.d/htcnet;\
	echo “Installed in $(INSTDIR)“;\
	else \
	echo “Sorry, $(INSTDIR) does not exist”;\
	fi 

uninstall:
	@if [ -f $(INSTDIR)/usr/bin/htcnetup ]; \
	then \
	rm $(INSTDIR)/usr/bin/htcnetup;\
	echo “$(INSTDIR)/usr/bin/htcnetup is deleted.”;\
	else \
	echo “Sorry, $(INSTDIR)/usr/bin/htcnetup does not exist”;\
	fi
	@if [ -f $(INSTDIR)/etc/init.d/htcnet ]; \
	then \
	rm $(INSTDIR)/etc/init.d/htcnet;\
	echo “$(INSTDIR)/etc/init.d/htcnet is deleted.”;\
	else \
	echo “Sorry, $(INSTDIR)/etc/init.d/htcnet does not exist”;\
	fi
	@if [ -f /etc/default/htcnet ]; \
	then \
	rm /etc/default/htcnet;\
	echo “/etc/default/htcnet is deleted.”;\
	else \
	echo “Sorry, /etc/default/htcnet does not exist”;\
	fi
	@if [ -f /etc/udev/rules.d/49-htcnet.rules ]; \
	then \
	rm /etc/udev/rules.d/49-htcnet.rules;\
	echo “/etc/udev/rules.d/49-htcnet.rules is deleted.”;\
	else \
	echo “Sorry, /etc/udev/rules.d/49-htcnet.rules does not exist”;\
	fi

