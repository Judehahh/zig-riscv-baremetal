const uart = @import("uart.zig");

pub fn start_kernel() void {
    uart.uart_init();
    uart.uart_puts("Hello Zig!\n");
    while (true) {}
}
