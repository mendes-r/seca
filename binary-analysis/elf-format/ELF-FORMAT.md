# NOTES

## The ELF Format - Inspection

### ELF Executable header

Definition of ELF64\_Ehdr in _/usr/include/elf.h_:

```c
typedef struct {
    unsigned char e_ident[16];  /* Magic number and other info       */
    uint16_t    e_type;         /* Object file type                  */
    uint16_t    e_machine;      /* Architecture                      */
    uint32_t    e_version;      /* Object file version               */
    uint64_t    e_entry;        /* Entry point virtual address       */
    uint64_t    e_phoff;        /* Programm header table file offset */
    uint64_t    e_shoff;        /* Section header table file offset  */
    uint32_t    e_flags;        /* Processsor specific flags         */
    uint16_t    e_ehsize;       /* ELF header size in bytes          */
    uint16_t    e_phentsize;    /* Program header table entry size   */
    uint16_t    e_phnum;        /* Program header table entry count  */
    uint16_t    e_shentsize     /* Section header table entry size   */
    uint16_t    e_shnum;        /* Section header table entry count  */
    uint16_t    e_shstrndx;     /* Section header string table index */
} Elf64_Ehdr
```

```sh
$ readelf -h ls

ELF Header:
  Magic:   7f 45 4c 46 02 01 01 00 00 00 00 00 00 00 00 00 
  Class:                             ELF64
  Data:                              2's complement, little endian
  Version:                           1 (current)
  OS/ABI:                            UNIX - System V
  ABI Version:                       0
  Type:                              DYN (Position-Independent Executable file)
  Machine:                           Advanced Micro Devices X86-64
  Version:                           0x1
  Entry point address:               0x6d30
  Start of program headers:          64 (bytes into file)
  Start of section headers:          139864 (bytes into file)
  Flags:                             0x0
  Size of this header:               64 (bytes)
  Size of program headers:           56 (bytes)
  Number of program headers:         13
  Size of section headers:           64 (bytes)
  Number of section headers:         32
  Section header string table index: 31
```

 Looking at the _ls_ hex with __xxd__ hex viewer:

```sh
$ xxd ls | head -n 30

# [16 bytes] e_ident ELF
00000000: 7f45 4c46 0201 0100 0000 0000 0000 0000  
# [2 bytes] e_type ET_DYN 3 Shared object file
00000010: 0300 
# [2 bytes] e_machine EM_X86_64 62 = 0x3e AMD x86-64 architecture
               3e00 
# [4 bytes] e_version EV_CURRENT 1 Current version
                    0100 0000 
# [8 bytes] e_entry 0x6d30
                              306d 0000 0000 0000 
# [8 bytes] e_phoff 64 = 0x40
00000020: 4000 0000 0000 0000 
# [8 bytes] e_shoff 139864 = 0x022258
                              5822 0200 0000 0000 
# [4 bytes] e_flag
00000030: 0000 0000 
# [2 bytes] e_ehsize 64 = 0x40
                    4000 
# [2 bytes] e_phentsize 56 = 0x38
                         3800 
# [2 bytes] e_phum 13 = 0x0d
                              0d00
# [2 bytes] e_shentsize 64 = 0x40
                                   4000 
# [2 bytes] e_shnum 32 = ox20
                                        2000
# [2 bytes] e_shstrndxv 31 = 0x1f
                                             1f00  
00000040: 0600 0000 0400 0000 4000 0000 0000 0000  
00000050: 4000 0000 0000 0000 4000 0000 0000 0000  
00000060: d802 0000 0000 0000 d802 0000 0000 0000  
00000070: 0800 0000 0000 0000 0300 0000 0400 0000 
00000080: 1803 0000 0000 0000 1803 0000 0000 0000 
00000090: 1803 0000 0000 0000 1c00 0000 0000 0000 
000000a0: 1c00 0000 0000 0000 0100 0000 0000 0000  

...
```

### Program header - Sections and Segments 

