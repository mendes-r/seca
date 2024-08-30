# NOTES

## Compilation Process

1) Preprocessor 
2) Compiler -> assembly code
3) Assembler -> machine code
4) Linker

## Commands

Stopping after preprocessing, and removing debug code:

```shell
$ gcc -E -P example.c
```

Stopping after compiling, and assembly with intel sintax:

```shell
$ gcc -S -masm=intel example.c
```

Stopping after assembler, outputing the object files:

```shell
$ gcc -c example.c
```

User ***file*** command to obtain more info:

```shell
$ file example.s
ex1.s: assembler source, ASCII text

$ file example.o
ex1.o: ELF 64-bit LSB relocatable, x86-64, version 1 (SYSV), not stripped

$ file example.out
a.out: ELF 64-bit LSB executable, x86-64, version 1 (SYSV), dynamically linked, interpreter /lib64/ld-linux-x86-64.so.2, BuildID[sha1]=52f7a8058cc8139c51f7c203fd6eec46a5d0d4b7, for GNU/Linux 3.2.0, not stripped
```

Use ***readelf*** to display the content of ELF format files:
... in this case we want only to see the symbols.

```shell
$ readelf --syms example.out

Symbol table '.dynsym' contains 5 entries:
   Num:    Value          Size Type    Bind   Vis      Ndx Name
     0: 0000000000000000     0 NOTYPE  LOCAL  DEFAULT  UND 
     1: 0000000000000000     0 FUNC    GLOBAL DEFAULT  UND _[...]@GLIBC_2.34 (2)
     2: 0000000000000000     0 FUNC    GLOBAL DEFAULT  UND puts@GLIBC_2.2.5 (3)
     ...
```

To strip a binary from symbols and sections:

```shell
$ strip --strip-all example.out
```

To disassembling a binary:

```shell
$ objdump -M intel -d example.out
...
```
