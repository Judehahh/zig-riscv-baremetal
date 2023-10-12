const UART_BASE_ADDR: usize = 0x10000000;

const RHR: usize = 0; // Receive Holding Register (read mode)
const THR: usize = 0; // Transmit Holding Register (write mode)
const DLL: usize = 0; // LSB of Divisor Latch (write mode)
const IER: usize = 1; // Interrupt Enable Register (write mode)
const DLM: usize = 1; // MSB of Divisor Latch (write mode)
const FCR: usize = 2; // FIFO Control Register (write mode)
const ISR: usize = 2; // Interrupt Status Register (read mode)
const LCR: usize = 3; // Line Control Register
const MCR: usize = 4; // Modem Control Register
const LSR: usize = 5; // Line Status Register
const MSR: usize = 6; // Modem Status Register
const SPR: usize = 7; // ScratchPad Register

fn readReg(offset: usize) u8 {
    const reg: *volatile u8 = @ptrFromInt(UART_BASE_ADDR + offset);
    const value = reg.*;

    return value;
}

fn writeReg(offset: usize, value: u8) void {
    const reg: *volatile u8 = @ptrFromInt(UART_BASE_ADDR + offset);
    reg.* = value;
}

pub fn uart_init() void {
    // disable interrupts.
    writeReg(IER, 0x00);

    // Setting baud rate.
    var lcr: u8 = readReg(LCR);
    writeReg(LCR, lcr | (1 << 7));
    writeReg(DLL, 0x03);
    writeReg(DLM, 0x00);

    // Continue setting the asynchronous data communication format.
    lcr = 0;
    writeReg(LCR, lcr | (3 << 0));
}

pub fn uart_putc(ch: c_char) void {
    while ((readReg(LSR) & (1 << 5)) == 0) {}
    writeReg(THR, ch);
}

pub fn uart_puts(str: []const u8) void {
    for (str) |b| {
        uart_putc(b);
    }
}
