CC=gcc
CFLAGS=-I.
LDFLAGS=-lcunit
EXE=a.out

$(EXE): merge_outputs.c ../merge_outputs.c
	$(CC) $(CFLAGS) merge_outputs.c ../merge_outputs.c $(LDFLAGS) -o $(EXE)

clean:
	rm -f a.out

