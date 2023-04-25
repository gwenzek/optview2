const C = extern struct {
    m_cond: bool,
};

export fn method1(self: C) void {
    var i: u8 = 0;
    while (i < 5) : (i += 1) {
        if (self.m_cond)
            f();
    }
}

extern fn f() void;