```sh
$ readelf --wide --segments ls

Elf file type is DYN (Position-Independent Executable file)
Entry point 0x6d30
There are 13 program headers, starting at offset 64

Program Headers:
  Type           Offset   VirtAddr           PhysAddr           FileSiz  MemSiz   Flg Align
  PHDR           0x000040 0x0000000000000040 0x0000000000000040 0x0002d8 0x0002d8 R   0x8
  INTERP         0x000318 0x0000000000000318 0x0000000000000318 0x00001c 0x00001c R   0x1
      [Requesting program interpreter: /lib64/ld-linux-x86-64.so.2]
  LOAD           0x000000 0x0000000000000000 0x0000000000000000 0x003848 0x003848 R   0x1000
  LOAD           0x004000 0x0000000000004000 0x0000000000004000 0x014b91 0x014b91 R E 0x1000
  LOAD           0x019000 0x0000000000019000 0x0000000000019000 0x006db0 0x006db0 R   0x1000
  LOAD           0x01fed0 0x0000000000020ed0 0x0000000000020ed0 0x001388 0x002650 RW  0x1000
  DYNAMIC        0x0209d8 0x00000000000219d8 0x00000000000219d8 0x000210 0x000210 RW  0x8
  NOTE           0x000338 0x0000000000000338 0x0000000000000338 0x000050 0x000050 R   0x8
  NOTE           0x000388 0x0000000000000388 0x0000000000000388 0x0000d0 0x0000d0 R   0x4
  GNU_PROPERTY   0x000338 0x0000000000000338 0x0000000000000338 0x000050 0x000050 R   0x8
  GNU_EH_FRAME   0x01dde4 0x000000000001dde4 0x000000000001dde4 0x0005dc 0x0005dc R   0x4
  GNU_STACK      0x000000 0x0000000000000000 0x0000000000000000 0x000000 0x000000 RW  0x10
  GNU_RELRO      0x01fed0 0x0000000000020ed0 0x0000000000020ed0 0x001130 0x001130 R   0x1

 Section to Segment mapping:
  Segment Sections...
   00     
   01     .interp 
   02     .interp .note.gnu.property .note.gnu.build-id .note.ABI-tag .note.package .gnu.hash .dynsym .dynstr .gnu.version .gnu.version_r .rela.dyn .rela.plt 
   03     .init .plt .plt.sec .text .fini 
   04     .rodata .eh_frame_hdr .eh_frame 
   05     .init_array .fini_array .data.rel.ro .dynamic .got .data .bss 
   06     .dynamic 
   07     .note.gnu.property 
   08     .note.gnu.build-id .note.ABI-tag .note.package 
   09     .note.gnu.property 
   10     .eh_frame_hdr 
   11     
   12     .init_array .fini_array .data.rel.ro .dynamic .got 
```

### Compile GCC and G++ differences

__gcc Compiler__

