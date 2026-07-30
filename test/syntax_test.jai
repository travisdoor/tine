// ============================================================
// JAI syntax highlighting test file
// Covers: comments, literals, declarations, procedures, control
// flow, structs, enums, unions, polymorphism, directives, etc.
// ============================================================

/* Block comment
   /* nested block comments are allowed in Jai */
   still inside outer comment */

#import "Basic";
#import "Math";
#load "another_file.jai";

// ------------------------------------------------------------
// Constants and basic declarations
// ------------------------------------------------------------

PI          :: 3.14159265;
MAX_ENTRIES :: 128;
GREETING    :: "hello, world";
IS_DEBUG    :: true;

x: int;                 // declaration, no initializer
y: int = 42;            // declaration with type and value
z := 42;                // inferred type
w : float = 3.14;
name: string = "Jonathan";
flag: bool = false;

// multiple declarations on one line
a, b, c: int = 1, 2, 3;

// ------------------------------------------------------------
// Numeric literals
// ------------------------------------------------------------

dec_int    := 12345;
neg_int    := -987;
hex_int    := 0xFF00_FF00;
bin_int    := 0b1010_1100;
oct_int    := 0o755;
float_val  := 3.14159;
float_exp  := 6.022e23;
float_neg  := -0.001;
big_u64    : u64 = 18_446_744_073_709_551_615;

// ------------------------------------------------------------
// Strings and characters
// ------------------------------------------------------------

simple_string  := "a plain string";
escaped_string := "line one\nline two\ttabbed\\backslash\"quote";
char_literal   := #char "A";

// raw / multi-line string
long_text := #string DONE
This is a raw multi-line
string with no escaping needed: \n stays literal.
DONE

// ------------------------------------------------------------
// Operators
// ------------------------------------------------------------

sum        := a + b;
diff       := a - b;
prod       := a * b;
quot       := a / b;
rem        := a % b;
bit_and    := a & b;
bit_or     := a | b;
bit_xor    := a ^ b;
bit_not    := ~a;
shift_l    := a << 2;
shift_r    := a >> 2;
logical    := (a > 0) && (b < 10) || !flag;
eq_check   := a == b;
ne_check   := a != b;
ptr_val    : *int = *y;
deref      := ptr_val.*;

// compound assignment
a += 1;
a -= 1;
a *= 2;
a /= 2;
a %= 2;

// ------------------------------------------------------------
// Arrays
// ------------------------------------------------------------

fixed_array   : [5] int;
inferred_size : [..] int;             // resizable array
view_array    : [] int;               // array view / slice
matrix        : [4][4] float;

fixed_array[0] = 10;
fixed_array[1] = 20;

for i: 0..4 {
    print("index: %\n", i);
}

for value, index: fixed_array {
    print("value % at index %\n", value, index);
}

// ------------------------------------------------------------
// Structs
// ------------------------------------------------------------

Vector3 :: struct {
    x, y, z: float;
}

Entity :: struct {
    using position: Vector3;   // using for embedding / composition
    name: string;
    health: int = 100;
    tags: [..] string;
}

operator + :: (a: Vector3, b: Vector3) -> Vector3 {
    result: Vector3 = ---;
    result.x = a.x + b.x;
    result.y = a.y + b.y;
    result.z = a.z + b.z;
    return result;
}

// ------------------------------------------------------------
// Enums and unions
// ------------------------------------------------------------

Direction :: enum {
    NORTH;
    SOUTH;
    EAST;
    WEST;
}

Status :: enum u8 {
    OK      :: 0;
    WARNING :: 1;
    ERROR   :: 2;
}

Value :: union {
    as_int:    int;
    as_float:  float;
    as_string: string;
}

// ------------------------------------------------------------
// Procedures
// ------------------------------------------------------------

add :: (a: int, b: int) -> int {
    return a + b;
}

divmod :: (a: int, b: int) -> int, int {
    return a / b, a % b;
}

greet :: (message: string = "hello") {
    print("%\n", message);
}

sum_all :: (values: ..int) -> int {
    total := 0;
    for v: values {
        total += v;
    }
    return total;
}

// polymorphic / generic procedure
identity :: (x: $T) -> T {
    return x;
}

max :: (a: $T, b: T) -> T {
    return ifx a > b then a else b;
}

// ------------------------------------------------------------
// Control flow
// ------------------------------------------------------------

if flag {
    print("flag is true\n");
} else if a > b {
    print("a is bigger\n");
} else {
    print("fallback\n");
}

while a < 10 {
    a += 1;
}

n := 0;
loop_label: while n < 5 {
    n += 1;
    if n == 3 continue;
    if n == 4 break;
}

// jai-style multi-branch "if-case"
if a == {
  case 1;
    print("one\n");
  case 2;
    print("two\n");
  case;
    print("something else\n");
}

// defer
cleanup_example :: () {
    file := "resource";
    defer print("cleaning up %\n", file);
    print("using %\n", file);
}

// ------------------------------------------------------------
// Compile-time / directives
// ------------------------------------------------------------

#if IS_DEBUG {
    print("debug build\n");
} else {
    print("release build\n");
}

#assert(MAX_ENTRIES > 0);

#run print("this runs at compile time\n");

log_call :: (message: string, loc := #caller_location) #expand {
    print("% (from %)\n", message, loc);
}

External_Func :: () -> int #foreign "some_lib";

// ------------------------------------------------------------
// Any / type introspection
// ------------------------------------------------------------

describe :: (value: Any) {
    t := type_of(value);
    print("type: %\n", t);
}

casted := cast(float) a;
casted2 : float = xx a;

// ------------------------------------------------------------
// Context
// ------------------------------------------------------------

main :: () {
    push_context context {
        print("inside pushed context\n");
    }

    v1: Vector3;
    v1.x = 1; v1.y = 2; v1.z = 3;
    v2 := Vector3.{4, 5, 6};
    v3 := v1 + v2;

    e: Entity;
    e.name = "Player";
    e.x = 0; e.y = 0; e.z = 0;   // works due to `using`

    status := Status.OK;
    dir := Direction.NORTH;

    val: Value;
    val.as_int = 42;

    result := add(1, 2);
    q, r := divmod(10, 3);
    greet();
    greet("custom message");
    total := sum_all(1, 2, 3, 4, 5);
    same := identity(99);
    biggest := max(3, 7);

    cleanup_example();
    describe(v1);

    print("done: % % % % % %\n", result, q, r, total, same, biggest);
}
