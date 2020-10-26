#!/usr/bin/env node

// Module test cases
import defaultExport from "module-name";
import * as name from "module-name";
import { export1 /* comment*/ } from "module-name";
import { export1 as alias } from "module-name";
import { export1 , export2 } from "module-name";
import { foo , bar } from "module-name/path/to/specific/un-exported/file";
import { export1 , export2 as alias2 } from "module-name";
import defaultExport, { export1, export2 } from "module-name";
import defaultExport, * as name from "module-name";
import "module-name";
import { @logged } from './logged';
import @logged2 from './logged2';

var promise = import("module-name");

class Foo {
  foo = async x => {  
    try {
      console.log(x)   
      return x || {}
    } catch (e) {
      console.error(e)
    }
  }
}

function nullishTest() {
  const obj = { a: 'a' };
  console.log(obj.b ?? 'empty');
}

getPlayers()
::map(x => x.character(), ::this.getFoo())
::takeWhile(x => x.strength > 100)
::forEach(::console.log(x));

let log = ::console.log;

// ~this
const a = 1;
let b;
var a1, a2;
var a1 = 1, a3;
var a = { a: 1 }, c;

const a = (1 + 2) / 3;
const a = a > 0 ? a : b;
const b = a / b / d;
const a = a ? (a > 0 ? 1 : 0) : 0

const foo = maybe1 > maybe2
  ? "bar"
  : value1 > value2 ? "baz" : null;

a /= 3;

~a
new Foo.Bar(a ? b : c);
new Foo.Bar.Baz;

function testRegexp() {
  const test = /alskjdf/i;

  const math = 5 /
  2;
  
  5 /**/ / 100;

  let thisSyntaxIsBroken;

  const asdflkjasdf = 432432 / 23432;

  const fixed;
  // Assertions
  let regex = /First(?= test)/g;
  console.log(/\d+(?!\.)/g.exec('3.141')); // [ '141', index: 2, input: '3.141' ]
  let ripe_oranges = oranges.filter( fruit => fruit.match(/(?<=ripe )orange/));
  /(?<!-)\d+/.exec('3')

  // Boundaries
  let regex = /^abcd$/;
  let regex = /\bm/;
  let regex = /\Bon/;

  let regex = /\n\cM\x33\uDDDD\u{3333}\u{33333}/

  // Groups and Ranges
  let regex = /(foo)/	
  let regex = /(?:foo)/	
  let regex = /(?<name>foo)/
  let regex = /[^xyz\b\w^$]/
  let regex = /[-a-z^0-9-()-]?/
  let regex = /apple(,)\sorange\1\0/

  let regex = /x{1}y{1,}z{1,2}?/

  let regex = /\\\\\..*\b\w?\{}\?\*\(\)\|\[\]\^\$/

  // Unicode property escapes
  regex = /\p{Shorthand}/
  regex = /\p{UnicodePropertyName}/
  regex = /\p{UnicodePropertyName=UnicodePropertyValue}/
}

(function () {
  const regexp = /^[+-]?(?:(?:(?:(?:0|[1-9]\d*)\.\d*|\.\d+|(?:0|[1-9]\d*))(?:e[+-]?\d+)?)|0b[01]+|0o[0-7]+|0x[0-9a-f]+)$/i;

  const testCases = [
    0., 0.E1, 0.e-1,0.e0, 0.1, 0.12, 0.12e2, 0.12e-2,0.12E0,0.0e1, 0.0e-1, 0.0E0,
    1., 1.E1, 1.e-1,1.e0, 1.1, 1.12, 1.12e2, 1.12e-2,1.12E0,1.0e1, 1.0e-1, 1.0E0,
    1_0., 1_0_0., 1_0.0_1_2, 1_0_0, 100_000, 1e1_2, 1e+12_0, .1_2_3, .000_111, 10_1.1_2_3, 0.000_111, 0e0, 1_2e10,
    11., 12.E1, 13.e-1,144.e0, 155.1, 124.12, 14.12e2, 124.12e-2,10.12E0,100.0e1, 101.0e-1, 102.0E0,
    .0, .0e1, .0e-1, .0E0, .12, .12e1, .12e-1, .12E0,
    0, 0e1, 0e-1, 0E0, 1, 1e1, 1e-1, 1E0,
    0b0, 0b1, 0b0000, 0b111, 0b010101, 0b0_1, 0b0000_1111,
    0B0, 0B1, 0B0000, 0B111, 0B010101,
    0o0,0o01,0o02,0o07,0o7, 0o00_11, 0o0_1111_00,
    0O0,0O01,0O02,0O07,0O7,
    0x0, 0x01, 0xa, 0x1234abcdef, 0xf_ed_123, 0x1234_abcd_ef,
    0X0, 0X01, 0XA, 0X1234ABCDEF,
  ];

  testCases.forEach((num) => {
    console.assert(regexp.test(num), num);
  });
})();

