const start_kernel = @import("kernel.zig").start_kernel;

export fn _start() callconv(.Naked) noreturn {
    asm volatile (
        \\    csrr t0, mhartid
        \\    mv tp, t0
        \\    bnez t0, park
        \\
        \\    la sp, _sstack
        \\
        \\    j _start_kernel
        \\
        \\park:
        \\    wfi
        \\    j park
    );
}

export fn _start_kernel() void {
    start_kernel();
}
