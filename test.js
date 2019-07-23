// Module test cases
import defaultExport from "module-name";
import * as name from "module-name";
import { export1 } from "module-name";
import { export1 as alias } from "module-name";
import { export1 , export2 } from "module-name";
import { foo , bar } from "module-name/path/to/specific/un-exported/file";
import { export1 , export2 as alias2 } from "module-name";
import defaultExport, { export1, export2 } from "module-name";
import defaultExport, * as name from "module-name";
import "module-name";

var promise = import("module-name");

const a = 1;
let b;
var a1, a2;
var a1 = 1, a3;
var a = { a: 1 }, c;

const a = (1 + 2) / 3;

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

// Functions
function test() {
	const str = "}";
	return func();
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
	const {hello: [a = 3, b, { d }], world: {hello: world}} = {foo: foo, bar: 'ddd', test}
	({hello = 1, world: {hello: world}, bar} = {foo, bar: 'ddd', test})

}

function* gen() {
	yield* gen()
	return 1;
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

const cls = class {
};

// Classes
class Square extends Polygon {
  // Comments
  /* Comments */
  static className = 'Square';
  length = 0;
  name;
  ['foo' + 'bar'] = 1

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
}

async function test () {
  a == 3
  const b = {};
  a instanceof 3
  const a = {
    prop1: 1,
    "prop2": 2,
    33: 3,
    shorthand,
    [foo + bar]: "computed",
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
    void: new Date(),
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
    },
    type: typeof 3,
    prop: await 3,
    ...b,
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
	wow = (2 + x) / 10
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

export default class Test {
  test = '<test>Test</test>'
}

const test =
  myFunction('<test>Test</test>');

type Test = {
  test: 'http://',
}