var arr = [];
var arr = [a1, 1, false, null];
var arr = [1,2];
var arr = [1,];
var arr = [, 1];
var arr = [,,];
var arr = [
  first, // Comment
  second, /* Comment */
  [1, 2, 3],
  [,,,],
];

var a1 = arr[1];

const str = tag`<div></div>`;
const str = tag()`<div>${hello}</div>`;
const str2 = String.raw`hello, ${world}`;
const str2 = String().raw`hello, ${world}`;
const str2 = String['hello'].raw`hello, ${world}`;

++i;
i++;

// Functions
function test() {
  const str = "}";
  return Math.min([1, 2]);
}

function test(a = 3, b, c, ...rest, { e = 3, ...test}) {
  const a = "hello";
  function test() {
  }

  var arr = [];
  var arr = [a1, 1, false, null];
  var arr = [1,2];
  var arr = [1,];
  var arr = [, 1];
  var arr = [,,];
  var arr = [
    first, // Comment
    second, /* Comment */
    [1, 2, 3],
    [,,,],
  ];
  const [a,b,...rest] = [1, 2]
  const {hello: [a = 3, b, { d }], world: {hello: world}, foo = [{key: 1}], bar = { hello: 'world' }} = {foo: foo, bar: 'ddd', test}
  // ({hello = 1, world: {hello: world}, bar} = {foo, bar: 'ddd', test})
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //

  // 0000000000
}

function* gen() {
  yield* gen()
  return 1;
}

const foo = function* () {
  yield 10;
  yield 20;
}

const func = function(a, b) {
}

const func = function funName(a, [b, c, ...d]) {
}

test();

const a = () => {};
const b = () => 1;
const c = a => foo + bar;
const d = ({a : { d = 3}, b}, c, [a = 3, b, c]) => {
  return foo + bar;
};
const e = async (a, b) => {
};

((a, b) => {
})();

const cls = @logged class {
};

decorator @localMeta { @metadata("key", "value") }

@localMeta class C {
  @localMeta method() { }
}

// Classes
@defineElement('my-class')
class Square extends Polygon {
  // Comments
  /* Comments */
  static className = 'Square';
  @metadata
  length = 0;
  name
  foo = bar;
  ['foo' + 'bar'] = 1

  @logged(1)
  @logged(2)
  set x(value) {
  }

  constructor(length) {
    // Here, it calls the parent class' constructor with lengths
    // provided for the Polygon's width and height
    super(length, length);
    // Note: In derived classes, super() must be called before you
    // can use 'this'. Leaving this out will cause a reference error.
    this.name = 'Square';
  }

  async test() {
    const a = 0;
  }

  static *triple(n) {
    n = n || 1;
    return n * 3;
  }

  *toString() {
    return super.toString();
  }

  get area() {
    return this.height * this.width;
  }

  set area(value) {
    this.area = value;
  }

  foo = () => get();
  bar = a => a[0]

  getAccountIds = () => this?.props.filter.get('accountsIds')
    ? this.props.filter.get('accountIds').concat(this.props.accountFilter).toJS()
    : this.props.accountsFilter;
}

class Counter extends HTMLElement {
  #xValue = 0;

  get #x() { return #xValue; }
  set #x(value) {
    this.#xValue = value; 
    window.requestAnimationFrame(this.#render.bind(this));
  }

  #clicked() {
    this.#x++;
  }

  constructor() {
    super();
    this.onclick = this.#clicked.bind(this);
  }

  connectedCallback() { this.#render(); }

  #render() {
    this.textContent = this.#x.toString();
  }
}
window.customElements.define('num-counter', Counter);

async function test () {
  a == 3
  const b = {};
  a instanceof 3
  const a = {
    key: {
      // Comment
      /* comment */
      prop1: 1, // Comment
      "prop2": 2, /* comment */
      33: 3,
      shorthand,
      [foo + bar]: `computed${hello + world}b`,
      func: function () {
      },
      funcArrow: () => {
      },
      funcShort() {
      },
      async funcShort() {
      },
      [foo + bar]() {
        return "computed";
      },
      void: new Date(123, /hhh/)['getDate'](),
      delete: 'hello',
      *generator() {},
      *[Symbol.iterator]() {
      },
      get name() {
      },
      get [computed]() {
      },
      set name(a) {
      },
      set [computed]() {
        // 0000
      },
      type: typeof 3,
      prop: await 3,
      ...b,
      getAccountIds: () => this?.props?.filter.get('accountsIds')
      ? this.props?.filter?.get('accountIds')?.concat(this.props.accountFilter)?.toJS()
      : this.props.accountsFilter;
    }
  };
}

a[0];
(1)[0]
a()[0];
a()()[0];
a()()()[1]();

this["hll"];

({
  a = 3,
  b = Math.min(a, 100) / 3,
}) => {
  /* ... */
}

const another = ({
  wow = (2 + x) / 10,
  foo = /test/
}) => [wow, another]

