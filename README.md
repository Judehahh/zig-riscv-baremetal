# zig-riscv-baremetal
A simple sample of riscv baremetal in zig.

Testing with `zig 0.11.0`

```
$ zig build
$ qemu-system-riscv32 -machine virt -nographic -bios zig-out/bin/hello.bin
```

## References
- https://www.ringtailsoftware.co.uk/zig-baremetal/
- https://github.com/plctlab/riscv-operating-system-mooc
- AI