```sh
$ objdump -M intel -d hello.c.o

hello.c.o:     file format elf64-x86-64


Disassembly of section .init:

0000000000401000 <_init>:
  401000:	f3 0f 1e fa          	endbr64
  401004:	48 83 ec 08          	sub    rsp,0x8
  401008:	48 8b 05 d1 2f 00 00 	mov    rax,QWORD PTR [rip+0x2fd1]        # 403fe0 <__gmon_start__@Base>
  40100f:	48 85 c0             	test   rax,rax
  401012:	74 02                	je     401016 <_init+0x16>
  401014:	ff d0                	call   rax
  401016:	48 83 c4 08          	add    rsp,0x8
  40101a:	c3                   	ret

Disassembly of section .plt:

0000000000401020 <puts@plt-0x10>:
  401020:	ff 35 ca 2f 00 00    	push   QWORD PTR [rip+0x2fca]        # 403ff0 <_GLOBAL_OFFSET_TABLE_+0x8>
  401026:	ff 25 cc 2f 00 00    	jmp    QWORD PTR [rip+0x2fcc]        # 403ff8 <_GLOBAL_OFFSET_TABLE_+0x10>
  40102c:	0f 1f 40 00          	nop    DWORD PTR [rax+0x0]

0000000000401030 <puts@plt>:
  401030:	ff 25 ca 2f 00 00    	jmp    QWORD PTR [rip+0x2fca]        # 404000 <puts@GLIBC_2.2.5>
  401036:	68 00 00 00 00       	push   0x0
  40103b:	e9 e0 ff ff ff       	jmp    401020 <_init+0x20>

Disassembly of section .text:

0000000000401040 <_start>:
  401040:	f3 0f 1e fa          	endbr64
  401044:	31 ed                	xor    ebp,ebp
  401046:	49 89 d1             	mov    r9,rdx
  401049:	5e                   	pop    rsi
  40104a:	48 89 e2             	mov    rdx,rsp
  40104d:	48 83 e4 f0          	and    rsp,0xfffffffffffffff0
  401051:	50                   	push   rax
  401052:	54                   	push   rsp
  401053:	45 31 c0             	xor    r8d,r8d
  401056:	31 c9                	xor    ecx,ecx
  401058:	48 c7 c7 26 11 40 00 	mov    rdi,0x401126
  40105f:	ff 15 73 2f 00 00    	call   QWORD PTR [rip+0x2f73]        # 403fd8 <__libc_start_main@GLIBC_2.34>
  401065:	f4                   	hlt

0000000000401066 <.annobin_abi_note.c>:
  401066:	66 2e 0f 1f 84 00 00 	cs nop WORD PTR [rax+rax*1+0x0]
  40106d:	00 00 00 

0000000000401070 <_dl_relocate_static_pie>:
  401070:	f3 0f 1e fa          	endbr64
  401074:	c3                   	ret

0000000000401075 <.annobin__dl_relocate_static_pie.end>:
  401075:	66 2e 0f 1f 84 00 00 	cs nop WORD PTR [rax+rax*1+0x0]
  40107c:	00 00 00 
  40107f:	90                   	nop

0000000000401080 <deregister_tm_clones>:
  401080:	b8 10 40 40 00       	mov    eax,0x404010
  401085:	48 3d 10 40 40 00    	cmp    rax,0x404010
  40108b:	74 13                	je     4010a0 <deregister_tm_clones+0x20>
  40108d:	b8 00 00 00 00       	mov    eax,0x0
  401092:	48 85 c0             	test   rax,rax
  401095:	74 09                	je     4010a0 <deregister_tm_clones+0x20>
  401097:	bf 10 40 40 00       	mov    edi,0x404010
  40109c:	ff e0                	jmp    rax
  40109e:	66 90                	xchg   ax,ax
  4010a0:	c3                   	ret
  4010a1:	66 66 2e 0f 1f 84 00 	data16 cs nop WORD PTR [rax+rax*1+0x0]
  4010a8:	00 00 00 00 
  4010ac:	0f 1f 40 00          	nop    DWORD PTR [rax+0x0]

00000000004010b0 <register_tm_clones>:
  4010b0:	be 10 40 40 00       	mov    esi,0x404010
  4010b5:	48 81 ee 10 40 40 00 	sub    rsi,0x404010
  4010bc:	48 89 f0             	mov    rax,rsi
  4010bf:	48 c1 ee 3f          	shr    rsi,0x3f
  4010c3:	48 c1 f8 03          	sar    rax,0x3
  4010c7:	48 01 c6             	add    rsi,rax
  4010ca:	48 d1 fe             	sar    rsi,1
  4010cd:	74 11                	je     4010e0 <register_tm_clones+0x30>
  4010cf:	b8 00 00 00 00       	mov    eax,0x0
  4010d4:	48 85 c0             	test   rax,rax
  4010d7:	74 07                	je     4010e0 <register_tm_clones+0x30>
  4010d9:	bf 10 40 40 00       	mov    edi,0x404010
  4010de:	ff e0                	jmp    rax
  4010e0:	c3                   	ret
  4010e1:	66 66 2e 0f 1f 84 00 	data16 cs nop WORD PTR [rax+rax*1+0x0]
  4010e8:	00 00 00 00 
  4010ec:	0f 1f 40 00          	nop    DWORD PTR [rax+0x0]

00000000004010f0 <__do_global_dtors_aux>:
  4010f0:	f3 0f 1e fa          	endbr64
  4010f4:	80 3d 11 2f 00 00 00 	cmp    BYTE PTR [rip+0x2f11],0x0        # 40400c <completed.0>
  4010fb:	75 13                	jne    401110 <__do_global_dtors_aux+0x20>
  4010fd:	55                   	push   rbp
  4010fe:	48 89 e5             	mov    rbp,rsp
  401101:	e8 7a ff ff ff       	call   401080 <deregister_tm_clones>
  401106:	c6 05 ff 2e 00 00 01 	mov    BYTE PTR [rip+0x2eff],0x1        # 40400c <completed.0>
  40110d:	5d                   	pop    rbp
  40110e:	c3                   	ret
  40110f:	90                   	nop
  401110:	c3                   	ret
  401111:	66 66 2e 0f 1f 84 00 	data16 cs nop WORD PTR [rax+rax*1+0x0]
  401118:	00 00 00 00 
  40111c:	0f 1f 40 00          	nop    DWORD PTR [rax+0x0]

0000000000401120 <frame_dummy>:
  401120:	f3 0f 1e fa          	endbr64
  401124:	eb 8a                	jmp    4010b0 <register_tm_clones>

0000000000401126 <main>:
  401126:	55                   	push   rbp
  401127:	48 89 e5             	mov    rbp,rsp
  40112a:	bf 10 20 40 00       	mov    edi,0x402010
  40112f:	e8 fc fe ff ff       	call   401030 <puts@plt>
  401134:	b8 00 00 00 00       	mov    eax,0x0
  401139:	5d                   	pop    rbp
  40113a:	c3                   	ret

Disassembly of section .fini:

000000000040113c <_fini>:
  40113c:	f3 0f 1e fa          	endbr64
  401140:	48 83 ec 08          	sub    rsp,0x8
  401144:	48 83 c4 08          	add    rsp,0x8
  401148:	c3                   	ret
```