const a = ({
  example: [
    x = 2 + 2,
    {
      another = ({wow = (2 + x) / 10}) => [wow, another]
    }
  ]
}) => {};


function someDefault() {}
export const a = ({first: f, second: s = someDefault(), c = 3}) => {
  return f + s;
}

const myVariable = "hello world";
const func = () => {
  funcd ();
};
const f = bad => {
  console.log();
};
const func = ({a, b}) => {
};
const func = funcCall(({
  sixthVariable = `create${a + b}`
}) => {
  return fun();
}, 1);

const a = a / 3;
/test/.test('test');

if (a > 0 && a / 3 && /test/.test(a)) return null;

if (a > 0 && b < 0 && a[0] > 0
  || (a() > 0) && [0, 1].length > 0
  && a in 'string'
  && a instanceof Date
  // ddd
  && typeof a === 'undefined'
) {
  const a = 0;
  console.log('else');
} else if {
  const a = 0;
  console.log('else if');
} else {
  console.log('else');
}

switch (expression) {
  case 1:
    console.log('hello');
    break;
  case "hello":
    console.log('hello');
    break;
  case "hello::world":
  case foo:
  case bar:
    break;
  default:
    break;
}

for (;;) console.log('hello');

for (var i = 0; i < 100 + 100; i++) {
  // Comment
  switch (expression) {
    case 1:
      console.log('hello');
      break;
    case "hello":
      console.log('hello');
      break;
    case "world":
    case foo:
    case bar:
      break;
    default:
      break;
  }
}

var arr = [3, 5, 7];
arr.foo = 'hello';

for (var i in arr) {
  console.log(i); // logs "0", "1", "2", "foo"
}

for (var i of arr) {
  console.log(i); // logs 3, 5, 7
}

for await (const x of asyncIterator) {
    console.log(x);
}

var a = 0;
do
  console.log(a++)
while (a < 0);

do {
  const b = 0;
  console.log(a++)
} while (a < 0);

while (theMark == true) {
  doSomething();
}

label:
const a = b;

label: {
  const hello = world;
}

func()?.prop	/* comment */
obj?.prop       // optional static property access
obj?.[expr]     // optional dynamic property access
obj?.[expr]?.func()     // optional dynamic property access
obj?.b()
Math.func?.(...args) // optional function or method call

const a = (a + b)

const a = b ?? 'hello';

var x = 0;
var z = 0;
labelCancelLoops: while (true) {
  console.log('Outer loops: ' + x);
  x += 1;
  z = 1;
  while (true) {
    console.log('Inner loops: ' + z);
    z += 1;
    if (z === 10 && x === 10) {
      break labelCancelLoops;
    } else if (z === 10) {
      continue labelCancelLoops;
    }
  }
}

var i = 0;
var j = 10;
checkiandj:
  while (i < 4) {
    console.log(i);
    i += 1;
    checkj:
    while (j > 4) {
      console.log(j);
      j -= 1;
      if ((j % 2) == 0) {
        continue checkj;
      }
      console.log(j + ' is odd.');
    }
    console.log('i = ' + i);
    console.log('j = ' + j);
  }

const myVariable = "hello world";
const checkHightlighting = funcCall(({
  firstVariable,
  secondVariable,
  thirdVariable,
  fourthVariable,
  fifthVariable = "createdObject",
  sixthVariable = `create${myVariable}`
}) => {
  return verify => {
    const noHighlightingHere = true;
    return verify(noHighlightingHere);
  };
},
  [myVariable]);

try {
  myroutine(); // may throw three types of exceptions
} catch (e if e instanceof TypeError) {
  // statements to handle TypeError exceptions
} catch (e if e instanceof RangeError) {
  // statements to handle RangeError exceptions
} catch (e if e instanceof EvalError) {
  // statements to handle EvalError exceptions
} catch (e) {
  // statements to handle any unspecified exceptions
  throw new Error(a, b, ...d);
} finally {
}

var a, x, y;
var r = 10;

with (Math) {
  a = PI * r * r;
  x = r * cos(PI);
  y = r * sin(PI / 2);
}

let name5;

export var name1, name2;
export var name3 = () => {}, name4 = function () {};
export function hello() {}
export class ClassName {}
export { name5, name2 as name6 };
// Exporting destructured assignments with renaming
export const { name7, name2: bar } = o;
export default function () {}
export { name as default };
export default name11 = 1;
export { default } from "other-module";

export * from "other-module";
export { name8, name9 } from "other-module";
export { import1 as name10, import2 as name12, nameN } from "other-module";

export decorator @logged {
  @wrap(f => {
    const name = f.name;
    function wrapped(...args) {
      console.log(`starting ${name} with arguments ${args.join(", ")}`);
      f.call(this, ...args);
      console.log(`ending ${name}`);
    }
    wrapped.name = name;
    return wrapped;
  })
}

export decorator @defineElement(name, options) {
  @register(klass => customElements.define(name, klass, options))
}
