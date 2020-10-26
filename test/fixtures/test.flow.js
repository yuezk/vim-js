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

const regex = /\\\//;
const regex = /rv:([^\);\]]+)(\(\)|;)/;
const regex = /x(?=\))/;
const regex = /^(?:(?:https?|mailto|ftp):|[^:/?#]*(?:[/?#]|$))/

debugger;

const x = (): number => {
  const test = 1;
  return test;
}

function nullishTest() {
  const obj = { a: 'a' };
  console.log(obj.b ?? 'empty');
}

const a = '\\';
const b = 'abc \
def';
const c = `
ddd
\\\`
`;

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

new Foo.Bar(a ? b : c);
new Foo.Bar.Baz;

new Date();

decodeURIComponent()

function testRegexp() {
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
  let regex = /[^xyz\b\w^$\\]/
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
const str = tag()`<div></div>`;
const str2 = String.raw`${world}`;
const str2 = String().raw`\${world}`;
const str2 = String().raw`\\${world}`;
const str2 = String().raw`\\\${world}`;
const str2 = String().raw`\\\\${world}`;
const str2 = String['hello'].raw`hello, ${world}`;

++i;
i++;

function testFlowPrimitive() {
  // Boolean
  function acceptsBoolean(value: boolean, value2: Boolean) {
    // ...
  }

  // Number
  function acceptsNumber(value: number, value2: Number) {
    // ...
  }

  // String
  function acceptsString(value: string, valu2: String) {
    // ...
  }

  // null and void
  function acceptsNull(value: null, value2: void) {
    /* ... */
  }

  // Maybe types
  function acceptsMaybeString(value: ?string, value2: ?number) {
    // ...
  }

  function acceptsMaybeProp({ value }: { value: ?number }) {
    // ...
  }

  // Optional object properties 
  function acceptsObject(value: { foo?: string }) {
    // ...
  }

  // Optional function parameters
  function acceptsOptionalString(value?: string) {
    // ...
  }

  // Function parameters with defaults 
  function acceptsOptionalString(value: string = "foo") {
    // ...
  }

  // Symbols, not supported yet
}

function testFlowLiteral() {
  function acceptsLiteral(value: 2, value2: true, value3: false, value4: 'str') {
    // ...
  }

  // With union types
  function getColor(name: "success" | "warning" | "danger") {
    switch (name) {
      case "success" : return "green";
      case "warning" : return "yellow";
      case "danger"  : return "red";
    }
  }
}

function testFlowMixed() {
  // A group of different possible types:
  function stringifyBasicValue(value: string | number) {
    return '' + value;
  }

  // A type based on another type:
  function identity<T>(value: T): T {
    return value;
  }

  // An arbitrary type that could be anything:
  function getTypeOf(value: mixed): string {
    return typeof value;
  }
}

function testFlowAny() {
  function add(one: any, two: any): number {
    return one + two;
  }
}

function testFlowVariable() {
  var fooVar /* : number */ = 1;
  let fooLet /* : number */ = 1;
  var barVar: number = 2;
  let barLet: number = 2;
  var val3: boolean | string = obj.prop;
}

function testFlowFunction() {
  // Function Declarations 
  function method(str: string, bool?: boolean, ...nums: Array<number>): void {
    // ...
  }

  // Arrow function
  let method = (str: string, bool?: boolean, ...nums: Array<number>): void => {
    // ...
  };

  function method(callback: (error: Error | null, value: string | null) => void) {
    // ...
  }

  async function method(): Promise<number> {
    return 123;
  }

  function truthy(a, b): boolean %checks {
    return !!a && !!b;
  }

  function truthy(a, b): () => void %checks {
    return !!a && !!b;
  }

  function concat(a: ?string, b: ?string): string {
    if (truthy(a, b)) {
      return a + b;
    }
    return '';
  }

  function foo(x): string | number {
    if (isNumberOrString(x)) {
      return x + x;
    } else {
      return x.length; // no error, because Flow infers that x can only be an array
    }
  }

  function method(func: (...args: Array<Array<number>>) => any) {
    func(1, 2);     // Works.
    func("1", "2"); // Works.
    func({}, []);   // Works.
  }

  function method(obj: Function) {
    obj = 10;
  }
}

function testFlowObject() {
  var obj1: { foo: boolean } = { foo: true };
  var obj2: {
    foo: number,
      bar: boolean,
      baz: string,
  } = {
    foo: 1,
    bar: true,
    baz: 'three',
  };
  var obj: { foo?: boolean } = {};
  var foo: {| foo: string |} = { foo: "Hello" };

  type FooT = {| foo: string |};
  type BarT = {| bar: number |};

  type FooBarFailT = FooT & BarT;
  type FooBarT = {| ...FooT, ...BarT |};

  // Objects and maps
  var o: { [string]: number } = {};
  var obj: { [user_id: number]: string } = {};
  var obj: {
    size: number,
      [id: number]: [string, number]
  } = {
    size: 0
  };

  function method(obj: { [key: string]: any }) {
    obj.foo = 42;               // Works.
    let bar: boolean = obj.bar; // Works.
    obj.baz.bat.bam.bop;        // Works.
  }
}

function testFlowArray() {
  let arr: Array<number> = [1, 2, 3];
  let arr1: Array<boolean> = [true, false, true];
  let arr2: Array<string> = ["A", "B", "C"];
  let arr3: Array<mixed> = [1, true, "three"]
  let arr: number[] = [0, 1, 2, 3];
  let arr: ?number[] = [0, 1, 2, 3];
  // (?Type)[]
  let arr2: (?number)[] = [1, 2]; // Works!

  const readonlyArray: $ReadOnlyArray<number> = [1, 2, 3]
  const readonlyArray: $ReadOnlyArray<{x: number}> = [{x: 1}];
  const someOperation = (arr: Array<number | string>, arr2: $ReadOnlyArray<number | string>) => {
    // Here we could do `arr.push('a string')`
  }
}

function testFlowTuple() {
  let tuple1: [number] = [1];
  let tuple2: [number, boolean] = [1, true];
  let tuple3: [number, boolean, string] = [1, true, "three"];
}

function testFlowClass() {
  class MyClass {
    prop: number;
    method(value: string): number {
      this.prop = 42;
    }
  }

  class MyClass {
    static constant: number;
    static helper: (number) => number;
    method: number => number;
  }

  class MyClass<A, B, C> {
    property: A;
    constructor(arg1: A, arg2: B, arg3: C) {
    }
    method(val: B): C {
      // ...
    }
  }
}

function testFlowAlias() {
  // type Alias = Type;
  type NumberAlias = number;
  type ObjectAlias = {
    property: string,
    method(): number,
  };
  type UnionAlias = 1 | 2 | 3;
  type AliasAlias = ObjectAlias;

  type Test = Test2<{}>;


  // Type Alias Generics 
  type MyObject<A, B, C> = {
    property: A,
    method(val: B): C,
  };

  // opaque type Alias = Type;
  // opaque type Alias: SuperType = Type;
  opaque type StringAlias = string;
  opaque type ObjectAlias = {
    property: string,
    method(): number,
  };
  opaque type UnionAlias = 1 | 2 | 3;
  opaque type AliasAlias: ObjectAlias = ObjectAlias;
  opaque type VeryOpaque: AliasAlias = ObjectAlias;
  opaque type Good: {x: string} = {x: string, y: number};

  opaque type MyObject<A, B, C>: { foo: A, bar: B } = {
    foo: A,
    bar: B,
    baz: C,
  };

  declare opaque type Foo;
  declare opaque type PositiveNumber: number;
}

import type {NumberAlias} from './exports';
export opaque type NumberAlias = number;
export opaque type ID: string = string;

function testFlowInterface() {
  interface Serializable {
    serialize(): string;
  }

  interface MyInterface {
    property: string;
    property1?: string;
    method(value: string): number;
    [key: string]: number;
  }

  interface MyInterface<A, B, C> {
    property: A;
    method(val: B): C;
  }

  interface MyInterface {
    +covariant: number;     // read-only
    -contravariant: number; // write-only
    +readOnly: number | string;
  }

  class Foo implements Serializable {
    serialize() { return '[Foo]'; } // Works!
  }

  class Foo implements Bar, Baz {
    // ...
  }
}

function testFlowGeneric() {
  function identity<T>(value: T): T {
    return value;
  }

  type IdentityWrapper = {
    func<T>(T): T
  }

  // Functions with generics 
  function method<T>(param: T): T {
    // ...
  }

  function<T>(param: T): T {
    // ...
  }

  // Function types with generics
  function method(func: <T>(param: T) => T) {
    // ...
  }

  class Item<T> {
    prop: T;

    constructor(param: T) {
      this.prop = param;
    }

    method(): T {
      return this.prop;
    }
  }

  interface Item<T> {
    foo: T,
      bar: T,
  }

  function doSomething<T>(param: T): T {
    // ...
    return param;
  }

  const abcd = baz < bar && bar > (baz)
  const abcd = baz < bar || bar > (baz)
  doSomething<Array<number>>(3);
  doSomething<Array<number
    & string>>(3);
  doSomething<Array<{key: number
    | string}>>(3);

  class GenericClass<T> {}
  const c = new GenericClass<number>();

  class GenericClass<T, U, V>{}
  class GenericClass<T, U, V> implements IdentityWrapper {}

  const c = new GenericClass<_, number, _>()

  function constant<T>(value: T): () => T {
    return function(): T {
      return value;
    };
  }

  function logFoo<T: { foo: string }>(obj: T): T {
    console.log(obj.foo); // Works!
    return obj;
  }

  function identity<T: number>(value: T): T {
    return value;
  }

  function identity<T>(val: T): T {
    return val;
  }

  type Item<T> = {
    prop: T,
  }

  type Item<T: number = 1> = {
    prop: T,
  };

  let foo: Item<> = { prop: 1 };
  let bar: Item<2> = { prop: 2 };

  type GenericBox<+T> = T;
}

function testFlowUnion() {
  type Foo =
    | Type1
    | Type2
    | Type3


  type Numbers = 1 | 2;
  type Colors = 'red' | 'blue'
  type Fish = Numbers | Colors;

  type Success = {| success: true, value: boolean |};
  type Failed  = {| error: true, message: string |};
}

function testFlowIntersection() {
  type Foo =
    & Type1
    & Type2
    & TypeN

  type Foo = Type1 & Type2;


























































}

function testFlowTypeof() {
  let num1 = 42;
  let num2: typeof num1 = 3.14;    // Works!
}

function testFlowCast() {
  let val = (value: Type);
  let obj = { prop: (value: Type) };
  let arr = ([(value: Type), (value: Type)]: Array<Type>);
  let newValue = ((value: any): string);

  function cloneObject(obj) {
    const clone = {};

    (obj: { [key: string]: mixed });

    Object.keys(obj).forEach(key => {
      clone[key] = obj[key];
    });

    return ((clone: any): typeof obj); // <<
  }

  function cloneObject<T: { [key: string]: mixed }>(obj: T): $Shape<T> {
    // ...
  }
}

function testFlowUtilties() {
  type Country = $Keys<typeof countries>;
  type Prop$Values = $Values<Props>;

  type ReadOnlyObj = {
    +key: any,  // read-only field, marked by the `+` annotation
  };
  type ReadOnlyObj = $ReadOnly<{
    key: any,
  }>;
  type ReadOnlyProps = $ReadOnly<Props>;
  type MappedObj = $ReadOnly<$ObjMap<Obj, TypeFn>> // Still read-only

  type ExactUser = $Exact<{name: string}>;
  type ExactUserShorthand = {| name: string |};

  type RequiredProps = $Diff<Props, DefaultProps>;
  type B = $Diff<{}, {nope: number | void}>; // OK

  type C = $Rest<Props, {|age: number|}>

  const newName: $PropertyType<Person, 'name'> = 'Toni Braxton';
  const newAge: $PropertyType<Person, 'age'> = 51;
  const someProps: $PropertyType<Tooltip, 'props'> = {
    text: 'foo',
    onMouseOver: (data: {x: number, y: number}) => undefined
  };
  type PositionHandler = $PropertyType<$PropertyType<Tooltip, 'props'>, 'onMouseOver'>;

  ('Jon': $ElementType<Obj, 'name'>);
  (42: $ElementType<Obj, 'age'>);
  (true: $ElementType<Arr, number>);
  (42: $ElementType<$ElementType<NumberObj, 'nums'>, number>);
  function getProp<O: {+[string]: mixed}, P: $Keys<O>>(o: O, p: P): $ElementType<O, P> {
    return o[p];
  }

  type MaybeName = ?string;
  type Name = $NonMaybeType<MaybeName>;

  // let's write a function type that takes a `() => V` and returns a `V` (its return type)
  type ExtractReturnType = <V>(() => V) => V;
  declare function run<O: {[key: string]: Function}>(o: O): $ObjMap<O, ExtractReturnType>;
  declare function props<A, O: { [key: string]: A }>(promises: O): Promise<$ObjMap<O, typeof $await>>;

  type ExtractReturnObjectType = <K, V>(K, () => V) => { k: K, v: V };
  declare function run<O: Object>(o: O): $ObjMapi<O, ExtractReturnObjectType>;

  type ExtractReturnType = <V>(() => V) => V
  function run<A, I: Array<() => A>>(iter: I): $TupleMap<I, ExtractReturnType> {
    return iter.map(fn => fn());
  }

  // Takes an object type, returns the type of its `prop` key
  type ExtractPropType = <T>({prop: T}) => T;
  type Obj = {prop: number};
  type PropType = $Call<ExtractPropType, Obj>;  // Call `ExtractPropType` with `Obj` as an argument
  // Takes a function type, and returns its return type
  // This is useful if you want to get the return type of some function without actually calling it at runtime.
  type ExtractReturnType = <R>(() => R) => R;
  type Fn = () => number;
  type ReturnType = $Call<ExtractReturnType, Fn> // Call `ExtractReturnType` with `Fn` as an argument


  // Extracting deeply nested types:
  type NestedObj = {|
    +status: ?number,
    +data: ?$ReadOnlyArray<{|
      +foo: ?{|
        +bar: number,
      |},
    |}>,
  |};

  // If you wanted to extract the type for `bar`, you could use $Call:
  type BarType = $Call<
    <T>({
      +data: ?$ReadOnlyArray<{
        +foo: ?{
          +bar: ?T
        },
      }>,
    }) => T,
    NestedObj,
    >;
  // Using $Call, we can get the actual return type of the function above, without calling it at runtime:
  type Value = $Call<typeof getFirstValue, Map<string, number>>;

  // We could generalize it further:
  type GetMapValue<M> =
    $Call<typeof getFirstValue, M>;

  function makeParamStore<T>(storeClass: Class<ParamStore<T>>, data: T): ParamStore<T> {
    return new storeClass(data);
  }

  type Person = {
    age: number,
    name: string,
  }
  type PersonDetails = $Shape<Person>;

  import typeof * as T from 'my-module';
  type T = $Exports<'my-module'>;
  export type T = $Exports<'my-module'>;
  export type MyModuleType = T;


  // $Supertype<T> 
  // $Subtype<T> 
  // *
}

function testFlowModule() {
  export default class Foo {};
  export type MyObject = {
    /* ... */
  };
  export type Type = (
    // hi '
    arg: Arg,
  ) => Ret;
  export interface MyInterface { /* ... */ };

  const myNumber = 42;
  export default myNumber;
  export class MyClass {
    // ...
  }

  import type Foo, {MyObject, MyInterface} from './exports';
  import typeof myNumber from './exports';
  import typeof {MyClass} from './exports';
}

function testFlowDeclare() {
  declare module "some-es-module" {
    declare class URL {
      constructor(urlStr: string): URL;
      toString(): string;

      static compare(url1: URL, url2: URL): boolean;
    }

    // Declares a default export whose type is `typeof URL`
    declare export default typeof URL;
    declare export function concatPath(dirA: string, dirB: string): Path;
  }
}


function testFlowComment() {
  /*::
  type MyAlias = {
    foo: number,
    bar: boolean,
    baz: string,
  };
  */

    /*::
  declare module "some-es-module" {
    declare class URL {
      constructor(urlStr: string): URL;
      toString(): string;

      static compare(url1: URL, url2: URL): boolean;
    }

    // Declares a default export whose type is `typeof URL`
    declare export default typeof URL;
    declare export function concatPath(dirA: string, dirB: string): Path;
  }
  */

    function method(value /*: MyAlias */) /*: boolean */ {
      return value.bar;
    }

  class MyClass {
    /*:: prop: string; */
  }

  /*flow-include
  type Foo = {
    foo: number,
    bar: boolean,
    baz: string
  };
  */

    class MyClass {
      /*flow-include prop: string; */
    }

  function method(param /*:: : string */) /*:: : number */ {
    // ...
  }
}

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
  ({hello = 1, world: {hello: world}, bar} = {foo, bar: 'ddd', test})
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

  handleClick = () => {}

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

for (var i = 0; i < 100; i++) {
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
  throw new Error(a, b, ...d, a + b);
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
  // hello, comment
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
