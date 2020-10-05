CC=gcc
CFLAGS=-I.
LDFLAGS=-lcunit
EXE=a.out

$(EXE): event-queue.c ../event-queue.c ../spi-ctrl.c
	$(CC) $(CFLAGS) event-queue.c ../event-queue.c ../spi-ctrl.c $(LDFLAGS) -o $(EXE)

clean:
	rm -f a.out

