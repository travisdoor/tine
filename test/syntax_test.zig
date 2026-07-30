//! Top-level doc comment for this file/module.
//! Zig syntax highlighting test file.

// Regular line comment.
/// Doc comment attached to the next declaration.
const std = @import("std");
const builtin = @import("builtin");

// ------------------------------------------------------------
// Constants and variables
// ------------------------------------------------------------

const PI: f64 = 3.14159265358979;
const MAX_ENTRIES: usize = 128;
const GREETING = "hello, world";
const IS_DEBUG = true;

var counter: i32 = 0;
var name: []const u8 = "Ziggy";
var uninitialized: i32 = undefined;

// ------------------------------------------------------------
// Numeric literals
// ------------------------------------------------------------

const dec_int: i32 = 12345;
const neg_int: i32 = -987;
const hex_int: u32 = 0xFF00_FF00;
const bin_int: u8 = 0b1010_1100;
const oct_int: u16 = 0o755;
const float_val: f64 = 3.14159;
const float_exp: f64 = 6.022e23;
const float_hex: f64 = 0x1.fp3;
const big_u64: u64 = 18_446_744_073_709_551_615;
const char_literal: u8 = 'A';
const escaped_char: u8 = '\n';

// ------------------------------------------------------------
// Strings
// ------------------------------------------------------------

const simple_string: []const u8 = "a plain string";
const escaped_string: []const u8 = "line one\nline two\ttabbed\\backslash\"quote";
const multiline_string =
    \\This is a multi-line string.
    \\Each line starts with \\ and
    \\newlines are inserted automatically.
;

// ------------------------------------------------------------
// Arrays, slices, tuples
// ------------------------------------------------------------

const fixed_array = [5]i32{ 1, 2, 3, 4, 5 };
const inferred_array = [_]i32{ 10, 20, 30 };
var dynamic_slice: []const i32 = fixed_array[0..3];
const matrix = [2][2]f32{
    [2]f32{ 1.0, 0.0 },
    [2]f32{ 0.0, 1.0 },
};
const tuple = .{ 1, "two", 3.0 };

// ------------------------------------------------------------
// Structs
// ------------------------------------------------------------

const Vector3 = struct {
    x: f32,
    y: f32,
    z: f32,

    const Self = @This();

    pub fn init(x: f32, y: f32, z: f32) Self {
        return Self{ .x = x, .y = y, .z = z };
    }

    pub fn add(self: Self, other: Self) Self {
        return Self{
            .x = self.x + other.x,
            .y = self.y + other.y,
            .z = self.z + other.z,
        };
    }
};

const PackedFlags = packed struct {
    active: bool,
    visible: bool,
    locked: bool,
    _padding: u5 = 0,
};

const ExternPoint = extern struct {
    x: c_int,
    y: c_int,
};

// anonymous struct literal
const anon = .{ .x = 1, .y = 2 };

// ------------------------------------------------------------
// Enums and unions
// ------------------------------------------------------------

const Direction = enum {
    north,
    south,
    east,
    west,

    pub fn opposite(self: Direction) Direction {
        return switch (self) {
            .north => .south,
            .south => .north,
            .east => .west,
            .west => .east,
        };
    }
};

const Status = enum(u8) {
    ok = 0,
    warning = 1,
    err = 2,
};

const Value = union(enum) {
    as_int: i64,
    as_float: f64,
    as_string: []const u8,
};

// ------------------------------------------------------------
// Error sets and error unions
// ------------------------------------------------------------

const MyError = error{
    OutOfMemory,
    InvalidInput,
    NotFound,
};

fn mightFail(x: i32) MyError!i32 {
    if (x < 0) return MyError.InvalidInput;
    return x * 2;
}

fn callMightFail() !void {
    const value = try mightFail(5);
    _ = value;

    const fallback = mightFail(-1) catch |e| blk: {
        std.debug.print("error: {}\n", .{e});
        break :blk 0;
    };
    _ = fallback;
}

// ------------------------------------------------------------
// Optionals
// ------------------------------------------------------------

fn findIndex(haystack: []const i32, needle: i32) ?usize {
    for (haystack, 0..) |item, i| {
        if (item == needle) return i;
    }
    return null;
}

fn useOptional() void {
    const maybe_index = findIndex(&[_]i32{ 1, 2, 3 }, 2);
    const idx = maybe_index orelse 0;
    _ = idx;

    if (maybe_index) |found| {
        std.debug.print("found at {d}\n", .{found});
    } else {
        std.debug.print("not found\n", .{});
    }
}

// ------------------------------------------------------------
// Functions, generics (comptime), varargs-like anytype
// ------------------------------------------------------------

fn add(a: i32, b: i32) i32 {
    return a + b;
}

fn max(comptime T: type, a: T, b: T) T {
    return if (a > b) a else b;
}

fn identity(value: anytype) @TypeOf(value) {
    return value;
}