__g++ Compiler__

```sh
$ objdump -M intel -d hello.cpp.o

hello.cpp.o:     file format elf64-x86-64


Disassembly of section .init:

0000000000401000 <_init>:
  401000:	f3 0f 1e fa          	endbr64
  401004:	48 83 ec 08          	sub    rsp,0x8
  401008:	48 8b 05 d1 2f 00 00 	mov    rax,QWORD PTR [rip+0x2fd1]        # 403fe0 <__gmon_start__@Base>
  40100f:	48 85 c0             	test   rax,rax
  401012:	74 02                	je     401016 <_init+0x16>
  401014:	ff d0                	call   rax
  401016:	48 83 c4 08          	add    rsp,0x8
  40101a:	c3                   	ret

Disassembly of section .plt:

0000000000401020 <_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc@plt-0x10>:
  401020:	ff 35 ca 2f 00 00    	push   QWORD PTR [rip+0x2fca]        # 403ff0 <_GLOBAL_OFFSET_TABLE_+0x8>
  401026:	ff 25 cc 2f 00 00    	jmp    QWORD PTR [rip+0x2fcc]        # 403ff8 <_GLOBAL_OFFSET_TABLE_+0x10>
  40102c:	0f 1f 40 00          	nop    DWORD PTR [rax+0x0]

0000000000401030 <_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc@plt>:
  401030:	ff 25 ca 2f 00 00    	jmp    QWORD PTR [rip+0x2fca]        # 404000 <_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc@GLIBCXX_3.4>
  401036:	68 00 00 00 00       	push   0x0
  40103b:	e9 e0 ff ff ff       	jmp    401020 <_init+0x20>

Disassembly of section .text:

0000000000401040 <_start>:
  401040:	f3 0f 1e fa          	endbr64
  401044:	31 ed                	xor    ebp,ebp
  401046:	49 89 d1             	mov    r9,rdx
  401049:	5e                   	pop    rsi
  40104a:	48 89 e2             	mov    rdx,rsp
  40104d:	48 83 e4 f0          	and    rsp,0xfffffffffffffff0
  401051:	50                   	push   rax
  401052:	54                   	push   rsp
  401053:	45 31 c0             	xor    r8d,r8d
  401056:	31 c9                	xor    ecx,ecx
  401058:	48 c7 c7 26 11 40 00 	mov    rdi,0x401126
  40105f:	ff 15 73 2f 00 00    	call   QWORD PTR [rip+0x2f73]        # 403fd8 <__libc_start_main@GLIBC_2.34>
  401065:	f4                   	hlt

0000000000401066 <.annobin_abi_note.c>:
  401066:	66 2e 0f 1f 84 00 00 	cs nop WORD PTR [rax+rax*1+0x0]
  40106d:	00 00 00 

0000000000401070 <_dl_relocate_static_pie>:
  401070:	f3 0f 1e fa          	endbr64
  401074:	c3                   	ret

0000000000401075 <.annobin__dl_relocate_static_pie.end>:
  401075:	66 2e 0f 1f 84 00 00 	cs nop WORD PTR [rax+rax*1+0x0]
  40107c:	00 00 00 
  40107f:	90                   	nop

0000000000401080 <deregister_tm_clones>:
  401080:	b8 10 40 40 00       	mov    eax,0x404010
  401085:	48 3d 10 40 40 00    	cmp    rax,0x404010
  40108b:	74 13                	je     4010a0 <deregister_tm_clones+0x20>
  40108d:	b8 00 00 00 00       	mov    eax,0x0
  401092:	48 85 c0             	test   rax,rax
  401095:	74 09                	je     4010a0 <deregister_tm_clones+0x20>
  401097:	bf 10 40 40 00       	mov    edi,0x404010
  40109c:	ff e0                	jmp    rax
  40109e:	66 90                	xchg   ax,ax
  4010a0:	c3                   	ret
  4010a1:	66 66 2e 0f 1f 84 00 	data16 cs nop WORD PTR [rax+rax*1+0x0]
  4010a8:	00 00 00 00 
  4010ac:	0f 1f 40 00          	nop    DWORD PTR [rax+0x0]

00000000004010b0 <register_tm_clones>:
  4010b0:	be 10 40 40 00       	mov    esi,0x404010
  4010b5:	48 81 ee 10 40 40 00 	sub    rsi,0x404010
  4010bc:	48 89 f0             	mov    rax,rsi
  4010bf:	48 c1 ee 3f          	shr    rsi,0x3f
  4010c3:	48 c1 f8 03          	sar    rax,0x3
  4010c7:	48 01 c6             	add    rsi,rax
  4010ca:	48 d1 fe             	sar    rsi,1
  4010cd:	74 11                	je     4010e0 <register_tm_clones+0x30>
  4010cf:	b8 00 00 00 00       	mov    eax,0x0
  4010d4:	48 85 c0             	test   rax,rax
  4010d7:	74 07                	je     4010e0 <register_tm_clones+0x30>
  4010d9:	bf 10 40 40 00       	mov    edi,0x404010
  4010de:	ff e0                	jmp    rax
  4010e0:	c3                   	ret
  4010e1:	66 66 2e 0f 1f 84 00 	data16 cs nop WORD PTR [rax+rax*1+0x0]
  4010e8:	00 00 00 00 
  4010ec:	0f 1f 40 00          	nop    DWORD PTR [rax+0x0]

00000000004010f0 <__do_global_dtors_aux>:
  4010f0:	f3 0f 1e fa          	endbr64
  4010f4:	80 3d 55 30 00 00 00 	cmp    BYTE PTR [rip+0x3055],0x0        # 404150 <completed.0>
  4010fb:	75 13                	jne    401110 <__do_global_dtors_aux+0x20>
  4010fd:	55                   	push   rbp
  4010fe:	48 89 e5             	mov    rbp,rsp
  401101:	e8 7a ff ff ff       	call   401080 <deregister_tm_clones>
  401106:	c6 05 43 30 00 00 01 	mov    BYTE PTR [rip+0x3043],0x1        # 404150 <completed.0>
  40110d:	5d                   	pop    rbp
  40110e:	c3                   	ret
  40110f:	90                   	nop
  401110:	c3                   	ret
  401111:	66 66 2e 0f 1f 84 00 	data16 cs nop WORD PTR [rax+rax*1+0x0]
  401118:	00 00 00 00 
  40111c:	0f 1f 40 00          	nop    DWORD PTR [rax+0x0]

0000000000401120 <frame_dummy>:
  401120:	f3 0f 1e fa          	endbr64
  401124:	eb 8a                	jmp    4010b0 <register_tm_clones>

0000000000401126 <main>:
  401126:	55                   	push   rbp
  401127:	48 89 e5             	mov    rbp,rsp
  40112a:	be 10 20 40 00       	mov    esi,0x402010
  40112f:	bf 40 40 40 00       	mov    edi,0x404040
  401134:	e8 f7 fe ff ff       	call   401030 <_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc@plt>
  401139:	b8 00 00 00 00       	mov    eax,0x0
  40113e:	5d                   	pop    rbp
  40113f:	c3                   	ret

Disassembly of section .fini:

0000000000401140 <_fini>:
  401140:	f3 0f 1e fa          	endbr64
  401144:	48 83 ec 08          	sub    rsp,0x8
  401148:	48 83 c4 08          	add    rsp,0x8
  40114c:	c3                   	ret
```

An object dump for a specific section:

```sh
$ objdump -M intel -j .plt -d ls

hello.c.o:     file format elf64-x86-64


Disassembly of section .plt:

0000000000401020 <puts@plt-0x10>:
  401020:	ff 35 ca 2f 00 00    	push   QWORD PTR [rip+0x2fca]        # 403ff0 <_GLOBAL_OFFSET_TABLE_+0x8>
  401026:	ff 25 cc 2f 00 00    	jmp    QWORD PTR [rip+0x2fcc]        # 403ff8 <_GLOBAL_OFFSET_TABLE_+0x10>
  40102c:	0f 1f 40 00          	nop    DWORD PTR [rax+0x0]

0000000000401030 <puts@plt>:
  401030:	ff 25 ca 2f 00 00    	jmp    QWORD PTR [rip+0x2fca]        # 404000 <puts@GLIBC_2.2.5>
  401036:	68 00 00 00 00       	push   0x0
  40103b:	e9 e0 ff ff ff       	jmp    401020 <_init+0x20>

$ objdump -M intel -j .got -d ls

...

```

