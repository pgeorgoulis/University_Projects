CC=cc

all:
	make -f Makefile.rpc
	${CC} socket_client.c -o socket_client

clean:
	make -f Makefile.rpc clean
	rm -f socket_client *.core