pub fn genericContainer(comptime T: type) type {
    return struct {
        items: []T,
        count: usize,
    };
}

inline fn alwaysInline(x: i32) i32 {
    return x + 1;
}

export fn exportedFunction(x: c_int) callconv(.C) c_int {
    return x * 2;
}

extern fn externalFunction(x: c_int) c_int;

// ------------------------------------------------------------
// Control flow
// ------------------------------------------------------------

fn controlFlowDemo() void {
    var a: i32 = 0;

    if (IS_DEBUG) {
        a += 1;
    } else if (a > 10) {
        a -= 1;
    } else {
        a = 0;
    }

    while (a < 10) {
        a += 1;
    }

    var n: i32 = 0;
    outer: while (n < 5) {
        n += 1;
        if (n == 3) continue :outer;
        if (n == 4) break :outer;
    }

    for (0..5) |i| {
        std.debug.print("index: {d}\n", .{i});
    }

    const items = [_]i32{ 10, 20, 30 };
    for (items) |item| {
        std.debug.print("item: {d}\n", .{item});
    }

    const result = switch (a) {
        0 => "zero",
        1, 2, 3 => "small",
        4...9 => "medium",
        else => "large",
    };
    _ = result;

    const labeled_result = blk: {
        var sum: i32 = 0;
        for (items) |item| {
            sum += item;
        }
        break :blk sum;
    };
    _ = labeled_result;
}

// ------------------------------------------------------------
// defer / errdefer
// ------------------------------------------------------------

fn resourceDemo() !void {
    std.debug.print("acquiring resource\n", .{});
    defer std.debug.print("releasing resource\n", .{});

    errdefer std.debug.print("rolling back due to error\n", .{});

    if (false) return error.SomethingWentWrong;
}

// ------------------------------------------------------------
// Pointers
// ------------------------------------------------------------

fn pointerDemo() void {
    var value: i32 = 42;
    const ptr: *i32 = &value;
    ptr.* = 100;

    const const_ptr: *const i32 = &value;
    _ = const_ptr;

    var arr = [_]i32{ 1, 2, 3 };
    const many_ptr: [*]i32 = &arr;
    _ = many_ptr;
}

// ------------------------------------------------------------
// Comptime blocks
// ------------------------------------------------------------

const comptime_computed = blk: {
    comptime var total = 0;
    comptime var i = 0;
    while (i < 10) : (i += 1) {
        total += i;
    }
    break :blk total;
};

fn comptimeDemo(comptime N: usize) [N]i32 {
    var arr: [N]i32 = undefined;
    comptime var i = 0;
    inline while (i < N) : (i += 1) {
        arr[i] = i;
    }
    return arr;
}

// ------------------------------------------------------------
// Allocators (common idiom)
// ------------------------------------------------------------

fn allocatorDemo(allocator: std.mem.Allocator) !void {
    const buffer = try allocator.alloc(u8, 64);
    defer allocator.free(buffer);

    var list = std.ArrayList(i32).init(allocator);
    defer list.deinit();
    try list.append(1);
    try list.append(2);
}

// ------------------------------------------------------------
// Threadlocal, volatile, alignment
// ------------------------------------------------------------

threadlocal var thread_counter: i32 = 0;

var volatile_flag: bool align(4) = false;

// ------------------------------------------------------------
// Builtins
// ------------------------------------------------------------

fn builtinsDemo() void {
    const casted: i64 = @intCast(dec_int);
    const as_float: f64 = @floatFromInt(dec_int);
    const size = @sizeOf(Vector3);
    const type_name = @typeName(Vector3);
    _ = casted;
    _ = as_float;
    _ = size;
    _ = type_name;

    if (builtin.mode == .Debug) {
        std.debug.print("debug mode\n", .{});
    }
}

// ------------------------------------------------------------
// unreachable
// ------------------------------------------------------------

fn assertNever(x: i32) i32 {
    return switch (x) {
        0 => 100,
        else => unreachable,
    };
}

// ------------------------------------------------------------
// Tests
// ------------------------------------------------------------

test "addition works" {
    try std.testing.expect(add(2, 3) == 5);
}

test "vector addition" {
    const v1 = Vector3.init(1, 2, 3);
    const v2 = Vector3.init(4, 5, 6);
    const v3 = v1.add(v2);
    try std.testing.expectEqual(@as(f32, 5), v3.x);
}

// ------------------------------------------------------------
// Entry point
// ------------------------------------------------------------

pub fn main() !void {
    const gpa_allocator = std.heap.page_allocator;

    controlFlowDemo();
    useOptional();
    try resourceDemo();
    pointerDemo();
    builtinsDemo();
    try allocatorDemo(gpa_allocator);

    const sum = add(1, 2);
    const biggest = max(i32, 3, 7);
    const same = identity(99);
    const arr = comptimeDemo(5);

    std.debug.print("sum={d} biggest={d} same={d} arr={any}\n", .{ sum, biggest, same, arr });
}
