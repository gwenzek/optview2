const std = @import("std");
const log = std.log;

var glob_x: *X = undefined;

pub fn main() void {
    var x = X{ .x0 = 10 };
    glob_x = &x;
    const res = fn1(x);
    log.info("res: {d}", .{res});
}

const X = struct {
    x0: u64,

    fn foo(x: X) u64 {
        return x.x0 * 2;
    }
};

fn fn1(x: X) u64 {
    var a: u64 = 0;
    var i: u8 = 0;
    while (i < 100) : (i += 1) {
        a += x.foo();
    }
    return a;
}
